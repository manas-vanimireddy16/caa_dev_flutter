part of '../view.dart';

class TicketRequestsCard extends ConsumerStatefulWidget {
  final _VSControllerParams providerArgs;
  final FocusNode focusNode;
  final PageController pageController;

  const TicketRequestsCard({
    super.key,
    required this.providerArgs,
    required this.focusNode,
    required this.pageController,
  });

  @override
  ConsumerState<TicketRequestsCard> createState() =>
      _TicketRequestsCardState();
}

class _TicketRequestsCardState extends ConsumerState<TicketRequestsCard> {
  bool _suppressPageChanged = false;

  void _syncPageToTab(int index) {
    void jumpToTabPage() {
      if (!widget.pageController.hasClients) return;
      widget.pageController.jumpToPage(index);
    }

    _suppressPageChanged = true;
    jumpToTabPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jumpToTabPage();
      _suppressPageChanged = false;
    });
  }

  @override
  void initState() {
    super.initState();
    MyRequestsTabPageSyncRegistry.register(
      serviceId: widget.providerArgs.service.id,
      subServiceId: widget.providerArgs.subService.id,
      handler: _syncPageToTab,
    );
  }

  @override
  void dispose() {
    MyRequestsTabPageSyncRegistry.unregister(
      serviceId: widget.providerArgs.service.id,
      subServiceId: widget.providerArgs.subService.id,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(widget.providerArgs));
    final controller = ref.read(_vsProvider(widget.providerArgs).notifier);

    ref.listen(_vsProvider(widget.providerArgs).select((s) => s.tabIndex),
        (_, next) {
      _syncPageToTab(next);
    });

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ticket Requests",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: controller.openNewRequestForm,
                  child: const Text('New Request'),
                ),
              ],
            ),

            12.toHorizontalSizedBox,

            /// Search
            KTextField(
              focusNode: widget.focusNode,
              hintText: "Search by ID or Name",
              controller: controller.searchController,
              onChanged: controller.onSearchChanged,
            ),

            12.toHorizontalSizedBox,

            /// Tabs
            RequestTabs(
              selectedIndex: state.tabIndex,
              onTabChanged: (index) {
                widget.focusNode.unfocus();
                controller.searchController.clear();
                controller.onSearchChanged("");
                controller.updateTabIndex(index);

                widget.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),

            16.toHorizontalSizedBox,

            /// List
            SizedBox(
              height: 400,
              child: PageView(
                controller: widget.pageController,
                onPageChanged: (index) {
                  if (_suppressPageChanged) return;
                  widget.focusNode.unfocus();
                  controller.searchController.clear();
                  controller.onSearchChanged("");
                  controller.updateTabIndex(index);
                },
                children: [
                  RequestsPage(providerArgs: widget.providerArgs),
                  RequestsPage(providerArgs: widget.providerArgs),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
