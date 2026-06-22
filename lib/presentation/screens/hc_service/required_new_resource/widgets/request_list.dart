part of '../view.dart';

class RequestsPage extends ConsumerStatefulWidget {
  final _VSControllerParams providerArgs;
  final bool isActionItemsTab;

  const RequestsPage({
    super.key,
    required this.providerArgs,
    required this.isActionItemsTab,
  });

  @override
  ConsumerState<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends ConsumerState<RequestsPage> {
  PagingController<int, RequiredNewResourceRequestModel>? _pagingController;
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
          PagingController<int, RequiredNewResourceRequestModel>(
        getNextPageKey: ListPagination.nextPageKey,
        fetchPage: (pageKey) => controller.loadActionItemsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: '',
        ),
      );
      controller.onActionItemsListRefresh = () => _pagingController?.refresh();
    } else {
      _pagingController =
          PagingController<int, RequiredNewResourceRequestModel>(
        getNextPageKey: ListPagination.nextPageKey,
        fetchPage: (pageKey) => controller.loadMyRequestsPage(
          pageKey,
          searchText: controller.searchController.text.trim(),
          status: '',
        ),
      );
      controller.onMyRequestsListRefresh = () => _pagingController?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(widget.providerArgs).notifier);
    _ensureController(controller);

    return PaginatedListSection<RequiredNewResourceRequestModel>(
      pagingController: _pagingController!,
      emptyMessage: 'No Data Found',
      itemBuilder: (context, item, index) {
        return RequestCard(
          data: controller.buildRequestCardData(item),
          onTap: () {
            controller.openRequestDetails(
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
