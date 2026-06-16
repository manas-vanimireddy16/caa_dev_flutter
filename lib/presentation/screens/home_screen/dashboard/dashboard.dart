import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/common_widgets.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/dashboard_requests_approvals.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/userModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/widgets/announcement/announcement.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
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

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero, // remove default padding
        children: [
          const _HomeSectionTitle(title: 'Announcements'),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: AnnouncementWidget(
              announcements: state.announcements, // ✅ pass the whole list
              title: l10n.announcements,
              subtitle: l10n.announcementsSubtext,
            ),
          ),
          const _HomeSectionTitle(title: 'Dashboard'),
          const Padding(
            padding: EdgeInsets.fromLTRB(11, 0, 11, 16),
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
    return KScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Links'),
        backgroundColor: Colors.transparent,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ProfileCard(
            title: l10n.myProfile,
            subtitle: l10n.findTheProfileDetails,
            name:
                _firstNonEmpty([
                  profile?.employeeName,
                  sessionProfile?.employeeName,
                  storedUser?.employeeName,
                ]) ??
                '',
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
              'Employee ID':
                  _firstNonEmpty([
                    profile?.employeeId,
                    sessionProfile?.employeeId,
                    storedUser?.employeeId,
                  ]) ??
                  '',
              'Department':
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

String? _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return null;
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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }
}
