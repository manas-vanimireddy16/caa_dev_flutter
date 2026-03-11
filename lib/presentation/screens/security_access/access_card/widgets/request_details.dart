// // import 'package:auto_route/auto_route.dart';
// // import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
// // import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// // import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
// // import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
// // import 'package:code_setup/presentation/screens/approvals/common_widgets.dart';
// // import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
// // import 'package:code_setup/presentation/screens/logistics/view.dart';
// // import 'package:code_setup/presentation/screens/logistics/widgets/attachments_tab.dart';
// // import 'package:code_setup/presentation/screens/logistics/widgets/request_details_tab.dart';
// // import 'package:code_setup/presentation/screens/logistics/widgets/request_history_tab.dart';
// // import 'package:code_setup/presentation/screens/logistics/widgets/request_tabs.dart';
// // import 'package:code_setup/presentation/screens/logistics/widgets/workflow_tab.dart';
// // import 'package:code_setup/utils/app_extensions/app_extension.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// part of '../view.dart';

// @RoutePage()
// class AccessCardRequestDetailsTabScreen extends ConsumerWidget {
//   final int id;
//   final RequestDetailModel data;
//   final String from;

//   const AccessCardRequestDetailsTabScreen({
//     super.key,
//     this.from = '',
//     required this.data,
//     required this.id,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedTab = ref.watch(requestDeatilsTabSelectedProvider);
//     final userData = KAppX.globalProvider.read(userProvider);

//     final state = ref.watch(_vsProvider);
//     final stateController = ref.read(_vsProvider.notifier);
//     final RequestDetailModel details = state.requestDataById;
//     final RequestDetailData? result = details.data;
//     final List<Workflow> workflows = result?.workflowDetails ?? [];
//     final List<AttachmentDetail>? attachments = result?.attachments ?? [];
//     final List<ChatMessage>? chats = result?.chatMessages;
//     final List<ApprovalDetails>? approvals = result?.approvalDetails;

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
//               name: result?.request?.createdByUser?.employeeName ?? '',
//               avatarUrl: "https://i.pravatar.cc/150?img=3",
//               isOnline: true,
//               info: {
//                 "Request ID": (result?.request?.id ?? 0).toString(),
//                 "Employee ID":
//                     result?.request?.createdByUser?.employeeId ?? 'N/A',
//                 "Job Title/Designation":
//                     result?.request?.createdByUser?.directorate ?? 'N/A',
//                 "email": result?.request?.createdByUser?.email ?? 'N/A',
//                 "Department": result?.request?.createdByUser?.category ?? 'N/A',

//                 "Contact Number":
//                     result?.request?.createdByUser?.mobile ?? 'N/A',
//               },
//             ),

//             5.toHorizontalSizedBox,

//             RequestTabs(selectedTab: selectedTab),

//             5.toHorizontalSizedBox,
//             const Divider(thickness: 1),

//             /// Tab Content
//             if (selectedTab == 0)
//               RequestDetailsTabContent(request: result, from: from)
//             else if (selectedTab == 1)
//               RequestHistoryTabContent(
//                 comments: chats ?? [],
//                 id: id,
//                 approvals: approvals ?? [],
//               )
//             else if (selectedTab == 2)
//               AttachmentsTabContent(attachments: attachments ?? [])
//             else if (selectedTab == 3)
//               WorkflowTabContent(workflows: workflows),
//           ],
//         ),
//       ),
//     );
//   }
// }

part of '../view.dart';

@RoutePage()
class AccessCardRequestDetailsTabScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;
  const AccessCardRequestDetailsTabScreen({
    super.key,
    required this.id,
    this.from = '',
  });

  @override
  ConsumerState createState() => _AccessCardRequestDetailsTabScreenState();
}

class _AccessCardRequestDetailsTabScreenState
    extends ConsumerState<AccessCardRequestDetailsTabScreen> {
  @override
  void initState() {
    super.initState();

    /// Fetch ONLY once
    Future.microtask(() {
      ref.read(_vsProvider.notifier).fetchRequestDetailsById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider.notifier);

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Detail')),

      /// IMPORTANT — This fixes your issue.
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider);

          if (state.requestDetails == null || state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final request = state.requestDetails.request;
          final requestId = request?.id;
          final List<WorkflowDetailModel> workflows =
              state.requestDetails.workflowDetails ?? [];
          final List<AttachmentModel> attachments =
              state.requestDetails.attachments ?? [];
          final chats = state.requestDetails.chatMessages ?? [];
          final List<ApprovalDetailModel> approvals =
              state.requestDetails?.approvalDetails ?? [];
          final selectedTab = state.requestDetailTab;
          final active = controller.getActiveApprovalLevel(
            state?.requestDetails?.approvalDetails ?? [],
          );

          final approverId = active?.id;
          // final canApprove = controller.shouldShowApprovalButtons(approvals);

          return SingleChildScrollView(
            child: Column(
              children: [
                /// ----------- Profile Section --------------
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
                    "Email": request?.createdByUser?.email ?? 'N/A',
                    "Phone": request?.createdByUser?.mobile ?? 'N/A',
                    "Request Type": request?.requestFor ?? 'N/A',
                  },
                ),

                5.toHorizontalSizedBox,
                RequestTabs(selectedTab: selectedTab),
                5.toHorizontalSizedBox,
                const Divider(thickness: 1),

                /// ------------ TABS -----------------
                if (selectedTab == 0)
                  RequestDetailsTabContent(
                    request: state.requestDetails,
                    // from: 'salalah',
                    // data: state.requestDetails,
                  )
                else if (selectedTab == 1)
                  CommentsCard(
                    from: 'action items',
                    showButtons: controller.shouldShowApprovalButtons(
                      approvals,
                    ),
                    entries: chats,
                    controller: controller.chatController,
                    onSend: () async {},
                    attachments: [],
                    onApprove: () async {
                      controller.onClose(
                        approverId ?? 0,
                        requestId ?? 0,
                        "Approved",
                      );
                    },
                    onReject: () async {
                      controller.onClose(
                        approverId ?? 0,
                        requestId ?? 0,
                        "Rejected",
                      );
                    },
                    actionType: ActionButtonsType.none,
                  )
                else if (selectedTab == 2)
                  CommonAttachmentsTabContent(attachments: attachments)
                else if (selectedTab == 3)
                  RequestWorkflowTimeline(details: state.requestDetails),
              ],
            ),
          );
        },
      ),
    );
  }
}
