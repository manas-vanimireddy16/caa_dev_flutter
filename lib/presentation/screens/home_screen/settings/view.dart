import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/screens/home_screen/services/view.dart';
import 'package:code_setup/presentation/screens/home_screen/view.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/localization_provider/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msal_auth/msal_auth.dart';

part 'controller.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final l10n = DashboardL10n.of(context);

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      backgroundColor: AppColors.homeSurfaceColor,
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: AppTextStyles.cairo(
            fontSize: 20.toAutoScaledFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 64,
        foregroundColor: AppColors.textHeading,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: Border(bottom: BorderSide(color: Color(0xFFE6E6EA), width: 1)),
        elevation: 0,
      ),
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF3F4F6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListView(
              children: [
                _SettingsSectionCard(
                  icon: Icons.language_outlined,
                  title: 'Language Selection',
                  child: KDropdownField<LanguageItem>(
                    value: state.selectedLanguage,
                    hintText: 'Select Language',
                    isExpanded: true,
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xFFD0D5DD),
                    borderRadius: BorderRadius.circular(8),
                    style: AppTextStyles.cairo(
                      color: AppColors.dropdownText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    iconEnabledColor: AppColors.dropdownText,
                    items: state.languageList
                        .map<KDropdownItem<LanguageItem>>(
                          (lang) => KDropdownItem<LanguageItem>(
                            value: lang,
                            child: Text(
                              lang.name,
                              style: AppTextStyles.cairo(
                                color: AppColors.dropdownText,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        controller.onSelectLanguage(v);
                      }
                    },
                  ),
                ),

                16.toVerticalSizedBox,

                _SettingsSectionCard(
                  icon: Icons.person_outline,
                  title: 'Role Selection',
                  child: KDropdownField<RoleDetail>(
                    value: state.selectedRole,
                    hintText: l10n.chooseActiveRoleHint,
                    isExpanded: true,
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xFFD0D5DD),
                    borderRadius: BorderRadius.circular(8),
                    style: AppTextStyles.cairo(
                      color: AppColors.dropdownText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    iconEnabledColor: AppColors.dropdownText,
                    items: (state.userRoles.data?.roleDetails ?? [])
                        .map<KDropdownItem<RoleDetail>>(
                          (role) => KDropdownItem<RoleDetail>(
                            value: role,
                            child: Text(
                              role.role?.name ?? '',
                              style: AppTextStyles.cairo(
                                color: AppColors.dropdownText,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        controller.onSelectRole(v, context);
                      }
                    },
                  ),
                ),

                24.toVerticalSizedBox,

                _SettingsActionButton(
                  label: state.isLoggingOut ? 'Logging out...' : 'Logout',
                  onPressed: state.isLoggingOut
                      ? null
                      : () => controller.onLogoutPressed(context),
                ),

                12.toVerticalSizedBox,

                _SettingsActionButton(
                  label: state.isLoggingOut
                      ? 'Logging out...'
                      : 'Logout with JWT',
                  onPressed: state.isLoggingOut ? null : controller.logoutJwt,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SettingsSectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: AppColors.dropdownHeadingText),
              const SizedBox(width: 10),
              Text(
                title,
                style: AppTextStyles.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dropdownHeadingText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _SettingsActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _SettingsActionButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryBlue75,
          foregroundColor: AppColors.loginText,
          disabledBackgroundColor: AppColors.primaryBlue75.withValues(
            alpha: 0.6,
          ),
          disabledForegroundColor: AppColors.loginText,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.logout_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}
