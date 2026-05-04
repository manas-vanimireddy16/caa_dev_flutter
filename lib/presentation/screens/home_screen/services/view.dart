import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/bookmarksModel.dart';
import 'package:code_setup/presentation/screens/home_screen/services/servicesCard.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';

// @RoutePage()
// class ServicesScreen extends ConsumerWidget {
//   const ServicesScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     final state = ref.watch(servicesProvider);
//     final controller = ref.read(servicesProvider.notifier);
//     final userData = KAppX.globalProvider.read(userProvider);

//     return DefaultTabController(
//       length: 4,
//       child: KScaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Services'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'All Services'),
//               Tab(text: 'Bookmarked'),
//               Tab(text: 'Quick Links'),
//               Tab(text: 'Important Links'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // ✅ Tab 1: All Services
//             Builder(
//               builder: (context) {
//                 final services = state.services ?? [];

//                 if (state.isLoading && services.isEmpty) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (services.isEmpty) {
//                   return const Center(child: Text('No services available'));
//                 }

//                 return RefreshIndicator(
//                   onRefresh: () async => controller.fetchUserRoles(
//                     userData?.userId ?? 0,
//                   ), //userData?.userId
//                   child: ListView.builder(
//                     itemCount: services.length,
//                     itemBuilder: (context, index) {
//                       final data = services[index];

//                       return CustomInfoCard(
//                         title: data.name ?? 'No Name',
//                         subtitle: data.description ?? 'No Description',
//                         icon: Icons.miscellaneous_services,
//                         iconColor: Colors.blueAccent,
//                         subServices: data.subservices != null
//                             ? data.subservices!
//                                   .map((s) => s.subServiceName ?? 'Unnamed')
//                                   .toList()
//                             : [],
//                         isBookmarked: false,
//                         onBookmarkToggle: () {
//                           controller.updateBookmark(
//                             userId: 69,
//                             serviceId: data.id ?? 0,
//                           );
//                         },
//                         onCardTap: () {
//                           // ✅ navigate when service card is tapped
//                           controller.navigateToRoute(data.name ?? '');
//                         },
//                         onSubServiceTap: (subName) {
//                           // ✅ navigate when sub-service chip is tapped
//                           controller.navigateToRoute(subName);
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),

//             // ✅ Tab 2: Bookmarked
//             Builder(
//               builder: (context) {
//                 final bookmarks = state.bookmarks ?? [];

//                 if (state.isLoading && bookmarks.isEmpty) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (bookmarks.isEmpty) {
//                   return const Center(child: Text('No services available'));
//                 }

//                 return RefreshIndicator(
//                   onRefresh: () async => controller.fetchBookmarks(),
//                   child: ListView.builder(
//                     itemCount: bookmarks.length,
//                     itemBuilder: (context, index) {
//                       final data = bookmarks[index];
//                       final serviceid = data.serviceId != null
//                           ? int.tryParse(data.serviceId!)
//                           : null;
//                       return CustomInfoCard(
//                         title: data.serviceName ?? 'No Name',
//                         subtitle: data.serviceDescription ?? 'No Description',
//                         icon: Icons.miscellaneous_services,
//                         iconColor: Colors.blueAccent,
//                         subServices: data.subServices != null
//                             ? data.subServices!
//                                   .map((s) => s.subServiceName ?? 'Unnamed')
//                                   .toList()
//                             : [], // example tags
//                         onBookmarkToggle: () {
//                           // ✅ Call controller method
//                           controller.updateBookmark(
//                             userId: 69, // get from state.user?.id
//                             serviceId: serviceid ?? 0,
//                           );
//                         },

//                         isBookmarked: true, // you can handle logic later
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//             // ✅ Tab 3: Quick Links
//             const Center(
//               child: Text(
//                 'Quick Links',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),

//             // ✅ Tab 4: Important Links
//             const Center(
//               child: Text(
//                 'Important Links',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

@RoutePage()
class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // ref.read(servicesProvider.notifier)
        //     .onTabChanged(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final state = ref.watch(servicesProvider);
    final controller = ref.read(servicesProvider.notifier);
    final user = KAppX.globalProvider.read(userProvider);

    return DefaultTabController(
      length: 4,
      child: KScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Services'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Services'),
              Tab(text: 'Bookmarked'),
              Tab(text: 'Quick Links'),
              Tab(text: 'Important Links'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // 🔹 TAB 1 – ALL SERVICES
            Builder(
              builder: (context) {
                final services = state.services ?? [];

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchUserRoles(user?.userId ?? 0);
                  },
                  child: services.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(
                              child: Text(
                                'No services available',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final data = services[index];

                            return CustomInfoCard(
                              title: data.name ?? 'No Name',
                              subtitle: data.description ?? 'No Description',
                              icon: Icons.miscellaneous_services,
                              iconColor: Colors.blueAccent,
                              subServices: data.subservices != null
                                  ? data.subservices!
                                        .map(
                                          (s) => s.subServiceName ?? 'Unnamed',
                                        )
                                        .toList()
                                  : [],
                              isBookmarked: false,
                              onBookmarkToggle: () {
                                controller.updateBookmark(
                                  userId: user?.userId ?? 0,
                                  serviceId: data.id ?? 0,
                                );
                              },
                              onCardTap: () {
                                controller.navigateToRoute(
                                  name: data.name ?? '',
                                  service: data,
                                );
                              },
                              onSubServiceTap: (subName) {
                                final subService = data.subservices?.lastWhere(
                                  (s) => s.subServiceName == subName,
                                  orElse: () => SubService(),
                                );

                                if (subService != null) {
                                  controller.navigateToRoute(
                                    name: subService.subServiceName ?? '',
                                    service: data,
                                    subService: subService,
                                  );
                                }
                              },
                            );
                          },
                        ),
                );
              },
            ),

            // 🔹 TAB 2 – BOOKMARKED
            Builder(
              builder: (context) {
                final bookmarks = state.bookmarks ?? [];

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchBookmarks();
                  },
                  child: bookmarks.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(
                              child: Text(
                                'No bookmarked services',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: bookmarks.length,
                          itemBuilder: (context, index) {
                            final data = bookmarks[index];
                            final serviceId = int.tryParse(
                              data.serviceId ?? "",
                            );

                            return CustomInfoCard(
                              title: data.serviceName ?? 'No Name',
                              subtitle:
                                  data.serviceDescription ?? 'No Description',
                              icon: Icons.miscellaneous_services,
                              iconColor: Colors.blueAccent,
                              subServices: data.subServices != null
                                  ? data.subServices!
                                        .map(
                                          (s) => s.subServiceName ?? 'Unnamed',
                                        )
                                        .toList()
                                  : [],
                              isBookmarked: true,
                              onBookmarkToggle: () {
                                controller.updateBookmark(
                                  userId: user?.userId ?? 0,
                                  serviceId: serviceId ?? 0,
                                );
                              },
                            );
                          },
                        ),
                );
              },
            ),

            // 🔹 TAB 3 – QUICK LINKS
            RefreshIndicator(
              onRefresh: () async {
                await controller.fetchUserRoles(user?.userId ?? 0);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      'Quick Links',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 TAB 4 – IMPORTANT LINKS
            RefreshIndicator(
              onRefresh: () async {
                await controller.fetchUserRoles(user?.userId ?? 0);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      'Important Links',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
