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
    final serviceName = 'IT Services';

    /// ✅ WATCH ROLES (reactive)
    final rolesData = ref.watch(rolesControllerProvider);

    /// ✅ SAFE ACCESS
    final roles = rolesData?.services ?? [];

    /// ✅ GET MAIN SERVICE
    final Service service = roles.firstWhere(
      (r) => (r.name ?? '').trim() == serviceName,
      orElse: () => Service(),
    );

    /// ✅ MASTER CONFIG
    final config = [
      {
        "code": "HELP_DESK_SALALAH",
        "name": "Help Desk Salalah",
        "icon": KIcons.dashboard,
      },
      {
        "code": "HELP_DESK_MUSCAT",
        "name": "Help Desk Muscat",
        "icon": KIcons.playlistAddCheck,
      },
      {
        "code": "VPN_SERVICE",
        "name": "VPN Service",
        "icon": KIcons.playlistAddCheck,
      },
      {
        "code": "CAA059",
        "name": "Request Event Support",
        "icon": KIcons.playlistAddCheck,
      },
    ];

    final subServices = service.subservices ?? [];

    /// ✅ FILTER BASED ON ROLE
    final filteredItems = config.where((c) {
      return subServices.any((s) {
        final code = (s.code ?? '').toLowerCase().trim();
        final name = (s.subServiceName ?? '').toLowerCase().trim();

        return code == c["code"].toString().toLowerCase() ||
            name == c["name"].toString().toLowerCase();
      });
    }).toList();

    /// ✅ CONVERT TO DRAWER ITEMS
    final items = filteredItems
        .asMap()
        .entries
        .map(
          (entry) => DrawerItemData(
            index: entry.key,
            icon: KImageProvider(image: entry.value["icon"]),
            label: entry.value["name"].toString(),
          ),
        )
        .toList();

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
                serviceName,
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

        /// EMPTY STATE
        if (items.isEmpty)
          const Expanded(child: Center(child: Text("No services available")))
        else
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

                  /// 🔥 FINAL CORRECT LOGIC
                  onTap: () async {
                    final notifier = ref.read(rolesControllerProvider.notifier);

                    /// 🔥 VALIDATE FROM API
                    await notifier.fetchRoles();

                    final latestRoles = ref.read(rolesControllerProvider);
                    final latestServices = latestRoles?.services ?? [];

                    final latestService = latestServices.firstWhere(
                      (r) => (r.name ?? '').trim() == serviceName,
                      orElse: () => Service(),
                    );

                    final selectedConfig = filteredItems[i];

                    final subService = latestService.subservices?.firstWhere((
                      s,
                    ) {
                      final code = (s.code ?? '').toLowerCase().trim();
                      final name = (s.subServiceName ?? '')
                          .toLowerCase()
                          .trim();

                      return code ==
                              selectedConfig["code"].toString().toLowerCase() ||
                          name ==
                              selectedConfig["name"].toString().toLowerCase();
                    }, orElse: () => SubService());

                    /// ❌ SERVICE REMOVED
                    if (subService == null || (subService.code ?? '').isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Service no longer available"),
                        ),
                      );
                      return;
                    }

                    /// ✅ PROCEED
                    ref
                        .read(selectedServiceProvider.notifier)
                        .state = SelectedServiceState(
                      service: latestService,
                      subService: subService,
                    );

                    onItemTap(i);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
