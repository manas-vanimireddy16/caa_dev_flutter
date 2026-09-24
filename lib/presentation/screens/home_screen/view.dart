import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/view.dart';
import 'package:code_setup/presentation/screens/home_screen/services/view.dart';
import 'package:code_setup/responsive/app_page_layout.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final stateController = ref.read(bottomNavigatorVsProvider.notifier);
    final l10n = DashboardL10n.of(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      top: false,
      child: AutoTabsScaffold(
        scaffoldKey: scaffoldKey,
        routes: [
          AnnouncementRoute(),
          ServicesRoute(),
          LinksRoute(),
          ProfileRoute(),
          SettingsRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          final activeIndex = tabsRouter.activeIndex;

          void selectTab(int index, {VoidCallback? onSelected}) {
            tabsRouter.setActiveIndex(index);
            stateController.onTabChanged(index);
            onSelected?.call();
          }

          return Container(
            height: () {
              final size = MediaQuery.sizeOf(context);
              final isTablet =
                  size.shortestSide >= 600 || size.width >= 700;
              final heightScale = (size.height / 903.0).clamp(
                1.0,
                isTablet ? 1.12 : 1.35,
              );
              return (isTablet ? 76.0 : 72.0) * heightScale;
            }(),
            decoration: BoxDecoration(
              color: currentTheme.colors.onPrimary,
              border: const Border(
                top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: currentTheme.colors.secondary.shade60,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: AppPageLayout.pageInsets,
                child: Row(
                  children: [
                    _buildNavItem(
                      icon: AppIcons.homeBottomNavigator,
                      label: l10n.home,
                      isActive: activeIndex == 0,
                      onTap: () => selectTab(
                        0,
                        onSelected: () => _refreshHomeTab(ref),
                      ),
                      currentTheme: currentTheme,
                    ),
                    _buildNavItem(
                      icon: AppIcons.servicesBottomNavigator,
                      label: l10n.services,
                      isActive: activeIndex == 1,
                      onTap: () => selectTab(
                        1,
                        onSelected: () => _refreshServicesTab(ref),
                      ),
                      currentTheme: currentTheme,
                    ),
                    _buildNavItem(
                      icon: AppIcons.linksBottomNavigator,
                      label: l10n.links,
                      isActive: activeIndex == 2,
                      onTap: () => selectTab(2),
                      currentTheme: currentTheme,
                    ),
                    _buildNavItem(
                      icon: AppIcons.profileBottomNavigator,
                      label: l10n.navProfile,
                      isActive: activeIndex == 3,
                      onTap: () => selectTab(3),
                      currentTheme: currentTheme,
                    ),
                    _buildNavItem(
                      icon: AppIcons.settingsBottomNavigator,
                      label: l10n.settings,
                      isActive: activeIndex == 4,
                      onTap: () => selectTab(4),
                      currentTheme: currentTheme,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> _refreshHomeTab(WidgetRef ref) async {
  final controller = ref.read(homeDashboardProvider.notifier);
  await Future.wait([
    controller.fetchRequests(),
    controller.fetchActionItems(),
  ]);
}

Future<void> _refreshServicesTab(WidgetRef ref) async {
  final controller = ref.read(servicesProvider.notifier);
  final auth = KAuthCred();
  await auth.hydrateProvidersFromStorage();
  final userId = await auth.resolveUserId();
  if (userId == null || userId <= 0) return;

  await Future.wait([
    controller.fetchUserRoles(userId),
    controller.fetchBookmarks(),
  ]);
}

Widget _buildNavItem({
  required String icon,
  required String label,
  required bool isActive,
  required VoidCallback onTap,
  required KThemeBox currentTheme,
}) {
  return Expanded(
    child: Builder(
      builder: (context) {
        final isTablet = AppPageLayout.isTablet(context);
        final iconSize = isTablet ? 26.0 : 24.0;
        final fontSize = isTablet ? 12.0 : 11.0;
        final color =
            isActive ? AppColors.primaryBlue75 : AppColors.grey50;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 10 : 8,
                  vertical: isTablet ? 6 : 4,
                ),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFFF2EBE6) : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: KImageProvider(
                  image: icon,
                  width: iconSize,
                  height: iconSize,
                  tintColor: color,
                ),
              ),
              SizedBox(height: isTablet ? 5 : 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.cairo(
                  fontSize: fontSize,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                  height: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
