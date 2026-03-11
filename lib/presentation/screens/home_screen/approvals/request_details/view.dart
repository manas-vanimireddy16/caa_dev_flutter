import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/customCard.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/common_widgets.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/controller.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/IconAction.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/remarksSend.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/statusInfo.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/workProgess.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/buildChangewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RequestDetailScreen extends ConsumerWidget {
  const RequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(requestDeatilsTabSelectedProvider);
    final task_data = tasksData;

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Detail')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// ----------- Tabs ------------

          /// ----------- Profile Card ------------
          ProfileCard(
            title: "Profile",
            subtitle: "User Information",
            name: "John Doe",
            avatarUrl: "https://i.pravatar.cc/150?img=3",
            isOnline: true,
            info: {
              "Request ID": "REQ123456",
              "Customer ID": "CUST78910",
              "Job Title/Designation": "Software Engineer",
              "Department": "IT",
              "email": "john.doe@example.com",
              "phone": "+91 9876543210",
              "Request Type": "Access Request",
            },
          ),

          5.toHorizontalSizedBox,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabItem(
                  text: "Request Details",
                  index: 0,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          0,
                ),
                TabItem(
                  text: "Request History",
                  index: 1,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          1,
                ),
                TabItem(
                  text: "Attachments",
                  index: 2,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          2,
                ),
                TabItem(
                  text: "Work Flow",
                  index: 3,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          3,
                ),
              ],
            ),
          ),
          5.toHorizontalSizedBox,
          const Divider(thickness: 1),

          /// ----------- Tab 0: Request Details ------------
          if (selectedTab == 0) ...[
            CardInfo(
              title: "Status Information",
              info: {
                "Request Date": "2023-10-01",
                "Status": "Pending",
                "Approver": "shaik@gmail.com",
                "Assigned To": "Manager",
              },
            ),
            const SizedBox(height: 5),
            CardInfo(
              title: "Request Information",
              info: {
                "Request for": "Self",
                "Service Type": "IT Services",
                "Problem Statement":
                    "Need access to the new project repository for development.",
                "Description":
                    "The project involves working on a new feature that requires access to the repository. Please approve the access at the earliest.",
              },
            ),
            const SizedBox(height: 5),
            CardInfo(
              title: "Technical Details",
              info: {"extension number": "1234567890"},
            ),
          ],

          /// ----------- Tab 1: Request History ------------
          if (selectedTab == 1) ...[
            Card(
              color: Colors.white,
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                  shrinkWrap: true, // ✅ fixes nested scrolling
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return StatusInfo(
                      userName: comment.userName,
                      initials: comment.initials,
                      message: comment.message,
                      dateTime: '2025-10-24T09:11:42.286Z',
                    );
                  },
                ),
              ),
            ),
            RemarksSend(
              title: "Add Remarks",
              subtitle: "You can add your comments or remarks below.",
            ),
          ],

          /// ----------- Tab 2: Attachments ------------
          if (selectedTab == 2) ...[
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400, // 👈 give fixed height for scrollable area
                  child: ListView.builder(
                    itemCount: attachments.length,
                    itemBuilder: (context, index) {
                      final attachment = attachments[index];
                      return CustomCard(
                        data: attachment,
                        actions: [
                          CardAction(
                            icon: Icons.download,
                            color: Colors.green,
                            onPressed: () => debugPrint(
                              "Download ${attachment.downloadUrl}",
                            ),
                          ),
                          CardAction(
                            icon: Icons.remove_red_eye,
                            color: Colors.blueGrey,
                            onPressed: () =>
                                debugPrint("View ${attachment.documentName}"),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],

          if (selectedTab == 3) ...[
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 24.0,
                  bottom: 16.0,
                ),
                child: SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: task_data.length,
                    itemBuilder: (context, index) {
                      return TimelineItem(
                        task: task_data[index],
                        isLast: index == task_data.length - 1,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
