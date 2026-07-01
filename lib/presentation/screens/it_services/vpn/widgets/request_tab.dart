part of '../view.dart';

class RequestTabs extends StatelessWidget {
  final int selectedIndex;
  final int actionItemCount;
  final Function(int) onTabChanged;

  const RequestTabs({
    super.key,
    required this.selectedIndex,
    this.actionItemCount = 0,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);

    return MyRequestsActionItemsTabs(
      selectedIndex: selectedIndex,
      actionItemCount: actionItemCount,
      onTabChanged: onTabChanged,
      actionItemsFirst: true,
      myRequestsLabel: l10n.myTickets,
      actionItemsLabel: l10n.actionItems,
    );
  }
}