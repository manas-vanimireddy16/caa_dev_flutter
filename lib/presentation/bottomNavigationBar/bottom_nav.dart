import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/responsive/app_page_layout.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/assets/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class KBottomNavigatorScreen extends ConsumerStatefulWidget {
  /// You can pass where this bottom navigator was opened from.
  /// Example: 'muscat', 'admin', 'client', etc.
  final String? fromPage;

  const KBottomNavigatorScreen({Key? key, this.fromPage}) : super(key: key);

  @override
  _KBottomNavigatorScreenState createState() => _KBottomNavigatorScreenState();
}

class _KBottomNavigatorScreenState
    extends ConsumerState<KBottomNavigatorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    /// ✅ Conditional route list based on where this came from
    late final List<PageRouteInfo> routes;

    if (widget.fromPage == 'muscat') {
      routes = const [AnnouncementRoute()];
    } else if (widget.fromPage == 'requesteventsupport') {
      routes = const [];
    } else if (widget.fromPage == 'logistics') {
      routes = const [
        // LogisticsDashboardRoute(),
        // LogisticsForeignersRequestPortalRoute(),
        // SalalahDashboard(),
        // Services(),
      ];
    } else {
      // Default route set
      routes = const [ServicesRoute(), AnnouncementRoute()];
    }

    /// ✅ Label and icon configuration (keep same order as `routes`)
    final List<String> labels = ['Home', 'Records', 'Account', 'Menu'];

    final List<String> icons = [
      KIcons.home,
      KIcons.records,
      KIcons.account,
      KIcons.menu,
    ];

    return SafeArea(
      top: false,
      child: AutoTabsScaffold(
        scaffoldKey: _scaffoldKey,
        routes: routes,
        bottomNavigationBuilder: (_, tabsRouter) {
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
                  children: List.generate(routes.length, (index) {
                    return _buildNavItem(
                      icon: icons[index],
                      label: labels[index],
                      isActive: tabsRouter.activeIndex == index,
                      onTap: () => tabsRouter.setActiveIndex(index),
                      currentTheme: currentTheme,
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
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
                    tintColor: currentTheme.colors.primary,
                    width: iconSize,
                    height: iconSize,
                  ),
                ),
                SizedBox(height: isTablet ? 5 : 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.5,
                    color: currentTheme.colors.primary,
                    fontFamily: GoogleFonts.mitr().fontFamily,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
