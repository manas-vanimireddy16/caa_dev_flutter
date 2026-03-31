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
class OrganizeSecurityAwarenessRequestDetailsTabScreen
    extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final Service service;
  final SubService subService;
  const OrganizeSecurityAwarenessRequestDetailsTabScreen({
    super.key,
    required this.id,
    this.from = '',
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState createState() =>
      _OrganizeSecurityAwarenessRequestDetailsTabScreenState();
}

class _OrganizeSecurityAwarenessRequestDetailsTabScreenState
    extends ConsumerState<OrganizeSecurityAwarenessRequestDetailsTabScreen> {
  late _VSControllerParams _providerArgs;
  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    /// Fetch ONLY once
    Future.microtask(() {
      ref
          .read(_vsProvider(_providerArgs).notifier)
          .fetchRequestDetailsById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Detail')),

      /// IMPORTANT — This fixes your issue.
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider(_providerArgs));

          if (state.requestDetails == null || state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final userInfo = KAppX.globalProvider.read(rolesProvider);
          final request = state.requestDetails.request;
          final requestId = request?.id;
          final List<WorkflowDetailModel> workflows =
              state.requestDetails.workflowDetails ?? [];
          final List<AttachmentModel> attachments =
              state.requestDetails.attachments ?? [];
          final chats = state.requestDetails.chatMessages ?? [];
          final List<ApprovalDetailModel> approvals =
              state.requestDetails.approvalDetails ?? [];
          final selectedTab = state.requestDetailTab;
          final active = controller.getActiveApprovalLevel(
            state.requestDetails.approvalDetails ?? [],
          );
          final actionType = controller.getActionButtonsType(approvals);

          final approverRoleId = active?.approverRoleId;
          final bool? isManager = active?.isManager;
          // controller.onSelectedApprovalId(approverRoleId ?? 0);
          final threatIndex = (request?.typeOfThreat ?? 1) - 1;
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
                    // "Request Type": request?.requestFor ?? 'N/A',
                  },
                ),

                5.toHorizontalSizedBox,
                RequestDetailsTabs(
                  selectedTab: selectedTab,
                  service: widget.service,
                  subService: widget.subService,
                ),
                5.toHorizontalSizedBox,
                const Divider(thickness: 1),

                /// ------------ TABS -----------------
                if (selectedTab == 0)
                  CommonRequestDetails(
                    statusInfo: controller.buildStatusInformation(),

                    requestInfo: controller.buildRequestInformationData(),
                    technicalInfo: controller.buildTechnicalInformation(),
                    // table: controller.mapAccommodationTableForDetails(),
                  )
                else if (selectedTab == 1)
                  CommentsCard(
                    from: widget.from,
                    source: isManager ?? true ? '' : 'securityawarenessassign',
                    showButtons: actionType != ActionButtonsType.none,
                    actionType: actionType, // ✅ FIX HERE
                    entries: chats,
                    attachments: [],
                    controller: controller.chatController,
                    onSend: () async {},
                    onClose: () async {},
                    onReject: () async {},
                    onAssign: () async {
                      await controller.showAssignEngineerDialog(
                        requestId: requestId ?? 0,
                        approverRoleId: approverRoleId ?? 0,
                        // departmentId: userInfo?.departmentId,
                        // sectionId: userInfo?.sectionId,
                      );
                    }, // You can connect later
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
