import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/onboarding/login/view.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msal_auth/msal_auth.dart';

part 'controller.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final logoutController = ref.read(loginVsProvider.notifier);

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        title: Text(
          '    Settings',

          style: TextStyle(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              // --------- Theme ----------

              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 12,
              //     vertical: 12,
              //   ),
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade50,
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: Colors.grey.shade200),
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.brightness_6_rounded,
              //         color: Colors.grey.shade700,
              //       ),
              //       const SizedBox(width: 12),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Theme',
              //               style: TextStyle(
              //                 fontSize: currentTheme.fontSizes.s14,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             const SizedBox(height: 2),
              //             Text(
              //               state.isDarkMode
              //                   ? 'Dark mode is enabled'
              //                   : 'Light mode is enabled',
              //               style: TextStyle(
              //                 fontSize: currentTheme.fontSizes.s12,
              //                 color: Colors.grey.shade600,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Switch.adaptive(
              //         value: state.isDarkMode,
              //         onChanged: controller.onToggleTheme,
              //       ),
              //     ],
              //   ),
              // ),
              24.toVerticalSizedBox,

              // --------- Role ----------
              Text(
                'Account',
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              8.toVerticalSizedBox,
              KDropdownField<RoleDetail>(
                value: state.selectedRole,
                fieldHeadingText: 'Select Role',
                hintText: 'Choose your active role',
                items: (state.userRoles.data?.roleDetails ?? [])
                    .map<KDropdownItem<RoleDetail>>(
                      (role) => KDropdownItem<RoleDetail>(
                        value: role,
                        child: Text(role.role?.name ?? ''),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    controller.onSelectRole(v);
                  }
                },
              ),

              16.toVerticalSizedBox,

              // --------- Language ----------
              KDropdownField<LanguageItem>(
                value: state.selectedLanguage,
                fieldHeadingText: 'Language',
                hintText: 'Select language',
                items: state.languageList
                    .map<KDropdownItem<LanguageItem>>(
                      (lang) => KDropdownItem<LanguageItem>(
                        value: lang,
                        child: Text(lang.name),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    controller.onSelectLanguage(v);
                  }
                },
              ),

              32.toVerticalSizedBox,

              // --------- Logout ----------
              8.toVerticalSizedBox,
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: state.isLoggingOut
                      ? null
                      : () => controller.onLogoutPressed(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(
                    state.isLoggingOut ? 'Logging out...' : 'Logout',
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              20.toVerticalSizedBox,
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: state.isLoggingOut
                      ? null
                      : () => controller.logoutJwt(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(
                    state.isLoggingOut ? 'Logging out...' : 'Logout with jwt',
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
