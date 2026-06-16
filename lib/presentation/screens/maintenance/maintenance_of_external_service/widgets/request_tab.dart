part of '../view.dart';

class RequestTabs extends StatelessWidget {
  static const _activeTabColor = Color(0xFF1E3A5F);
  static const _inactiveTextColor = Color(0xFF676767);
  static const _borderColor = Color(0xFFD8D8D8);

  final int selectedIndex;
  final int actionItemCount;
  final Function(int) onTabChanged;

  const RequestTabs({
    super.key,
    required this.selectedIndex,
    required this.actionItemCount,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);

    return Row(
      children: [
        _tabButton(
          title: l10n.myRequests,
          icon: Icons.assignment_outlined,
          isSelected: selectedIndex == 0,
          onTap: () => onTabChanged(0),
        ),
        const SizedBox(width: 12),
        _tabButton(
          title: l10n.actionItems,
          icon: Icons.access_time,
          isSelected: selectedIndex == 1,
          count: actionItemCount,
          onTap: () => onTabChanged(1),
        ),
      ],
    );
  }

  Widget _tabButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    int? count,
  }) {
    final textColor = isSelected ? Colors.white : _inactiveTextColor;
    final iconColor = isSelected ? Colors.white : _inactiveTextColor;
    final showBadge = count != null && count > 0;

    return Expanded(
      child: Material(
        color: isSelected ? _activeTabColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isSelected
              ? BorderSide.none
              : const BorderSide(color: _borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 18, color: iconColor),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  3.toHorizontalSizedBox,
                  if (showBadge) _countBadge(count),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _countBadge(int count) {
    return Container(
      height: 22,
      width: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.errorRed,
        shape: BoxShape.circle,
        border: Border.all(
          color: selectedIndex == 0
              ? AppColors.actionItemCountRequestBorderColor
              : AppColors.actionItemActionBorderColor,
          width: 2,
        ),
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
