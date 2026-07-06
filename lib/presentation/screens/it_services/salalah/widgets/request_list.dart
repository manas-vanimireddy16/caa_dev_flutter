part of '../view.dart';

class RequestsPage extends ConsumerStatefulWidget {
  final _VSControllerParams providerArgs;
  final DashboardL10n l10n;
  final bool isActionItemsTab;

  const RequestsPage({
    super.key,
    required this.providerArgs,
    required this.l10n,
    required this.isActionItemsTab,
  });

  @override
  ConsumerState<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends ConsumerState<RequestsPage>
    with AutomaticKeepAliveClientMixin {
  PagingController<int, SalalahRequestModel>? _myRequestsController;
  PagingController<int, ApprovalData>? _actionItemsController;
  VoidCallback? _disposeCleanup;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _disposeCleanup?.call();
    _myRequestsController?.dispose();
    _actionItemsController?.dispose();
    super.dispose();
  }

  void _refreshList() {
    if (!mounted) return;
    if (widget.isActionItemsTab) {
      _actionItemsController?.refresh();
    } else {
      _myRequestsController?.refresh();
    }
  }

  void _ensureController(_VSController controller) {
    if (widget.isActionItemsTab) {
      if (_actionItemsController != null) return;
      _actionItemsController = PagingController<int, ApprovalData>(
        getNextPageKey: (state) => ItHelpdeskListPagination.nextPageKey(state),
        fetchPage: (pageKey) => controller.loadActionItemsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: ref
              .read(_vsProvider(widget.providerArgs))
              .actionItemsStatusFilter,
        ),
      );
      controller.onActionItemsListRefresh = _refreshList;
      _disposeCleanup = () => controller.onActionItemsListRefresh = null;
      return;
    }

    if (_myRequestsController != null) return;
    _myRequestsController = PagingController<int, SalalahRequestModel>(
      getNextPageKey: (state) => ItHelpdeskListPagination.nextPageKey(state),
      fetchPage: (pageKey) => controller.loadMyRequestsPage(
        pageKey,
        searchText: controller.searchController.text.trim(),
        status:
            ref.read(_vsProvider(widget.providerArgs)).myRequestsStatusFilter,
      ),
    );
    controller.onMyRequestsListRefresh = _refreshList;
    _disposeCleanup = () => controller.onMyRequestsListRefresh = null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = ref.read(_vsProvider(widget.providerArgs).notifier);
    _ensureController(controller);

    ref.listen(
      _vsProvider(widget.providerArgs).select(
        (s) => widget.isActionItemsTab
            ? s.actionItemsStatusFilter
            : s.myRequestsStatusFilter,
      ),
      (_, __) => _refreshList(),
    );

    if (widget.isActionItemsTab) {
      return PaginatedListSection<ApprovalData>(
        pagingController: _actionItemsController!,
        emptyMessage: widget.l10n.noDataFound,
        itemBuilder: (context, item, index) {
          return RequestCard(
            data: controller.buildActionItemCardData(item),
            fieldLabelBuilder: widget.l10n.fieldLabel,
            requestIdLabelBuilder: widget.l10n.requestIdLabel,
            onTap: () async {
              await controller.openRequestDetails(
                item.request?.id ?? 0,
                fromActionItems: true,
              );
            },
          );
        },
      );
    }

    return PaginatedListSection<SalalahRequestModel>(
      pagingController: _myRequestsController!,
      emptyMessage: widget.l10n.noDataFound,
      itemBuilder: (context, item, index) {
        return RequestCard(
          data: controller.buildRequestCardData(item),
          fieldLabelBuilder: widget.l10n.fieldLabel,
          requestIdLabelBuilder: widget.l10n.requestIdLabel,
          onTap: () async {
            await controller.openRequestDetails(
              item.base?.id ?? 0,
              fromActionItems: false,
            );
          },
        );
      },
    );
  }
}
