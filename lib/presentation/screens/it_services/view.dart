import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/drawer_component.dart';
import 'package:code_setup/presentation/core/providers/roles_provider.dart';
import 'package:code_setup/presentation/core/providers/selected_service_provider.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/presentation/models/request_detail.dart'
    hide Service;
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/assets/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'controller.dart';
part 'widgets/drawer.dart';

// part 'my_profile_page/widget/my_profile_widget.dart';
@RoutePage()
// class ITServicesHomeScreen extends ConsumerStatefulWidget {
//   const ITServicesHomeScreen({super.key});
//   @override
//   ConsumerState<ITServicesHomeScreen> createState() =>
//       _ITServicesHomeScreenState();
// }
// class _ITServicesHomeScreenState extends ConsumerState<ITServicesHomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(rolesControllerProvider.notifier).fetchRoles();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     final stateController = ref.read(bottomNavigatorVsProvider.notifier);
//     /// ✅ GET ROLES
//     final roles = ref.watch(rolesControllerProvider)?.services ?? [];
//     /// ✅ GET MAIN SERVICE
//     final service = roles.firstWhere(
//       (r) => (r.name ?? '').trim() == 'IT Services',
//       orElse: () => Service(),
//     );
//     final subServices = service.subservices ?? [];
//     /// ✅ ROUTE CONFIG (MASTER)
//     final routeConfig = [
//       {
//         "code": "HELP_DESK_SALALAH",
//         "name": "Help Desk Salalah",
//         "route": SalalahDashboard(service: Service(), subService: SubService()),
//       },
//       {
//         "code": "HELP_DESK_MUSCAT",
//         "name": "Help Desk Muscat",
//         "route": MuscatDashboard(service: Service(), subService: SubService()),
//       },
//       {"code": "VPN", "name": "VPN Service", "route": VpnDashboard()},
//       {
//         "code": "EVENT_SUPPORT",
//         "name": "Request Event Support",
//         "route": RequestEventSupportRoute(
//           service: Service(),
//           subService: SubService(),
//         ),
//       },
//     ];
//     /// ✅ FILTER ROUTES BASED ON ROLE
//     final filteredRoutes = routeConfig.where((c) {
//       return subServices.any((s) {
//         final code = (s.code ?? '').toLowerCase().trim();
//         final name = (s.subServiceName ?? '').toLowerCase().trim();
//         return code == c["code"].toString().toLowerCase() ||
//             name == c["name"].toString().toLowerCase();
//       });
//     }).toList();
//     /// ✅ CONVERT TO AUTOROUTE LIST
//     final routes = filteredRoutes
//         .map((e) => e["route"] as PageRouteInfo)
//         .toList();
//     return AutoTabsRouter.builder(
//       routes: routes,
//       /// ✅ BUILDER
//       builder: (tabsContext, children, tabsRouter) {
//         final activeIndex = tabsRouter.activeIndex;
//         return Scaffold(
//           backgroundColor: currentTheme.colors.background,
//           appBar: KAppBar(
//             leading: Builder(
//               builder: (ctx) => IconButton(
//                 icon: const Icon(Icons.menu),
//                 onPressed: () => Scaffold.of(ctx).openDrawer(),
//               ),
//             ),
//             /// ⚠️ (still using old title method)
//             title: Text(
//               stateController.titleForIndex(activeIndex, filteredRoutes),
//               style: TextStyle(
//                 fontSize: currentTheme.fontSizes.s16,
//                 fontWeight: currentTheme.fontWeights.wBold,
//               ),
//             ),
//           ),
//           /// ✅ DRAWER
//           drawer: KDrawer(
//             child: _DrawerMenu(
//               currentTheme: currentTheme,
//               activeIndex: activeIndex,
//               onItemTap: (index) {
//                 if (index == activeIndex) {
//                   KAppX.router.pop();
//                   return;
//                 }
//                 tabsRouter.setActiveIndex(index);
//                 stateController.onTabChanged(index);
//                 KAppX.router.pop();
//               },
//             ),
//           ),
//           /// ✅ BODY
//           body: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 250),
//             child: KeyedSubtree(
//               key: ValueKey(activeIndex),
//               child: children[activeIndex],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
class ITServicesHomeScreen extends ConsumerStatefulWidget {
  const ITServicesHomeScreen({super.key});

  @override
  ConsumerState<ITServicesHomeScreen> createState() =>
      _ITServicesHomeScreenState();
}

class _ITServicesHomeScreenState extends ConsumerState<ITServicesHomeScreen> {
  @override
  void initState() {
    super.initState();

    /// ✅ FETCH ROLES ON LOAD
    Future.microtask(() {
      ref.read(rolesControllerProvider.notifier).fetchRoles();
    });
  }

  //   @override
  //   Widget build(BuildContext context) {
  //     final currentTheme = KAppX.globalProvider
  //         .read(KAppX.theme.current)
  //         .themeBox;

  //     final stateController = ref.read(bottomNavigatorVsProvider.notifier);

  //     return AutoTabsRouter.builder(
  //       routes: [SalalahDashboard(service: Service(), subService: SubService())],
  //       builder: (tabsContext, children, tabsRouter) {
  //         final activeIndex = tabsRouter.activeIndex;

  //         return Scaffold(
  //           backgroundColor: currentTheme.colors.background,
  //           appBar: KAppBar(
  //             leading: Builder(
  //               builder: (ctx) => IconButton(
  //                 icon: const Icon(Icons.menu),
  //                 onPressed: () => Scaffold.of(ctx).openDrawer(),
  //               ),
  //             ),
  //             title: Text(
  //               stateController.titleForIndex(activeIndex),
  //               style: TextStyle(
  //                 fontSize: currentTheme.fontSizes.s16,
  //                 fontWeight: currentTheme.fontWeights.wBold,
  //               ),
  //             ),
  //           ),
  //           drawer: KDrawer(
  //             child: _DrawerMenu(
  //               currentTheme: currentTheme,
  //               activeIndex: activeIndex,
  //               onItemTap: (index) {
  //                 if (index == activeIndex) {
  //                   KAppX.router.pop();
  //                   return;
  //                 }

  //                 tabsRouter.setActiveIndex(index);
  //                 stateController.onTabChanged(index);
  //                 KAppX.router.pop();
  //               },
  //             ),
  //           ),
  //           body: AnimatedSwitcher(
  //             duration: const Duration(milliseconds: 250),
  //             child: KeyedSubtree(
  //               key: ValueKey(activeIndex),
  //               child: children[activeIndex],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final stateController = ref.read(bottomNavigatorVsProvider.notifier);

    return AutoTabsRouter.builder(
      routes: [
        // AssignmentDecisionDashboardRoute(),
        SalalahDashboard(service: Service(), subService: SubService()),
        MuscatDashboard(service: Service(), subService: SubService()),
        VpnDashboard(service: Service(), subService: SubService()),
        // LegalConsultationandReviewofAdministrativeDecisionsRoute(
        //   service: Service(),
        //   subService: SubService(),
        // ),
      ],
      // 👇 CORRECT builder signature for AutoTabsRouter.builder
      builder: (tabsContext, children, tabsRouter) {
        final activeIndex = tabsRouter.activeIndex;

        return Scaffold(
          backgroundColor: currentTheme.colors.background,
          appBar: KAppBar(
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),

            title: Text(
              stateController.titleForIndex(activeIndex),
              style: TextStyle(
                fontSize: currentTheme.fontSizes.s16,
                fontWeight: currentTheme.fontWeights.wBold,
              ),
            ),
          ),
          drawer: KDrawer(
            child: _DrawerMenu(
              currentTheme: currentTheme,
              activeIndex: activeIndex,
              onItemTap: (index) {
                if (index == activeIndex) {
                  KAppX.router.pop(); // just close drawer
                  return;
                }

                tabsRouter.setActiveIndex(index);
                stateController.onTabChanged(index);
                KAppX.router.pop(); // close drawer after nav
              },
            ),
          ),
          // Nice, smooth transition between tabs
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
