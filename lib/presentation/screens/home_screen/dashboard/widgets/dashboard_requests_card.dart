part of '../view.dart';

class DashboardRequestsCard extends ConsumerStatefulWidget {
  const DashboardRequestsCard({super.key});

  @override
  ConsumerState<DashboardRequestsCard> createState() =>
      _DashboardRequestsCardState();
}

class _DashboardRequestsCardState extends ConsumerState<DashboardRequestsCard> {
  static const _primary = Color(0xFF26285F);
  static const _border = Color(0xFFD8D8D8);
  static const _muted = Color(0xFF676767);
  static const _iconBackground = Color(0xFFF3EFFF);

  final _searchController = TextEditingController();
  int _selectedTab = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() => _selectedTab = index);
    _searchController.clear();
  }

  void _search(String value) {
    final controller = ref.read(_vsProvider.notifier);
    if (_selectedTab == 0) {
      controller.fetchRequests(searchText: value.trim());
    } else {
      controller.fetchActionItems(searchText: value.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider);
    final l10n = DashboardL10n.of(context);
    final items = _selectedTab == 0 ? state.requestData : state.actionItems;
    final isLoading = _selectedTab == 0
        ? state.isRequestLoading
        : state.isActionItemLoading;
    final error = _selectedTab == 0
        ? state.requestError
        : state.actionItemError;

    return Container(
      // margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _iconBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.format_list_bulleted,
                    color: _primary,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Approvals',
                    style: AppTextStyles.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () => _search(_searchController.text),
                //   icon: const Icon(Icons.more_vert, color: _muted),
                //   tooltip: 'Refresh',
                // ),
              ],
            ),
          ),
          const Divider(height: 1, color: _border, indent: 15, endIndent: 13),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                Expanded(
                  child: _DashboardRequestTab(
                    label: l10n.myRequests,
                    icon: Icons.assignment_outlined,
                    selected: _selectedTab == 0,
                    onTap: () => _selectTab(0),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _DashboardRequestTab(
                    label: l10n.actionItems,
                    icon: Icons.schedule_outlined,
                    count: state.actionItems.length,
                    selected: _selectedTab == 1,
                    onTap: () => _selectTab(1),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _search(value);
              },
              decoration: InputDecoration(
                hintText: l10n.searchByIdOrName,
                hintStyle: AppTextStyles.cairo(color: _muted, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: _muted),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: _DashboardRequestList(
              items: items,
              isLoading: isLoading,
              error: error,
              onRetry: () => _search(_searchController.text),
              emptyLabel: l10n.noDataFound,
              fromActionItems: _selectedTab == 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardRequestTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final int? count;
  final VoidCallback onTap;

  const _DashboardRequestTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _DashboardRequestsCardState._primary : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: _DashboardRequestsCardState._border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: selected
                    ? Colors.white
                    : _DashboardRequestsCardState._muted,
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cairo(
                    color: selected
                        ? Colors.white
                        : _DashboardRequestsCardState._muted,
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
              if ((count ?? 0) > 0) ...[
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE53935),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count.toString(),
                    style: AppTextStyles.cairo(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardRequestList extends StatelessWidget {
  final List<DashboardRequestModel> items;
  final bool isLoading;
  final String error;
  final String emptyLabel;
  final VoidCallback onRetry;
  final bool fromActionItems;

  const _DashboardRequestList({
    required this.items,
    required this.isLoading,
    required this.error,
    required this.emptyLabel,
    required this.onRetry,
    required this.fromActionItems,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error.isNotEmpty) {
      return Center(
        child: TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Unable to load requests. Try again'),
        ),
      );
    }
    if (items.isEmpty) {
      return Center(child: Text(emptyLabel));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final base = item.base;
        return RequestCard(
          onTap: () => navigateToDashboardRequestDetails(
            subServiceCode: item.subServiceCode ?? item.subService?.code ?? '',
            requestId:
                int.tryParse(item.requestId ?? '') ?? base?.id ?? item.id ?? 0,
            service: item.service,
            subService: item.subService,
            fromActionItems: fromActionItems,
          ),
          data: {
            'request_id': item.requestId ?? base?.id ?? item.id ?? '-',
            'request_name':
                base?.subService?.subServiceName ?? base?.service?.name ?? '-',
            // 'requested_by': base?.createdByUser?.employeeName ?? '-',
            'date': base?.createdAt?.toIso8601String() ?? '-',
            'status':
                (base?.status?.toLowerCase().replaceAll('_', ' ') ==
                    'in progress')
                ? 'Pending'
                : base?.status,
          },
        );
      },
    );
  }
}
