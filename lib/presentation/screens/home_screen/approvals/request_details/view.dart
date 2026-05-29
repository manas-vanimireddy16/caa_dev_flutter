import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/common_widgets.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/controller.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/IconAction.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/customCard.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/workProgess.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/buildChangewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RequestDetailScreen extends ConsumerStatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  ConsumerState<RequestDetailScreen> createState() =>
      _RequestDetailScreenState();
}

class _RequestDetailScreenState extends ConsumerState<RequestDetailScreen> {
  late final TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    _remarksController = TextEditingController();
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(requestDeatilsTabSelectedProvider);
    final routingEntries = comments
        .map((comment) {
          return ChatMessageModel(
            message: comment.message,
            status: comment.status,
            createdAt: comment.dateTime.toIso8601String(),
          );
        })
        .toList(growable: false);

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Details')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
        children: [
          ProfileCard(
            title: 'Profile',
            subtitle: 'User Information',
            name: 'John Doe',
            avatarUrl: 'https://i.pravatar.cc/150?img=3',
            isOnline: true,
            info: const {
              'Request ID': 'REQ123456',
              'Customer ID': 'CUST78910',
              'Job Title/Designation': 'Software Engineer',
              'Department': 'IT',
              'email': 'john.doe@example.com',
              'phone': '+91 9876543210',
              'Request Type': 'Access Request',
            },
          ),
          5.toHorizontalSizedBox,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabItem(
                  text: 'Request Details',
                  index: 0,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          0,
                ),
                TabItem(
                  text: 'Request History',
                  index: 1,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          1,
                ),
                TabItem(
                  text: 'Attachments',
                  index: 2,
                  selectedIndex: selectedTab,
                  onTap: () =>
                      ref
                              .read(requestDeatilsTabSelectedProvider.notifier)
                              .state =
                          2,
                ),
                TabItem(
                  text: 'Work Flow',
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
          if (selectedTab == 0) ...[
            CardInfo(
              title: 'Status Information',
              info: const {
                'Request Date': '2023-10-01',
                'Status': 'Pending',
                'Approver': 'shaik@gmail.com',
                'Assigned To': 'Manager',
              },
            ),
            const SizedBox(height: 5),
            CardInfo(
              title: 'Request Information',
              info: const {
                'Request for': 'Self',
                'Service Type': 'IT Services',
                'Problem Statement':
                    'Need access to the new project repository for development.',
                'Description':
                    'The project involves working on a new feature that requires access to the repository. Please approve the access at the earliest.',
              },
            ),
            const SizedBox(height: 5),
            CardInfo(
              title: 'Technical Details',
              info: const {'extension number': '1234567890'},
            ),
          ],
          if (selectedTab == 1)
            CommentsCard(
              from: 'action items',
              showButtons: true,
              entries: routingEntries,
              controller: _remarksController,
              actionType: ActionButtonsType.approveReject,
              attachments: const [],
              onAttach: () {},
              onRemove: () {},
              onSend: () async {},
              onApprove: () async {},
              onReject: () async {},
            ),
          if (selectedTab == 2)
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 400,
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
                              'Download ${attachment.downloadUrl}',
                            ),
                          ),
                          CardAction(
                            icon: Icons.remove_red_eye,
                            color: Colors.blueGrey,
                            onPressed: () =>
                                debugPrint('View ${attachment.documentName}'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          if (selectedTab == 3)
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 16),
                child: SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasksData.length,
                    itemBuilder: (context, index) {
                      return TimelineItem(
                        task: tasksData[index],
                        isLast: index == tasksData.length - 1,
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
