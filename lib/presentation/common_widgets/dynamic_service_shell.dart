import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/drawer_component.dart';
import 'package:code_setup/presentation/core/providers/selected_service_provider.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/assets/icons.dart';
import 'package:code_setup/utils/helper/sub_service_route_resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicServiceShell extends ConsumerStatefulWidget {
  final Service service;
  final PageRouteInfo<dynamic>? dashboardRoute;

  const DynamicServiceShell({
    super.key,
    required this.service,
    this.dashboardRoute,
  });

  @override
  ConsumerState<DynamicServiceShell> createState() =>
      _DynamicServiceShellState();
}

class _DynamicServiceShellState extends ConsumerState<DynamicServiceShell> {
  bool _hasAppliedInitialSelection = false;

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;
    final destinations = SubServiceRouteResolver.destinationsFor(
      widget.service,
    ).where((destination) => destination.isSupported).toList(growable: false);
    final routes = <PageRouteInfo<dynamic>>[
      if (widget.dashboardRoute != null) widget.dashboardRoute!,
      ...destinations.map((destination) => destination.route!),
    ];

    if (routes.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No supported sub-services available')),
      );
    }

    return AutoTabsRouter.builder(
      routes: routes,
      builder: (tabsContext, children, tabsRouter) {
        if (!_hasAppliedInitialSelection) {
          _hasAppliedInitialSelection = true;
          final selected = ref.read(selectedServiceProvider);
          final selectedCode = (selected.subService.code ?? '').trim();
          final selectedIndex = destinations.indexWhere(
            (destination) =>
                (destination.subService.code ?? '').trim() == selectedCode,
          );

          if (selectedIndex >= 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) tabsRouter.setActiveIndex(selectedIndex + 1);
            });
          }
        }

        final activeIndex = tabsRouter.activeIndex;
        final activeTitle = activeIndex == 0
            ? 'Dashboard'
            : destinations[activeIndex - 1].subService.subServiceName ??
                  destinations[activeIndex - 1].subService.code ??
                  'Service';

        return Scaffold(
          backgroundColor: theme.colors.background,
          appBar: KAppBar(
            leading: Builder(
              builder: (drawerContext) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(drawerContext).openDrawer(),
              ),
            ),
            title: Text(
              activeTitle,
              style: TextStyle(
                fontSize: theme.fontSizes.s16,
                fontWeight: theme.fontWeights.wBold,
              ),
            ),
          ),
          drawer: KDrawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.toVerticalSizedBox,
                const KDrawerHeader(),
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
                      Expanded(
                        child: Text(
                          widget.service.name ?? '',
                          style: TextStyle(
                            fontSize: theme.fontSizes.s16,
                            fontWeight: theme.fontWeights.wBolder,
                            color: theme.colors.onBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                10.toVerticalSizedBox,
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: destinations.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return DrawerMenuItem(
                          data: DrawerItemData(
                            index: 0,
                            icon: KImageProvider(image: KIcons.dashboard),
                            label: 'Dashboard',
                          ),
                          isSelected: activeIndex == 0,
                          currentTheme: theme,
                          onTap: () {
                            tabsRouter.setActiveIndex(0);
                            Navigator.of(context).pop();
                          },
                        );
                      }

                      final destination = destinations[index - 1];

                      return DrawerMenuItem(
                        data: DrawerItemData(
                          index: index,
                          icon: KImageProvider(image: KIcons.dashboard),
                          label:
                              destination.subService.subServiceName ??
                              destination.subService.code ??
                              'Unnamed sub-service',
                          code: destination.subService.code,
                        ),
                        isSelected: activeIndex == index,
                        currentTheme: theme,
                        onTap: () {
                          ref
                              .read(selectedServiceProvider.notifier)
                              .state = SelectedServiceState(
                            service: widget.service,
                            subService: destination.subService,
                          );
                          tabsRouter.setActiveIndex(index);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: KeyedSubtree(
              key: ValueKey(activeIndex),
              child: children[activeIndex],
            ),
          ),
        );
      },
    );
  }
}
