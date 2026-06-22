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
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:code_setup/utils/helper/sub_service_route_resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';

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
      backgroundColor: AppColors.homeSurfaceColor,

      appBar: AppBar(
        toolbarHeight: 64,
        foregroundColor: AppColors.textHeading,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: Border(bottom: BorderSide(color: Color(0xFFE6E6EA), width: 1)),
        title: Text(
          l10n.services,
          style: AppTextStyles.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        // centerTitle: true,
        actions: const [_ServicesNotificationBellButton()],
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
                        style: AppTextStyles.cairo(color: Colors.grey),
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

class _ServicesNotificationBellButton extends StatelessWidget {
  const _ServicesNotificationBellButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Notifications',
      icon: const Icon(Icons.notifications_none, color: Colors.black, size: 26),
      onPressed: () {},
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
    final l10n = DashboardL10n.of(context);
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
          return l10n.subServiceDisplayName(
            englishName: s.subServiceName,
            arabicName: s.arabicsubServiceName,
          );
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
