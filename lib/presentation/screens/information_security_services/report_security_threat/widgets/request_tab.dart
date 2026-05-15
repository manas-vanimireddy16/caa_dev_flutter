part of '../view.dart';

class RequestTabs extends StatelessWidget {
  final int selectedIndex;

  final int actionItemCount;

  final Function(int) onTabChanged;
  final String myRequestsLabel;
  final String actionItemsLabel;

  const RequestTabs({
    super.key,
    this.selectedIndex = 0,
    required this.actionItemCount,
    required this.onTabChanged,
    this.myRequestsLabel = 'My Requests',
    this.actionItemsLabel = 'Action Items',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tabItem(
          title: myRequestsLabel,
          isSelected: selectedIndex == 0,
          onTap: () => onTabChanged(0),
        ),

        _tabItem(
          title: actionItemsLabel,

          count: actionItemCount,

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

    int? count,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 55,

          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue : Colors.grey.shade300,

                width: 2,
              ),
            ),
          ),

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Stack(
                  clipBehavior: Clip.none,

                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: Text(
                        title,

                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 15,

                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),

                    /// Notification Badge
                    if (count != null && count > 0)
                      PositionedDirectional(
                        end: 0,
                        top: -10,

                        child: Container(
                          height: 20,

                          width: 20,

                          alignment: Alignment.center,

                          decoration: const BoxDecoration(
                            color: Colors.red,

                            shape: BoxShape.circle,
                          ),

                          child: Text(
                            count > 99 ? '99+' : count.toString(),

                            style: const TextStyle(
                              color: Colors.white,

                              fontSize: 10,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
