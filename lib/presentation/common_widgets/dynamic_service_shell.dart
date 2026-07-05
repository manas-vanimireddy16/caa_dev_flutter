import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/drawer_component.dart';
import 'package:code_setup/presentation/core/providers/selected_service_provider.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/buttons/back_button.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/assets/icons.dart';
import 'package:code_setup/utils/helper/drawer_service_icon.dart';
import 'package:code_setup/utils/helper/sub_service_route_resolver.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicServiceShell extends ConsumerStatefulWidget {
  final Service service;
  final PageRouteInfo<dynamic>? dashboardRoute;
  final bool lazyLoadDashboard;

  const DynamicServiceShell({
    super.key,
    required this.service,
    this.dashboardRoute,
    this.lazyLoadDashboard = false,
  });

  @override
  ConsumerState<DynamicServiceShell> createState() =>
      _DynamicServiceShellState();
}

class _DynamicServiceShellState extends ConsumerState<DynamicServiceShell> {
  bool _hasScheduledInitialSelection = false;
  bool _initialSelectionApplied = false;
  int? _pendingInitialIndex;
  final Set<int> _visitedTabIndices = <int>{0};

  int _resolveInitialTabIndex(List<SubServiceDestination> destinations) {
    final selectedCode =
        (ref.read(selectedServiceProvider).subService.code ?? '').trim();
    if (selectedCode.isEmpty) return 0;

    final selectedIndex = destinations.indexWhere(
      (destination) =>
          (destination.subService.code ?? '').trim() == selectedCode,
    );
    if (selectedIndex < 0) return 0;

    return selectedIndex + 1;
  }

  void _seedInitialTabVisit(List<SubServiceDestination> destinations) {
    if (_pendingInitialIndex != null) return;

    final initialIndex = _resolveInitialTabIndex(destinations);
    _pendingInitialIndex = initialIndex;

    if (widget.lazyLoadDashboard && initialIndex > 0) {
      _visitedTabIndices
        ..clear()
        ..add(initialIndex);
      return;
    }

    _visitedTabIndices.add(initialIndex);
  }

  void _scheduleInitialTabSelection(TabsRouter tabsRouter, int initialIndex) {
    if (_hasScheduledInitialSelection) return;
    _hasScheduledInitialSelection = true;

    if (tabsRouter.activeIndex == initialIndex) {
      _initialSelectionApplied = true;
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (tabsRouter.activeIndex != initialIndex) {
        tabsRouter.setActiveIndex(initialIndex);
      }
      if (mounted) {
        setState(() {
          _initialSelectionApplied = true;
        });
      }
    });
  }

  void _activateTab(TabsRouter tabsRouter, int index) {
    final wasVisited = _visitedTabIndices.contains(index);
    _visitedTabIndices.add(index);

    if (!wasVisited && mounted) {
      setState(() {});
    }

    if (tabsRouter.activeIndex != index) {
      tabsRouter.setActiveIndex(index);
    }
  }

  Widget _buildLazyTabBody(List<Widget> children, int activeIndex) {
    return IndexedStack(
      index: activeIndex,
      sizing: StackFit.expand,
      children: List.generate(children.length, (index) {
        if (!_visitedTabIndices.contains(index)) {
          return const SizedBox.shrink();
        }
        return children[index];
      }),
    );
  }

  void _dismissKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();
  }

  void _closeDrawer(BuildContext context) {
    _dismissKeyboard(context);
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void _openDrawer(BuildContext context) {
    _dismissKeyboard(context);
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;
    final l10n = DashboardL10n.of(context);
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

    _seedInitialTabVisit(destinations);
    final initialIndex = _pendingInitialIndex ?? 0;

    return AutoTabsRouter.builder(
      routes: routes,
      onRouterReady: (tabsRouter) {
        _scheduleInitialTabSelection(tabsRouter, initialIndex);
      },
      builder: (tabsContext, children, tabsRouter) {
        final activeIndex = tabsRouter.activeIndex;
        final bodyIndex = !_initialSelectionApplied && initialIndex > 0
            ? initialIndex
            : activeIndex;
        final titleIndex = bodyIndex;
        final activeTitle = titleIndex == 0
            ? l10n.dashboard
            : l10n.subServiceDisplayName(
                englishName:
                    destinations[titleIndex - 1].subService.subServiceName,
                arabicName: destinations[titleIndex - 1]
                    .subService
                    .arabicsubServiceName,
              );

        return Scaffold(
          backgroundColor: theme.colors.background,
          onDrawerChanged: (isOpened) {
            if (!isOpened) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusManager.instance.primaryFocus?.unfocus();
              });
            }
          },
          appBar: KAppBar(
            leading: Builder(
              builder: (drawerContext) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _openDrawer(drawerContext),
              ),
            ),
            title: Text(
              activeTitle,
              style: AppTextStyles.serviceScreenTitle(),
            ),
            actions: [
              KBackButton(
                onPressed: () => tabsContext.router.maybePop(),
              ),
            ],
          ),
          drawer: KDrawer(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.toAutoScaledHeight),
                    child: KDrawerHeader(
                      onClose: () => _closeDrawer(tabsContext),
                    ),
                  ),
                  20.toVerticalSizedBox,
                  KDivider(color: Colors.grey, padding: EdgeInsets.zero),
                  20.toVerticalSizedBox,
                  Padding(
                    padding: EdgeInsets.only(left: 10.toAutoScaledWidth),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        KImageProvider(
                          image: KIcons.security,
                          height: 20.toAutoScaledHeight,
                          width: 20.toAutoScaledWidth,
                          tintColor: Colors.black,
                        ),
                        16.toHorizontalSizedBox,
                        Expanded(
                          child: SizedBox(
                            height: 20.toAutoScaledHeight,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.service.name ?? '',
                                style: AppTextStyles.serviceScreenTitle(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                              label: l10n.dashboard,
                            ),
                            isSelected: activeIndex == 0,
                            currentTheme: theme,
                            onTap: () {
                              _activateTab(tabsRouter, 0);
                              _closeDrawer(context);
                            },
                          );
                        }

                        final destination = destinations[index - 1];
                        final subService = destination.subService;

                        return DrawerMenuItem(
                          data: DrawerItemData(
                            index: index,
                            icon: KImageProvider(
                              image: DrawerServiceIcon.pathForSubService(
                                subServiceCode: subService.code,
                                serviceCode: widget.service.code,
                                serviceName: subService.subServiceName,
                              ),
                              height: 22.toAutoScaledHeight,
                              width: 22.toAutoScaledWidth,
                            ),
                            label: l10n.subServiceDisplayName(
                              englishName: subService.subServiceName,
                              arabicName: subService.arabicsubServiceName,
                            ),
                            code: subService.code,
                          ),
                          isSelected: activeIndex == index,
                          currentTheme: theme,
                          onTap: () {
                            ref
                                .read(selectedServiceProvider.notifier)
                                .state = SelectedServiceState(
                              service: widget.service,
                              subService: subService,
                            );
                            _activateTab(tabsRouter, index);
                            _closeDrawer(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: _buildLazyTabBody(children, bodyIndex),
        );
      },
    );
  }
}
