part of '../view.dart';

/// ----------------------
/// Drawer menu widget
/// ----------------------
class _DrawerMenu extends StatelessWidget {
  final KThemeBox currentTheme;
  final int activeIndex;
  final ValueChanged<int> onItemTap;

  const _DrawerMenu({
    required this.currentTheme,
    required this.activeIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      DrawerItemData(
        index: 0,
        icon: KImageProvider(image: KIcons.dashboard),
        label: 'Dashboard',
      ),
      // DrawerItemData(
      //   index: 1,
      //   icon: KImageProvider(
      //     image: KIcons.playlistAddCheck,
      //     tintColor: Colors.black,
      //   ),
      //   label: 'Assignment Decision',
      // ),
      // DrawerItemData(
      //   index: 2,
      //   icon: KImageProvider(
      //     image: KIcons.playlistAddCheck,
      //     tintColor: Colors.black,
      //   ),
      //   label: 'Secondment Decision',
      // ),
      // DrawerItemData(
      //   index: 3,
      //   icon: KImageProvider(
      //     image: KIcons.playlistAddCheck,
      //     tintColor: Colors.black,
      //   ),
      //   label: 'Temporary Assignment Decision',
      // ),
      // DrawerItemData(
      //   index: 4,
      //   icon: KImageProvider(
      //     image: KIcons.playlistAddCheck,
      //     tintColor: Colors.black,
      //   ),
      //   label: 'Service Transfer',
      // ),
      // DrawerItemData(
      //   index: 5,
      //   icon: KImageProvider(
      //     image: KIcons.playlistAddCheck,
      //     tintColor: Colors.black,
      //   ),
      //   label: 'Duty Mission',
      // ),
    ];
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    debugPrint("BUILDING DRAWER MENU");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Header / profile section
        60.toVerticalSizedBox,
        KDrawerHeader(),
        20.toVerticalSizedBox,

        KDivider(color: Colors.grey, padding: EdgeInsets.zero),
        20.toVerticalSizedBox,

        Padding(
          padding: EdgeInsets.only(left: 10.toAutoScaledWidth),
          child: Row(
            children: [
              KImageProvider(
                image: KIcons.security,
                height: 20.toAutoScaledHeight,
                width: 20.toAutoScaledWidth,
                tintColor: Colors.black,
              ),
              16.toHorizontalSizedBox,
              Text(
                'HR Service',
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s16,
                  fontWeight: currentTheme.fontWeights.wBolder,
                  color: currentTheme.colors.onBackground,
                ),
              ),
            ],
          ),
        ),
        10.toVerticalSizedBox,

        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, i) {
              final item = items[i];
              final bool isSelected = item.index == activeIndex;

              return DrawerMenuItem(
                data: item,
                isSelected: isSelected,
                currentTheme: currentTheme,
                onTap: () => onItemTap(item.index),
              );
            },
          ),
        ),
      ],
    );
  }
}
