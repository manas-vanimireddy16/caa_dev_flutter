import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

import 'package:code_setup/modules/domain/core/theme/theme.dart';

import 'package:code_setup/modules/router/app_router.gr.dart';

import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';

import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/icons.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:msal_auth/msal_auth.dart';

part 'controller.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final state = ref.read(bottomNavigatorVsProvider);

    final stateController = ref.read(bottomNavigatorVsProvider.notifier);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      top: false,

      child: AutoTabsScaffold(
        scaffoldKey: _scaffoldKey,

        routes: [
          AnnouncementRoute(),
          // ApprovalsList(),
          ServicesRoute(),
          LinksRoute(),
          ProfileRoute(),
          SettingsRoute(),
        ],

        // builder: (context, child) {

        //   return child;

        // },
        bottomNavigationBuilder: (_, tabsRouter) {
          // if (tabsRouter.activeIndex == 3 || tabsRouter.activeIndex == 2) {

          //   return const SizedBox.shrink();

          // }

          return Container(
            height: 71,

            decoration: BoxDecoration(
              color: currentTheme.colors.onPrimary,

              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(16.toAutoScaledWidth),

              //   topRight: Radius.circular(16.toAutoScaledWidth),
              // ),
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

              children: [
                Expanded(
                  child: _buildNavItem(
                    icon: AppIcons.homeBottomNavigator,

                    label: 'Home',

                    isActive: tabsRouter.activeIndex == 0,

                    onTap: () {
                      tabsRouter.setActiveIndex(0);

                      stateController.onTabChanged(0);
                    },

                    currentTheme: currentTheme,
                  ),
                ),

                // _buildNavItem(
                //   icon: Icons.design_services,

                //   label: 'Quick Links',

                //   isActive: tabsRouter.activeIndex == 1,

                //   onTap: () {
                //     tabsRouter.setActiveIndex(1);

                //     stateController.onTabChanged(1);
                //   },

                //   currentTheme: currentTheme,
                // ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppIcons.servicesBottomNavigator,

                    label: 'Services',

                    isActive: tabsRouter.activeIndex == 1,

                    onTap: () {
                      tabsRouter.setActiveIndex(1);

                      stateController.onTabChanged(1);
                    },

                    currentTheme: currentTheme,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppIcons.linksBottomNavigator,

                    label: 'Links',

                    isActive: tabsRouter.activeIndex == 2,

                    onTap: () {
                      tabsRouter.setActiveIndex(2);

                      stateController.onTabChanged(2);
                    },

                    currentTheme: currentTheme,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppIcons.profileBottomNavigator,

                    label: 'Profile',

                    isActive: tabsRouter.activeIndex == 3,

                    onTap: () {
                      tabsRouter.setActiveIndex(3);

                      stateController.onTabChanged(3);
                    },

                    currentTheme: currentTheme,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppIcons.settingsBottomNavigator,

                    label: 'Settings',

                    isActive: tabsRouter.activeIndex == 4,

                    onTap: () {
                      tabsRouter.setActiveIndex(4);

                      stateController.onTabChanged(4);
                    },

                    currentTheme: currentTheme,
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

      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2.toAutoScaledWidth),

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
            width: 22,
            height: 22,
            tintColor: isActive ? AppColors.primaryBlue75 : AppColors.grey50,
          ),

          // Icon(icon, color: currentTheme.colors.secondary, size: 24),
          const SizedBox(height: 4),

          Text(
            label,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            textAlign: TextAlign.center,

            style: _homeNavLabelStyle(
              color: isActive ? AppColors.primaryBlue75 : AppColors.grey50,
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

      color: isActive ? Color(0XFFF2EBE6) : null,
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

            textAlign: TextAlign.center,

            style: _homeNavLabelStyle(),
          ),
        ],
      ),
    ),
  );
}

TextStyle _homeNavLabelStyle({Color? color}) {
  return AppTextStyles.cairo(
    fontSize: 12.toAutoScaledFont,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.5,
    color: color,
  );
}

TextStyle _buildLabelTextStyle() {
  return _homeNavLabelStyle();
}
