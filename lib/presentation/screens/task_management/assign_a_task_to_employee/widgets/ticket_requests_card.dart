part of '../view.dart';

class TicketRequestsCard extends ConsumerStatefulWidget {
  static const _borderColor = Color(0xFFD8D8D8);
  static const _titleColor = Color(0xFF1A1A1A);
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

  @override
  ConsumerState<TicketRequestsCard> createState() =>
      _TicketRequestsCardState();
}

class _TicketRequestsCardState extends ConsumerState<TicketRequestsCard> {
  bool _suppressPageChanged = false;

  String _screenTitle(DashboardL10n l10n) {
    final sub = widget.providerArgs.subService;
    if (l10n.isArabic) {
      return sub.arabicsubServiceName ??
          sub.subServiceName ??
          l10n.ticketRequests;
    }
    return sub.subServiceName ?? l10n.ticketRequests;
  }

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
    final l10n = DashboardL10n.of(context);
    ref.watch(rolesProvider); // rebuild when selected role changes
    final canRaiseRequest = controller.canRaiseRequest;

    ref.listen(_vsProvider(widget.providerArgs).select((s) => s.tabIndex),
        (_, next) {
      _syncPageToTab(next);
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TicketRequestsCard._borderColor),
      ),
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: TicketRequestsCard._listIconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.format_list_bulleted,
                    color: TicketRequestsCard._listIconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _screenTitle(l10n),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.serviceScreenTitle(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (canRaiseRequest)
                  Material(
                    color: TicketRequestsCard._addButtonColor,
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
                PopupMenuButton<String>(
                  tooltip: l10n.isArabic ? 'تصفية' : 'Filter',
                  padding: EdgeInsets.zero,
                  offset: const Offset(0, 40),
                  color: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(minWidth: 180),
                  onSelected: controller.onRequestStatusFilterChanged,
                  itemBuilder: (context) {
                    return _VSController.requestListStatusFilters.map((status) {
                      final isSelected =
                          controller.currentStatusFilter == status;
                      final label = controller.requestListStatusFilterLabel(
                        status,
                        l10n,
                      );

                      return PopupMenuItem<String>(
                        value: status,
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? TicketRequestsCard._listIconColor
                                      : TicketRequestsCard._titleColor,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check,
                                size: 18,
                                color: TicketRequestsCard._listIconColor,
                              ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.more_vert,
                      color: controller.currentStatusFilter.isNotEmpty
                          ? TicketRequestsCard._listIconColor
                          : TicketRequestsCard._titleColor,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SectionContentDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: RequestTabs(
              selectedIndex: state.tabIndex,
              actionItemCount: state.approvalKpiData?.data?.pending ?? 0,
              onTabChanged: (index) {
                widget.focusNode.unfocus();
                controller.searchController.clear();
                controller.onSearchChanged('');
                controller.updateTabIndex(index);
                widget.pageController.animateToPage(
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
              focusNode: widget.focusNode,
              hintText: l10n.searchByIdOrName,
              controller: controller.searchController,
              onChanged: controller.onSearchChanged,
              style: RequestListSearchStyles.textStyle(),
              decoration: RequestListSearchStyles.decoration(
                hintText: l10n.searchByIdOrName,
              ),
            ),
          ),
          if (controller.currentStatusFilter.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: TicketRequestsCard._listIconBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: TicketRequestsCard._listIconColor
                          .withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.filter_alt_outlined,
                        size: 16,
                        color: TicketRequestsCard._listIconColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller.requestListStatusFilterLabel(
                          controller.currentStatusFilter,
                          l10n,
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: TicketRequestsCard._listIconColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: SizedBox(
              height: 400,
              child: PageView(
                controller: widget.pageController,
                onPageChanged: (index) {
                  if (_suppressPageChanged) return;
                  widget.focusNode.unfocus();
                  controller.searchController.clear();
                  controller.onSearchChanged('');
                  controller.updateTabIndex(index);
                },
                children: [
                  RequestsPage(
                    providerArgs: widget.providerArgs,
                    l10n: l10n,
                    isActionItemsTab: false,
                  ),
                  RequestsPage(
                    providerArgs: widget.providerArgs,
                    l10n: l10n,
                    isActionItemsTab: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
