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
  PagingController<int, SkillsEnhancementModel>? _pagingController;
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
      _pagingController = PagingController<int, SkillsEnhancementModel>(
        getNextPageKey: ListPagination.nextPageKey,
        fetchPage: (pageKey) => controller.loadActionItemsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: controller.currentStatusFilter,
        ),
      );
      controller.onActionItemsListRefresh = () => _pagingController?.refresh();
    } else {
      _pagingController = PagingController<int, SkillsEnhancementModel>(
        getNextPageKey: ListPagination.nextPageKey,
        fetchPage: (pageKey) => controller.loadMyRequestsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: controller.currentStatusFilter,
        ),
      );
      controller.onMyRequestsListRefresh = () => _pagingController?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(widget.providerArgs).notifier);
    _ensureController(controller);

    return PaginatedListSection<SkillsEnhancementModel>(
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
            controller.updateTabIndex(0);
          },
        );
      },
    );
  }
}
