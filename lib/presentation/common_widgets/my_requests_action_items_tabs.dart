import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';

/// My Requests / Action Items tab row used on service list screens.
class MyRequestsActionItemsTabs extends StatelessWidget {
  static const _borderColor = Color(0xFFD8D8D8);

  final int selectedIndex;
  final int actionItemCount;
  final ValueChanged<int> onTabChanged;
  final String myRequestsLabel;
  final String actionItemsLabel;
  final IconData myRequestsIcon;
  final IconData actionItemsIcon;
  final bool actionItemsFirst;

  const MyRequestsActionItemsTabs({
    super.key,
    required this.selectedIndex,
    required this.actionItemCount,
    required this.onTabChanged,
    required this.myRequestsLabel,
    required this.actionItemsLabel,
    this.myRequestsIcon = Icons.assignment_outlined,
    this.actionItemsIcon = Icons.access_time,
    this.actionItemsFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    final firstTab = actionItemsFirst
        ? _TabSpec(
            title: actionItemsLabel,
            icon: actionItemsIcon,
            index: 0,
            count: actionItemCount,
          )
        : _TabSpec(title: myRequestsLabel, icon: myRequestsIcon, index: 0);
    final secondTab = actionItemsFirst
        ? _TabSpec(title: myRequestsLabel, icon: myRequestsIcon, index: 1)
        : _TabSpec(
            title: actionItemsLabel,
            icon: actionItemsIcon,
            index: 1,
            count: actionItemCount,
          );

    return Row(
      children: [
        _tabButton(
          title: firstTab.title,
          icon: firstTab.icon,
          isSelected: selectedIndex == firstTab.index,
          count: firstTab.count,
          onTap: () => onTabChanged(firstTab.index),
        ),
        const SizedBox(width: 12),
        _tabButton(
          title: secondTab.title,
          icon: secondTab.icon,
          isSelected: selectedIndex == secondTab.index,
          count: secondTab.count,
          onTap: () => onTabChanged(secondTab.index),
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
    final textStyle = isSelected
        ? AppTextStyles.myRequestsTabSelected()
        : AppTextStyles.myRequestsTabUnselected();
    final iconColor = isSelected ? AppColors.white : AppColors.grey50;
    final showBadge = count != null && count > 0;

    return Expanded(
      child: Material(
        color: isSelected ? AppColors.selectedTabColor : AppColors.white,
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
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
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
      decoration: const BoxDecoration(
        color: AppColors.actionItemCountBadgeColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TabSpec {
  final String title;
  final IconData icon;
  final int index;
  final int? count;

  const _TabSpec({
    required this.title,
    required this.icon,
    required this.index,
    this.count,
  });
}
