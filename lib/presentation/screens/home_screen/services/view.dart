import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/core/providers/selected_service_provider.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/bookmarksModel.dart';
import 'package:code_setup/presentation/screens/home_screen/services/servicesCard.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:code_setup/utils/helper/sub_service_route_resolver.dart';
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
    with AutoRouteAwareStateMixin<ServicesScreen> {
  bool _hasLoadedData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadData();
    });
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    super.didInitTabRoute(previousRoute);

    _loadData();
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    super.didChangeTabRoute(previousRoute);

    _refreshServicesData();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    _refreshServicesData();
  }

  Future<void> _loadData() async {
    if (_hasLoadedData) return;
    _hasLoadedData = true;
    await _refreshServicesData();
  }

  Future<void> _refreshServicesData() async {
    if (!mounted) return;

    final controller = ref.read(servicesProvider.notifier);
    final user = KAppX.globalProvider.read(userProvider);

    await Future.wait([
      controller.fetchUserRoles(user?.userId ?? 0),
      controller.fetchBookmarks(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(servicesProvider);

    final controller = ref.read(servicesProvider.notifier);

    final user = KAppX.globalProvider.read(userProvider);
    final l10n = DashboardL10n.of(context);
    final isArabic = l10n.isArabic;

    return KScaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          l10n.services,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          _hasLoadedData = false;
          await Future.wait([
            controller.fetchUserRoles(user?.userId ?? 0),
            controller.fetchBookmarks(),
          ]);
          _hasLoadedData = true;
        },
        child: Builder(
          builder: (context) {
            final isInitialLoading =
                state.isLoading && (state.services?.isEmpty ?? true);
            final services = controller.filteredServices(isArabic: isArabic);
            final listFilter = ref.watch(
              servicesProvider.select((s) => s.listFilter),
            );
            final searchQuery = ref.watch(
              servicesProvider.select((s) => s.searchQuery),
            );

            if (isInitialLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ServicesSearchField(
                          initialValue: searchQuery,
                          hintText: l10n.servicesSearchPlaceholder,
                          onChanged: controller.setSearchQuery,
                        ),
                        const SizedBox(height: 16),
                        ServicesFilterToggle(
                          selected: listFilter,
                          onChanged: controller.setListFilter,
                          allServicesLabel: l10n.servicesAllServices,
                          myServicesLabel: l10n.servicesMyServices,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                if (state.isBookmarksLoading && services.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (services.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        listFilter == ServicesListFilter.myServices
                            ? l10n.noDataFound
                            : 'No services available',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final data = services[index];
                        return _ServiceListCard(
                          service: data,
                          listIndex: index,
                          isArabic: isArabic,
                        );
                      }, childCount: services.length),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ServiceListCard extends ConsumerWidget {
  final Service service;
  final int listIndex;
  final bool isArabic;

  const _ServiceListCard({
    required this.service,
    required this.listIndex,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceId = service.id ?? 0;
    final isBookmarked = ref.watch(
      servicesProvider.select(
        (s) => s.bookmarkedServiceIds.contains(serviceId),
      ),
    );
    final controller = ref.read(servicesProvider.notifier);

    final title = isArabic
        ? (service.arabicName?.trim().isNotEmpty == true
              ? service.arabicName!
              : service.name ?? 'No Name')
        : (service.name ?? 'No Name');

    final subtitle = isArabic
        ? (service.arabicDescription?.trim().isNotEmpty == true
              ? service.arabicDescription!
              : service.description ?? 'No Description')
        : (service.description ?? 'No Description');

    final subServiceLabels =
        service.subservices?.map((s) {
          if (isArabic) {
            return s.arabicsubServiceName?.trim().isNotEmpty == true
                ? s.arabicsubServiceName!
                : s.subServiceName ?? 'Unnamed';
          }
          return s.subServiceName ?? 'Unnamed';
        }).toList() ??
        [];

    return CustomInfoCard(
      key: ValueKey(serviceId),
      title: title,
      subtitle: subtitle,
      iconBackgroundColor: serviceCardIconColorForIndex(listIndex),
      subServices: subServiceLabels,
      isBookmarked: isBookmarked,
      onBookmarkToggle: () => controller.toggleBookmark(serviceId),
      onCardTap: () {
        controller.navigateToRoute(
          name: service.code ?? '',
          service: service,
          subServices: service.subservices,
        );
      },
      onSubServiceTap: (subName) {
        SubService? matched;
        for (final s in service.subservices ?? <SubService>[]) {
          final en = s.subServiceName ?? '';
          final ar = s.arabicsubServiceName ?? '';
          if (en == subName || ar == subName) {
            matched = s;
            break;
          }
        }

        if (matched != null) {
          controller.navigateToRoute(
            name: matched.code ?? '',
            service: service,
            subService: matched,
          );
        }
      },
    );
  }
}
