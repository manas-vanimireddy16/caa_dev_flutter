import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/common_widgets/section_content_divider.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/common_widgets.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/dashboard_requests_approvals.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/userModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/widgets/announcement/announcement.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/dashboard_request_details_navigator.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';
part 'widgets/dashboard_requests_card.dart';

@RoutePage()
class AnnouncementScreen extends ConsumerWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final l10n = DashboardL10n.of(context);
    final storedUser = ref.watch(userProvider);
    final userInfo = ref.watch(userInfoProvider);
    final profile = state.user?.data;
    final sessionProfile = userInfo?.data;
    final userName = _displayEmployeeName(
      l10n: l10n,
      profile: profile,
      sessionProfile: sessionProfile,
      storedUser: storedUser,
    );
    final avatarUrl = _firstNonEmpty([profile?.avatar, sessionProfile?.avatar]);

    return KScaffold(
      backgroundColor: AppColors.homeSurfaceColor,
      appBar: AppBar(
        toolbarHeight: 64,
        titleSpacing: 16,
        title: _HomeGreetingHeader(
          userName: userName,
          avatarUrl: avatarUrl,
          greeting: l10n.goodMorning,
        ),
        actions: const [_NotificationBellButton()],
        foregroundColor: AppColors.textHeading,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE6E6EA), width: 1),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero, // remove default padding
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: AnnouncementWidget(
              announcements: state.announcements, // ✅ pass the whole list
              title: l10n.latestAnnouncements,
              subtitle: l10n.announcementsSubtext,
            ),
          ),
          _HomeSectionTitle(title: l10n.dashboard),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: DashboardRequestsCard(),
          ),
        ],
      ),
    );
  }
}

@RoutePage()
class LinksScreen extends StatelessWidget {
  const LinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    return KScaffold(
      backgroundColor: AppColors.homeSurfaceColor,
      appBar: AppBar(
        title: Text(
          l10n.links,
          style: AppTextStyles.cairo(
            fontSize: 20.toAutoScaledFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 64,
        foregroundColor: AppColors.textHeading,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(child: Text('Coming Soon')),
    );
  }
}

@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final UserModel? user = state.user;
    final storedUser = ref.watch(userProvider);
    final userInfo = ref.watch(userInfoProvider);
    final l10n = DashboardL10n.of(context);
    final profile = user?.data;
    final sessionProfile = userInfo?.data;
    final avatarUrl =
        _firstNonEmpty([profile?.avatar, sessionProfile?.avatar]) ??
        'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';

    return KScaffold(
      backgroundColor: AppColors.homeSurfaceColor,
      appBar: AppBar(
        title: Text(
          l10n.myProfile,
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ProfileCard(
            title: l10n.myProfile,
            subtitle: l10n.findTheProfileDetails,
            name: _displayEmployeeName(
              l10n: l10n,
              profile: profile,
              sessionProfile: sessionProfile,
              storedUser: storedUser,
            ),
            avatarUrl: avatarUrl,
            isOnline: true,
            info: {
              l10n.profileEmailLabel:
                  _firstNonEmpty([
                    profile?.email,
                    sessionProfile?.email,
                    storedUser?.email,
                  ]) ??
                  '',
              l10n.profilePhoneLabel:
                  _firstNonEmpty([profile?.mobile, sessionProfile?.mobile]) ??
                  '',
              l10n.profileLocationLabel:
                  _firstNonEmpty([
                    profile?.location,
                    sessionProfile?.location,
                  ]) ??
                  '',
              l10n.profileRoleLabel:
                  _firstNonEmpty([
                    profile?.position?.name,
                    sessionProfile?.position?.name,
                    storedUser?.positionName,
                  ]) ??
                  '',
              l10n.employeeId:
                  _firstNonEmpty([
                    profile?.employeeId,
                    sessionProfile?.employeeId,
                    storedUser?.employeeId,
                  ]) ??
                  '',
              l10n.department:
                  _firstNonEmpty([
                    profile?.department?.departmentName,
                    sessionProfile?.department?.departmentName,
                    storedUser?.departmentName,
                  ]) ??
                  '',
            },
          ),
        ],
      ),
    );
  }
}

class _HomeGreetingHeader extends StatelessWidget {
  final String userName;
  final String? avatarUrl;
  final String greeting;

  const _HomeGreetingHeader({
    required this.userName,
    this.avatarUrl,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE8DDF4),
              backgroundImage: avatarUrl == null
                  ? null
                  : NetworkImage(avatarUrl!),
              child: avatarUrl == null
                  ? const Icon(Icons.person, color: Color(0xFF6C4FA3))
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: AppTextStyles.cairo(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                userName.isEmpty ? '-' : userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cairo(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationBellButton extends StatelessWidget {
  const _NotificationBellButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Notifications',
      icon: const Icon(Icons.notifications_none, color: Colors.black, size: 26),
      onPressed: () {},
    );
  }
}

String? _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return null;
}

String _displayEmployeeName({
  required DashboardL10n l10n,
  required dynamic profile,
  required dynamic sessionProfile,
  required dynamic storedUser,
}) {
  if (l10n.isArabic) {
    return _firstNonEmpty([
          profile?.employeeArabicName,
          sessionProfile?.employeeArabicName,
          storedUser?.employeeArabicName,
          profile?.employeeName,
          sessionProfile?.employeeName,
          storedUser?.employeeName,
        ]) ??
        '';
  }

  return _firstNonEmpty([
        profile?.employeeName,
        sessionProfile?.employeeName,
        storedUser?.employeeName,
      ]) ??
      '';
}

class _HomeSectionTitle extends StatelessWidget {
  final String title;

  const _HomeSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: AppTextStyles.cairo(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }
}
