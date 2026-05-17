part of '../view.dart';

class RequestTabs extends StatelessWidget {
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
        _tabItem(
          title: l10n.myRequests,

          isSelected: selectedIndex == 0,

          onTap: () => onTabChanged(0),
        ),

        _tabItem(
          title: l10n.actionItems,

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
                      padding: const EdgeInsets.only(right: 16),

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
                      Positioned(
                        right: 0,

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
