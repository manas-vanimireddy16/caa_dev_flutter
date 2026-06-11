part of '../view.dart';

class RequestTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;
  final int actionItemCount;

  const RequestTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.actionItemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tabItem(
          title: "My Requests",
          isSelected: selectedIndex == 0,
          onTap: () => onTabChanged(0),
        ),
        _tabItem(
          title: "Action Items",
          isSelected: selectedIndex == 1,
          onTap: () => onTabChanged(1),
        ),
      ],
    );
  }

  Widget _tabItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
