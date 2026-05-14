part of '../view.dart';

class _DrawerMenu extends ConsumerWidget {
  final KThemeBox currentTheme;
  final int activeIndex;
  final ValueChanged<int> onItemTap;

  const _DrawerMenu({
    required this.currentTheme,
    required this.activeIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const serviceCode = 'CAAS010';

    final roles = KAppX.globalProvider.read(rolesProvider)?.services ?? [];

    /// ✅ FIND MAIN SERVICE BY CODE
    final Service service = roles.firstWhere(
      (r) => (r.code ?? '').trim() == serviceCode,
      orElse: () => Service(),
    );

    /// ✅ DRAWER ITEMS
    final items = [
      DrawerItemData(
        index: 0,
        icon: KImageProvider(image: KIcons.dashboard),
        label: 'Request A Vehicle: Daily/Emergency',
        code: 'CAA031',
      ),

      DrawerItemData(
        index: 1,
        icon: KImageProvider(image: KIcons.dashboard),
        label: 'Transportation for Foreign Employee',
        code: 'CAA032',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        60.toVerticalSizedBox,

        const KDrawerHeader(),

        20.toVerticalSizedBox,

        KDivider(color: Colors.grey, padding: EdgeInsets.zero),

        20.toVerticalSizedBox,

        /// HEADER
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
                service.name ?? '',
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

        /// MENU LIST
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

                onTap: () {
                  /// ✅ FIND SUBSERVICE BY CODE
                  final SubService subService =
                      service.subservices?.firstWhere(
                        (s) =>
                            (s.code ?? '').trim() == (item.code ?? '').trim(),
                        orElse: () => SubService(),
                      ) ??
                      SubService();

                  /// ✅ UPDATE GLOBAL STATE
                  ref
                      .read(selectedServiceProvider.notifier)
                      .state = SelectedServiceState(
                    service: service,
                    subService: subService,
                  );

                  /// ✅ CHANGE TAB
                  onItemTap(item.index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
