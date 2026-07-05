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
  PagingController<int, PromotionsModel>? _pagingController;
  bool _controllerInitialized = false;
  VoidCallback? _disposeCleanup;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _disposeCleanup?.call();
    _pagingController?.dispose();
    super.dispose();
  }

  void _refreshList() {
    if (!mounted) return;
    _pagingController?.refresh();
  }

  void _ensureController(_VSController controller) {
    if (_controllerInitialized) return;
    _controllerInitialized = true;

    if (widget.isActionItemsTab) {
      _pagingController = PagingController<int, PromotionsModel>(
        getNextPageKey: (state) => ListPagination.nextPageKey(state),
        fetchPage: (pageKey) => controller.loadActionItemsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: controller.currentStatusFilter,
        ),
      );
      controller.onActionItemsListRefresh = _refreshList;
      _disposeCleanup = () => controller.onActionItemsListRefresh = null;
    } else {
      _pagingController = PagingController<int, PromotionsModel>(
        getNextPageKey: (state) => ListPagination.nextPageKey(state),
        fetchPage: (pageKey) => controller.loadMyRequestsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: controller.currentStatusFilter,
        ),
      );
      controller.onMyRequestsListRefresh = _refreshList;
      _disposeCleanup = () => controller.onMyRequestsListRefresh = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = ref.read(_vsProvider(widget.providerArgs).notifier);
    _ensureController(controller);

    return PaginatedListSection<PromotionsModel>(
      pagingController: _pagingController!,
      emptyMessage: widget.l10n.noDataFound,
      itemBuilder: (context, item, index) {
        return RequestCard(
          data: controller.buildRequestCardData(item),
          fieldLabelBuilder: widget.l10n.requestDetailsLabel,
          requestIdLabelBuilder: widget.l10n.requestIdLabel,
          statusLabelBuilder: widget.l10n.statusLabel,
          onTap: () async {
            await controller.openRequestDetails(
              item.base.id ?? 0,
              fromActionItems: widget.isActionItemsTab,
            );
          },
        );
      },
    );
  }
}
