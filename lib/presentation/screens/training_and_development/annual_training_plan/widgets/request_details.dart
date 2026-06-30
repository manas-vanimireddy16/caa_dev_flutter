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
class AnnualTrainingPlanDetailsScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const AnnualTrainingPlanDetailsScreen({
    super.key,
    required this.id,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.from = '',
  });

  @override
  ConsumerState createState() => _AnnualTrainingPlanDetailsScreenState();
}

class _AnnualTrainingPlanDetailsScreenState
    extends ConsumerState<AnnualTrainingPlanDetailsScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create proper provider params object
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    /// ✅ Fetch ONLY once (after init)
    Future.microtask(() {
      ref
          .read(_vsProvider(_providerArgs).notifier)
          .fetchRequestDetailsById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: KAppBar.requestDetailsTitle(l10n.requestDetailScreenTitle)),

      /// IMPORTANT — This fixes your issue.
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider(_providerArgs));

          if (state.requestDetails == null || state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final userInfo = KAppX.globalProvider.read(rolesProvider);

          // final request = state.requestDetails.request == null
          //     ? null
          //     : state.requestDetails;
          final request = state.requestDetails.request;
          final attachment = state.requestDetails.attachments;
          final requestId = request?.id;
          final List<WorkflowDetailModel> workflows =
              state.requestDetails.workflowDetails ?? [];
          final List<AttachmentModel> attachments =
              state.requestDetails.attachments ?? [];
          final chats = state.chatById;
          final List<ApprovalDetailModel> approvals =
              state.requestDetails.approvalDetails ?? [];
          final selectedTab = state.requestDetailTab;
          final active = controller.getActiveApprovalLevel(
            state.requestDetails.approvalDetails ?? [],
          );
          final actionType = controller.getActionButtonsType(
            state.requestDetails,
            approvals,
          );
          final nextApprover = controller.resolveApproverMap(approvals);

          final approverId = active?.id;
          final l10n = DashboardL10n.of(context);
          final createdByUser =
              request?.createdByUser ?? state.requestDetails.createdByUser;
          final approverMap = nextApprover;

          Widget employeeSection() => EmployeeInformationCard(
            l10n: l10n,
            requestId: requestId?.toString(),
            status: request?.status,
            assignedTo: approverMap['name'] ??
                approverMap['role'] ??
                approverMap['department'],
            user: createdByUser,
            labelBuilder: l10n.requestDetailsLabel,

            showStatusAndAssignedTo: selectedTab != 0,
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                5.toHorizontalSizedBox,
                RequestTabs(
                  selectedTab: selectedTab,
                  service: widget.service,
                  subService: widget.subService,
                ),
                5.toHorizontalSizedBox,

                /// ------------ TABS -----------------
                if (selectedTab == 0) ...[
                  employeeSection(),
                  CommonRequestDetails(
                    statusInfo: {
                      "Approval Status": request?.status ?? 'N/A',
                      "Requested Date": request?.createdAt ?? 'N/A',
                      // "Last Updated":
                      //     request?.updatedAt?.split('T').first ?? 'N/A',
                      if (nextApprover.containsKey('department'))
                        'Department': nextApprover['department']!,
                      if (nextApprover.containsKey('section'))
                        'Section': nextApprover['section']!,

                      if (nextApprover.containsKey('name'))
                        'Approver Name': nextApprover['name']!,
                      if (nextApprover.containsKey('email'))
                        'Approver Email': nextApprover['email']!,
                    },

                    requestInfo: {
                      /// ───── LEFT COLUMN ─────
                      "Sub Service Type":
                          request?.subService?.subServiceName ?? 'N/A',

                      "Name of Course": request?.dateOfEvent ?? 'N/A',

                      "No of Participants": request?.roomType ?? 'N/A',

                      "Place": request?.place ?? 'N/A',

                      "Course Cost": request?.courseCost ?? 'N/A',

                      /// ───── RIGHT COLUMN ─────
                      "Service Type": request?.service?.name ?? 'N/A',

                      "Total Cost": request?.totalCost ?? 'N/A',

                      "Reason": request?.reason ?? 'N/A',

                      "Proposed implementation date":
                          request?.proposedImplementationDate ?? 'N/A',

                      "Location": request?.location ?? 'N/A',
                      "Description": request?.description ?? 'N/A',
                    },
                    technicalInfo: {
                      'Extension Number':
                          request?.createdByUser?.extensionNumber.toString() ??
                          '0',
                    },
                  ),
                ] else if (selectedTab == 1) ...[
                  employeeSection(),
                  CommentsCard(
                    from: widget.from,
                    showButtons: actionType != ActionButtonsType.none,
                    actionType: actionType, // ✅ FIX HERE
                    entries: chats,
                    controller: controller.chatController,
                    buttonsDisabled: state.isButtonDisabled,
                    attachments: state.attachments,
                    onAttach: () async {
                      await controller.pickFile();
                    },
                    onRemove: () {
                      controller.removeAttachment();
                    },
                    onSend: () async {
                      controller.sendChatMessage(
                        serviceId: widget.serviceId,
                        subServiceId: widget.subServiceId,
                      );
                    },
                    onApprove: () async {
                      controller.showApprovalCommentDialog(
                        type: ApprovalDialogType.approve,
                        approverId: approverId ?? 0,
                        requestId: requestId ?? 0,
                      );
                      // controller.onApprove(
                      //   approverId ?? 0,
                      //   requestId ?? 0,
                      //   'Approved',
                      // );
                    },
                    onReject: () async {
                      controller.showApprovalCommentDialog(
                        type: ApprovalDialogType.reject,
                        approverId: approverId ?? 0,
                        requestId: requestId ?? 0,
                      );
                      // controller.onReject(
                      //   approverId ?? 0,
                      //   requestId ?? 0,
                      //   'Rejected',
                      // );
                    },
                  ),
                ] else if (selectedTab == 2) ...[
                  employeeSection(),
                  CommonAttachmentsTabContent(
                    attachments: attachments,
                    onDelete: (attachment) async {
                      await controller.deleteAttachment(
                        attachment.id ?? 0,
                        requestId: attachment.requestId ?? requestId,
                      );
                    },
                  ),
                ] else if (selectedTab == 3) ...[
                  employeeSection(),
                  RequestWorkflowTimeline(details: state.requestDetails),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
