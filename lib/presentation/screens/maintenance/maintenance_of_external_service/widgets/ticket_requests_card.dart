part of '../view.dart';

class TicketRequestsCard extends ConsumerWidget {
  static const _borderColor = Color(0xFFD8D8D8);
  static const _titleColor = Color(0xFF1A1A1A);
  static const _searchBgColor = Color(0xFFF5F5F5);
  static const _searchHintColor = Color(0xFF676767);
  static const _listIconBg = Color(0xFFEDE7F6);
  static const _listIconColor = Color(0xFF1E3A5F);
  static const _addButtonColor = Color(0xFF3B873E);

  final _VSControllerParams providerArgs;
  final FocusNode focusNode;
  final PageController pageController;

  const TicketRequestsCard({
    super.key,
    required this.providerArgs,
    required this.focusNode,
    required this.pageController,
  });

  String _screenTitle(DashboardL10n l10n) {
    final sub = providerArgs.subService;
    if (l10n.isArabic) {
      return sub.arabicsubServiceName ??
          sub.subServiceName ??
          l10n.ticketRequests;
    }
    return sub.subServiceName ?? l10n.ticketRequests;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _listIconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.format_list_bulleted,
                    color: _listIconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _screenTitle(l10n),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: _titleColor,
                      height: 1.25,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: _addButtonColor,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: controller.openNewRequestForm,
                    child: const SizedBox(
                      width: 36,
                      height: 36,
                      child: Icon(Icons.add, color: Colors.white, size: 22),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.more_vert, color: _titleColor, size: 22),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: _borderColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: RequestTabs(
              selectedIndex: state.tabIndex,
              actionItemCount: state.approvalKpiData?.data?.pending ?? 0,
              onTabChanged: (index) {
                focusNode.unfocus();
                controller.searchController.clear();
                controller.onSearchChanged('');
                controller.updateTabIndex(index);
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: KTextField(
              focusNode: focusNode,
              hintText: l10n.searchByIdOrName,
              controller: controller.searchController,
              onChanged: controller.onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: _searchHintColor),
                filled: true,
                fillColor: _searchBgColor,
                hintStyle: const TextStyle(color: _searchHintColor),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: _borderColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: SizedBox(
              height: 400,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  focusNode.unfocus();
                  controller.searchController.clear();
                  controller.onSearchChanged('');
                  controller.updateTabIndex(index);
                },
                children: [
                  RequestsPage(providerArgs: providerArgs, l10n: l10n),
                  RequestsPage(providerArgs: providerArgs, l10n: l10n),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
