import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/models/user_model.dart'
    hide UserData, Department, Section;
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/repository/authentication/domain.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/localization_provider/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msal_auth/msal_auth.dart';

part 'controller.dart';

// Design tokens — reference spec
const _overlayTop = Color.fromRGBO(16, 20, 45, 0.82);
const _overlayBottom = Color.fromRGBO(34, 24, 66, 0.72);
const _cardBackground = Color(0xFFF5F5F5);
const _buttonNavy = Color(0xFF23245B);
const _languageText = Color(0xFF1D1D1D);
const _featureSubtitleOpacity = 0.82;
const _statLabelOpacity = 0.85;

@RoutePage()
class MicrosoftLoginPage extends ConsumerStatefulWidget {
  const MicrosoftLoginPage({super.key});

  @override
  ConsumerState<MicrosoftLoginPage> createState() => _MicrosoftLoginPageState();
}

class _MicrosoftLoginPageState extends ConsumerState<MicrosoftLoginPage> {
  final _jwtController = TextEditingController();
  bool _showJwtSection = false;

  @override
  void dispose() {
    _jwtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginVsProvider);
    final controller = ref.read(loginVsProvider.notifier);
    final l10n = DashboardL10n.of(context);
    final locale = ref.watch(localeProvider);
    final languageLabel = l10n.loginLanguageDisplayName(locale.languageCode);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF10142D),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login-bg.png',
            fit: BoxFit.cover,
            alignment: const Alignment(-0.2, 0.15),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_overlayTop, _overlayBottom],
              ),
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
              child: const SizedBox.expand(),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LoginHeader(
                  languageLabel: languageLabel,
                  arabicSubtitle: l10n.loginAuthoritySubtitle,
                  onLanguageSelected: (code) async {
                    await Hive.box('language').put('lang', code);
                    ref.read(localeProvider.notifier).state = Locale(code);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: Column(
                      children: [
                        const Spacer(flex: 28),
                      _LoginFeaturesColumn(
                        items: [
                          _LoginFeatureData(
                            icon: Icons.verified_user_outlined,
                            title: l10n.loginSafetyExcellenceTitle,
                            subtitle: l10n.loginSafetyExcellenceSubtitle,
                          ),
                          _LoginFeatureData(
                            icon: Icons.public_outlined,
                            title: l10n.loginGlobalNetworkTitle,
                            subtitle: l10n.loginGlobalNetworkSubtitle,
                          ),
                          _LoginFeatureData(
                            icon: Icons.flight_outlined,
                            title: l10n.loginInnovationHubTitle,
                            subtitle: l10n.loginInnovationHubSubtitle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      _LoginStatsRow(l10n: l10n),
                        const Spacer(flex: 22),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 14 + bottomInset,
            child: _LoginBottomCard(
              l10n: l10n,
              isLoading: state.isLoading,
              showJwtSection: _showJwtSection,
              jwtController: _jwtController,
              onMicrosoftSignIn: controller.signIn,
              onToggleJwt: () =>
                  setState(() => _showJwtSection = !_showJwtSection),
              onJwtLogin: () async {
                final token = _jwtController.text.trim();
                if (token.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.loginJwtRequired)),
                  );
                  return;
                }
                await controller.loginWithJwt(token);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginFeatureData {
  final IconData icon;
  final String title;
  final String subtitle;

  const _LoginFeatureData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _LoginHeader extends StatelessWidget {
  final String languageLabel;
  final String arabicSubtitle;
  final ValueChanged<String> onLanguageSelected;

  const _LoginHeader({
    required this.languageLabel,
    required this.arabicSubtitle,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            child: Image.asset(
              'assets/images/caa_logo.png',
              height: 34,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CIVIL AVIATION AUTHORITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  arabicSubtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            offset: const Offset(0, 42),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onSelected: onLanguageSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'ar', child: Text('العربية')),
            ],
            child: Container(
              width: 95,
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 16, color: _languageText),
                  Expanded(
                    child: Text(
                      languageLabel,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _languageText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: _languageText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginFeaturesColumn extends StatelessWidget {
  final List<_LoginFeatureData> items;

  const _LoginFeaturesColumn({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 24),
          _LoginFeatureItem(data: items[i]),
        ],
      ],
    );
  }
}

class _LoginFeatureItem extends StatelessWidget {
  final _LoginFeatureData data;

  const _LoginFeatureItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.7),
              width: 1,
            ),
            color: Colors.white.withValues(alpha: 0.06),
          ),
          child: Icon(data.icon, color: Colors.white, size: 17),
        ),
        const SizedBox(height: 10),
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: _featureSubtitleOpacity),
              fontSize: 11,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginStatsRow extends StatelessWidget {
  final DashboardL10n l10n;

  const _LoginStatsRow({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LoginStatColumn(
          line1: l10n.loginIcaoBold,
          line2: l10n.loginCompliant,
        ),
        _LoginStatDivider(),
        _LoginStatColumn(
          line1: l10n.loginIsoBold,
          line2: l10n.loginCertified,
        ),
        _LoginStatDivider(),
        _LoginStatColumn(
          line1: l10n.loginSupportBold,
          line2: l10n.loginSupportLabel,
        ),
      ],
    );
  }
}

class _LoginStatColumn extends StatelessWidget {
  final String line1;
  final String line2;

  const _LoginStatColumn({required this.line1, required this.line2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            line1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            line2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: _statLabelOpacity),
              fontSize: 11,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginStatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: Colors.white.withValues(alpha: 0.35),
    );
  }
}

class _LoginBottomCard extends StatelessWidget {
  final DashboardL10n l10n;
  final bool isLoading;
  final bool showJwtSection;
  final TextEditingController jwtController;
  final VoidCallback onMicrosoftSignIn;
  final VoidCallback onToggleJwt;
  final VoidCallback onJwtLogin;

  const _LoginBottomCard({
    required this.l10n,
    required this.isLoading,
    required this.showJwtSection,
    required this.jwtController,
    required this.onMicrosoftSignIn,
    required this.onToggleJwt,
    required this.onJwtLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/50years_image.png',
                height: 52,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 18),
              Image.asset(
                'assets/images/caa_logo.png',
                height: 52,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: _buttonNavy,
                  strokeWidth: 2.5,
                ),
              ),
            )
          else ...[
            Center(
              child: Material(
                color: _buttonNavy,
                elevation: 0,
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: onMicrosoftSignIn,
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      width: 190,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 14,
                          ),
                          Flexible(
                            child: Text(
                              l10n.loginContinueWithMicrosoft,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const _MicrosoftLogo(size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onToggleJwt,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                showJwtSection ? l10n.loginHideJwt : l10n.loginWithJwt,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            if (showJwtSection) ...[
              const SizedBox(height: 8),
              TextField(
                controller: jwtController,
                maxLines: 2,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: l10n.loginJwtHint,
                  hintStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: _buttonNavy, width: 1.2),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 36,
                child: TextButton(
                  onPressed: onJwtLogin,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    l10n.loginWithJwt,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _MicrosoftLogo extends StatelessWidget {
  final double size;

  const _MicrosoftLogo({this.size = 14});

  @override
  Widget build(BuildContext context) {
    final half = size / 2;
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: half,
                height: half,
                color: const Color(0xFFF25022),
              ),
              Container(
                width: half,
                height: half,
                color: const Color(0xFF7FBA00),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: half,
                height: half,
                color: const Color(0xFF00A4EF),
              ),
              Container(
                width: half,
                height: half,
                color: const Color(0xFFFFB900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
