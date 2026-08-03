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

class _RequestsPageState extends ConsumerState<RequestsPage> {
  PagingController<int, ComplaintLostPropertyRequestModel>? _pagingController;
  bool _controllerInitialized = false;

  @override
  void dispose() {
    _pagingController?.dispose();
    super.dispose();
  }

  void _ensureController(_VSController controller) {
    if (_controllerInitialized) return;
    _controllerInitialized = true;

    if (widget.isActionItemsTab) {
      _pagingController =
          PagingController<int, ComplaintLostPropertyRequestModel>(
        getNextPageKey: (state) =>
            ListPagination.nextPageKey(state),
        fetchPage: (pageKey) => controller.loadActionItemsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: ref
              .read(_vsProvider(widget.providerArgs))
              .actionItemsStatusFilter,
        ),
      );
      controller.onActionItemsListRefresh = () => _pagingController?.refresh();
    } else {
      _pagingController =
          PagingController<int, ComplaintLostPropertyRequestModel>(
        getNextPageKey: (state) =>
            ListPagination.nextPageKey(state),
        fetchPage: (pageKey) => controller.loadMyRequestsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: ref
              .read(_vsProvider(widget.providerArgs))
              .myRequestsStatusFilter,
        ),
      );
      controller.onMyRequestsListRefresh = () => _pagingController?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(widget.providerArgs).notifier);
    _ensureController(controller);

    ref.listen(
      _vsProvider(widget.providerArgs).select(
        (s) => widget.isActionItemsTab
            ? s.actionItemsStatusFilter
            : s.myRequestsStatusFilter,
      ),
      (_, __) => _pagingController?.refresh(),
    );

    return PaginatedListSection<ComplaintLostPropertyRequestModel>(
      pagingController: _pagingController!,
      emptyMessage: widget.l10n.noDataFound,
      itemBuilder: (context, item, index) {
        return RequestCard(
          data: controller.buildRequestCardData(item),
          fieldLabelBuilder: widget.l10n.fieldLabel,
          requestIdLabelBuilder: widget.l10n.requestIdLabel,
          onTap: () async {
            await controller.openRequestDetails(
              item.base?.id ?? 0,
              fromActionItems: widget.isActionItemsTab,
            );
          },
          onWorkflowTap: () async {
            await controller.openRequestDetails(
              item.base?.id ?? 0,
              fromActionItems: widget.isActionItemsTab,
              initialTabIndex: RequestDetailsTabIndex.workflow,
            );
          },
        );
      },
    );
  }
}
