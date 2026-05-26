part of '../view.dart';

class TicketRequestsCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

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
                Text(
                  l10n.ticketRequests,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.openNewRequestForm,
                  child: Text(l10n.newRequest),
                ),
              ],
            ),

            12.toHorizontalSizedBox,

            /// Search
            KTextField(
              focusNode: focusNode,
              hintText: l10n.searchByIdOrName,
              controller: controller.searchController,
              onChanged: controller.onSearchChanged,
            ),

            12.toHorizontalSizedBox,

            /// Tabs
            RequestTabs(
              selectedIndex: state.tabIndex,
              actionItemCount: state.approvalKpiData?.data?.pending ?? 0,
              onTabChanged: (index) {
                focusNode.unfocus();
                controller.searchController.clear();
                controller.onSearchChanged("");
                controller.updateTabIndex(index);

                pageController.animateToPage(
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
                controller: pageController,
                onPageChanged: (index) {
                  focusNode.unfocus();
                  controller.searchController.clear();
                  controller.onSearchChanged("");
                  controller.updateTabIndex(index);
                },
                children: [
                  RequestsPage(providerArgs: providerArgs, l10n: l10n),
                  RequestsPage(providerArgs: providerArgs, l10n: l10n),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
