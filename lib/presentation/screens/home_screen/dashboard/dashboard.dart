import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/common_widgets.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/userModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/widgets/announcement/announcement.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/widgets/profileCard.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'controller.dart';

@RoutePage()
class AnnouncementScreen extends ConsumerWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
    final UserModel? user = state.user;

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero, // remove default padding
        children: [
          ProfileCard(
            title: "Profile",
            subtitle: "User Information",
            name: user?.data?.employeeName ?? '',
            avatarUrl:
                "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
            isOnline: true,
            info: {
              "Email": user?.data?.email ?? '',
              "Phone": user?.data?.mobile ?? '',
              "Location": user?.data?.location ?? '',
              "Role": user?.data?.position?.name ?? '',
            },
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: AnnouncementWidget(
              announcements: state.announcements, // ✅ pass the whole list
              title: 'Announcements',
              subtitle: 'Stay updated with the latest news',
            ),
          ),
        ],
      ),
    );
  }
}
