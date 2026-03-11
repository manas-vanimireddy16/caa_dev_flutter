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

// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
// import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
// import 'package:code_setup/presentation/screens/approvals/common_widgets.dart';
// import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
// import 'package:code_setup/presentation/screens/logistics/view.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/attachments_tab.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/request_details_tab.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/request_history_tab.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/request_tabs.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/workflow_tab.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

part of '../view.dart';

@RoutePage()
class VPNRequestDetailsTabScreen extends ConsumerWidget {
  final int id;
  final String from;

  const VPNRequestDetailsTabScreen({
    super.key,
    this.from = '',
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final selectedTab = state.selectedRequestTab;

    final stateController = ref.read(_vsProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!state.isLoading && state.requestById.data == null) {
        await stateController.fetchRequestById(id);
      }
    });
    final VpnRequestByIdModel details = state.requestById;
    final VpnRequestByIdData? result = details.data;
    final List<VPNWorkflowDetail> workflows = result?.workflowDetails ?? [];
    final List<VPNAttachment>? attachments = result?.attachments ?? [];
    final List<VPNChatMessage>? chats = result?.chatMessages;
    final List<VPNApprovalDetail>? approvals = result?.approvalDetails;

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Detail')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  /// Profile Card
                  ProfileCard(
                    title: "Profile",
                    subtitle: "User Info",
                    name: result?.request?.createdByUser?.employeeName ?? '',
                    avatarUrl: "https://i.pravatar.cc/150?img=3",
                    isOnline: true,
                    info: {
                      "Request ID": (result?.request?.id ?? 0).toString(),
                      "Employee ID":
                          result?.request?.createdByUser?.employeeId ?? 'N/A',
                      "Job Title/Designation":
                          result?.request?.createdByUser?.directorate ?? 'N/A',
                      "email": result?.request?.createdByUser?.email ?? 'N/A',
                      "Department":
                          result?.request?.createdByUser?.category ?? 'N/A',
                      "Contact Number":
                          result?.request?.createdByUser?.mobile ?? 'N/A',
                    },
                  ),

                  5.toHorizontalSizedBox,

                  RequestTabs(selectedTab: selectedTab),

                  5.toHorizontalSizedBox,
                  const Divider(thickness: 1),

                  /// Tab Content
                  if (selectedTab == 0)
                    RequestDetailsTabContent<VpnRequestByIdData>(
                      from: 'employee',
                      request: result,
                    )
                  else if (selectedTab == 1)
                    RequestHistoryTabContent<VpnRequestByIdData>(
                      from: from,
                      id: id,
                      comments: chats ?? [],
                      approvals: approvals ?? [],
                    )
                  else if (selectedTab == 2)
                    AttachmentsTabContent<VPNAttachment>(
                      attachments: attachments ?? [],
                    )
                  else if (selectedTab == 3)
                    WorkflowTabContent<VPNWorkflowDetail>(workflows: workflows),
                ],
              ),
            ),
    );
  }
}
