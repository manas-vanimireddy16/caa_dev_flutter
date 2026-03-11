// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
// import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
// import 'package:code_setup/presentation/screens/approvals/common_widgets.dart';
// import 'package:code_setup/presentation/screens/request_details/controller.dart';
// import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
// import 'package:code_setup/presentation/screens/request_details/models/commentItem.dart';
// import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
// import 'package:code_setup/presentation/screens/request_details/widgets.dart/attachments_tab.dart';
// import 'package:code_setup/presentation/screens/request_details/widgets.dart/request_details_tab.dart';
// import 'package:code_setup/presentation/screens/request_details/widgets.dart/request_history_tab.dart';
// import 'package:code_setup/presentation/screens/request_details/widgets.dart/request_tabs.dart';
// import 'package:code_setup/presentation/screens/request_details/widgets.dart/workflow_tab.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// @RoutePage()
// class ReuseRequestDetailsTabScreen extends ConsumerWidget {
//   final List<TaskRD> taskData;
//   final List<CommentItemRD> comments;
//   final List<AttachmentsmodelRD> attachments;

//   const ReuseRequestDetailsTabScreen({
//     super.key,
//     required this.taskData,
//     required this.comments,
//     required this.attachments,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedTab = ref.watch(requestDeatilsTabSelectedProvider);
//     return KScaffold(
//       backgroundColor: Colors.white,
//       appBar: KAppBar(title: const Text('Request Detail')),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             /// Profile Card
//             ProfileCard(
//               title: "Profile",
//               subtitle: "User Info",
//               name: "John Doe",
//               avatarUrl: "https://i.pravatar.cc/150?img=3",
//               isOnline: true,
//               info: {
//                 "Request ID": "REQ123456",
//                 "Customer ID": "CUST78910",
//                 "Job Title/Designation": "Software Engineer",
//                 "Department": "IT",
//                 "email": "john.doe@example.com",
//                 "phone": "+91 9876543210",
//                 "Request Type": "Access Request",
//               },
//             ),

//             5.toHorizontalSizedBox,

//             RequestTabs(selectedTab: selectedTab),

//             5.toHorizontalSizedBox,
//             const Divider(thickness: 1),

//             /// Tab Content
//             // if (selectedTab == 0)
//             //   RequestHistoryTabContent(
//             //     comments: comments,
//             //   ) // RequestDetailsTabContent()
//             // else if (selectedTab == 1)
//             //   RequestHistoryTabContent(comments: comments)
//             // else if (selectedTab == 2)
//             //   RequestHistoryTabContent(
//             //     comments: comments,
//             //   ) //AttachmentsTabContent(attachments: attachments)
//             // else if (selectedTab == 3)
//             //   RequestHistoryTabContent(
//             //     comments: comments,
//             //   ), //WorkflowTabContent(taskData: taskData),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/common_widgets.dart';
import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/commentItem.dart';
import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/attachments_tab.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/request_details_tab.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/request_history_tab.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/request_tabs.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/workflow_tab.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:code_setup/repository/request_details/domain/request_detail.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';
part 'widgets/remarksSend.dart';

@RoutePage()
class RequestDetailsTabScreen extends ConsumerWidget {
  final int id;
  final SalalahRequestDetailData data;

  const RequestDetailsTabScreen({
    super.key,

    required this.data,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(requestDeatilsTabSelectedProvider);
    final userData = KAppX.globalProvider.read(userProvider);
    final SalalahRequestData? request = data.request;
    final List<SalalahWorkflowDetail> workflows = data.workflowDetails ?? [];
    final List<AttachmentModel>? attachments = data.attachments;
    final List<ChatMessageModel>? chats = data.chatMessages;

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Detail')),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Profile Card
            ProfileCard(
              title: "Profile",
              subtitle: "User Info",
              name: request?.createdByUser?.employeeName ?? '',
              avatarUrl: "https://i.pravatar.cc/150?img=3",
              isOnline: true,
              info: {
                "Request ID": (request?.id ?? 0).toString(),
                "Customer ID": (request?.userId ?? 0).toString(),
                "Job Title/Designation":
                    request?.createdByUser?.directorate ?? 'N/A',
                "Department": request?.createdByUser?.category ?? 'N/A',
                "email": request?.createdByUser?.email ?? 'N/A',
                "phone": request?.createdByUser?.mobile ?? 'N/A',
                "Request Type": request?.requestFor ?? 'N/A',
              },
            ),

            5.toHorizontalSizedBox,

            RequestTabs(selectedTab: selectedTab),

            5.toHorizontalSizedBox,
            const Divider(thickness: 1),

            /// Tab Content
            if (selectedTab == 0)
              RequestDetailsTabContent(request: request)
            else if (selectedTab == 1)
              RequestHistoryTabContent(comments: chats ?? [], id: id)
            else if (selectedTab == 2)
              AttachmentsTabContent(attachments: attachments ?? [])
            else if (selectedTab == 3)
              WorkflowTabContent(workflows: workflows),
          ],
        ),
      ),
    );
  }
}
