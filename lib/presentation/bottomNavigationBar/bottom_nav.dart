import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
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
        LogisticsDashboardRoute(),
        LogisticsRequestPortalRoute(),
        LogisticsForeignersRequestPortalRoute(),
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
            height: 71,
            decoration: BoxDecoration(
              color: currentTheme.colors.onPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.toAutoScaledWidth),
                topRight: Radius.circular(16.toAutoScaledWidth),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: currentTheme.colors.secondary.shade60,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          );
        },
      ),
    );
  }

  /// ---------- UI Builders ----------

  Widget _buildNavItem({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required KThemeBox currentTheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 76.toAutoScaledWidth,
        padding: EdgeInsets.symmetric(vertical: 4.toAutoScaledHeight),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF2EBE6) : null,
          borderRadius: BorderRadius.circular(16.toAutoScaledWidth),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KImageProvider(
              image: icon,
              tintColor: currentTheme.colors.primary,
              width: 24.toAutoScaledWidth,
              height: 24.toAutoScaledHeight,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: currentTheme.fontSizes.s10,
                fontWeight: currentTheme.fontWeights.wRegular,
                height: 15.7.toAutoScaledFont / currentTheme.fontSizes.s10,
                letterSpacing: 0.5,
                color: currentTheme.colors.primary,
                fontFamily: GoogleFonts.mitr().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigatorIcon(
    String asset,
    bool isActive,
    KThemeBox currentTheme,
    String iconName, {
    Color? color,
  }) {
    return Container(
      width: 76.toAutoScaledWidth,
      height: 50.toAutoScaledHeight,
      padding: EdgeInsets.only(
        top: 4.toAutoScaledHeight,
        bottom: 4.toAutoScaledHeight,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.toAutoScaledWidth),
        color: isActive ? const Color(0XFFF2EBE6) : null,
      ),
      child: Center(
        child: Column(
          children: [
            KImageProvider(
              image: asset,
              tintColor: color,
              width: 24.toAutoScaledWidth,
              height: 24.toAutoScaledHeight,
            ),
            Text(
              iconName,
              style: TextStyle(
                fontSize: currentTheme.fontSizes.s10,
                fontWeight: currentTheme.fontWeights.wRegular,
                height: 15.7.toAutoScaledFont / currentTheme.fontSizes.s10,
                letterSpacing: 0.5,
                fontFamily: GoogleFonts.mitr().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _buildLabelTextStyle() {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    return TextStyle(
      fontSize: currentTheme.themeBox.fontSizes.s10,
      fontWeight: currentTheme.themeBox.fontWeights.wRegular,
      height: 15.7.toAutoScaledFont / currentTheme.themeBox.fontSizes.s10,
      letterSpacing: 0.5,
      fontFamily: GoogleFonts.mitr().fontFamily,
    );
  }
}
