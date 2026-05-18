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
    final serviceCode = 'CAAS01';

    final roles = KAppX.globalProvider.read(rolesProvider)?.services ?? [];

    /// ✅ GET MAIN SERVICE
    final Service service = roles.firstWhere(
      (r) => (r.code ?? '').trim() == serviceCode,
      orElse: () => Service(),
    );

    /// ✅ DRAWER ITEMS
    final items = [
      DrawerItemData(
        index: 0,
        icon: KImageProvider(image: KIcons.dashboard),
        label: 'Salalah',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        60.toVerticalSizedBox,
        KDrawerHeader(),
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
                'IT Services',
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

        /// LIST
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

                /// 🔥 MAIN LOGIC
                onTap: () {
                  /// 1️⃣ FIND SUBSERVICE FROM SERVICE
                  final subService = service.subservices?.firstWhere(
                    (s) =>
                        (s.code ?? '').toLowerCase().trim() ==
                        (item.label).toLowerCase().trim(),
                    orElse: () => SubService(),
                  );

                  /// 2️⃣ UPDATE GLOBAL PROVIDER
                  ref
                      .read(selectedServiceProvider.notifier)
                      .state = SelectedServiceState(
                    service: service,
                    subService: subService ?? SubService(),
                  );

                  /// 3️⃣ SWITCH TAB
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
