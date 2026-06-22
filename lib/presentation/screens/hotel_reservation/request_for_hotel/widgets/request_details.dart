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
class HotelReservationRequestDetailsTabScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;

  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const HotelReservationRequestDetailsTabScreen({
    super.key,
    required this.id,
    this.from = '',

    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState createState() =>
      _HotelReservationRequestDetailsTabScreenState();
}

class _HotelReservationRequestDetailsTabScreenState
    extends ConsumerState<HotelReservationRequestDetailsTabScreen> {
  late _VSControllerParams _providerArgs;
  @override
  void initState() {
    super.initState();
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

    /// Fetch ONLY once
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: Text(l10n.requestDetailScreenTitle)),

      /// IMPORTANT — This fixes your issue.
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider(_providerArgs));

          if (state.requestDetails == null || state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // final request = state.requestDetails.request == null
          //     ? null
          //     : state.requestDetails;
          final request = state.requestDetails.request;
          final createdByUser =
              request?.createdByUser ?? state.requestDetails.createdByUser;
          final requestId = request?.id;
          final List<AttachmentModel> attachments = state.attachmentsById;
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

          final approverId = active?.id;

          // controller.onSelectedApprovalId(approverRoleId ?? 0);
          // final canApprove = controller.shouldShowApprovalButtons(approvals);

          return SingleChildScrollView(
            child: Column(
              children: [
                /// ----------- Profile Section --------------
                5.toHorizontalSizedBox,
                RequestDetailsTabs(
                  selectedTab: selectedTab,
                  service: widget.service,
                  subService: widget.subService,
                ),
                5.toHorizontalSizedBox,

                /// ------------ TABS -----------------
                if (selectedTab == 0) ...[
                  EmployeeInformationCard(
                    l10n: l10n,
                    requestId: requestId?.toString(),
                    status: request?.status,
                    assignedTo: controller.buildAssignedToLabel(approvals),
                    user: createdByUser,
                    labelBuilder: l10n.requestDetailsLabel,
                  ),
                  CommonRequestDetails(
                    statusInformationTitle: l10n.requestDetailsLabel(
                      'Status Information',
                    ),
                    requestInformationTitle: l10n.requestDetailsLabel(
                      'Request Information',
                    ),
                    technicalInformationTitle: l10n.technicalDetailsSection,
                    requestDetailsLabelBuilder: l10n.requestDetailsLabel,
                    statusInfo: controller.buildStatusInformation(),
                    requestInfo: controller.buildRequestInformationData(),
                    technicalInfo: controller.buildTechnicalInformation(),
                    // table: controller.mapAccommodationTableForDetails(),
                  ),
                ] else if (selectedTab == 1)
                  CommentsCard(
                    from: widget.from,
                    showButtons: actionType != ActionButtonsType.none,
                    actionType: actionType, // ✅ FIX HERE
                    entries: chats,
                    controller: controller.chatController,
                    buttonsDisabled: state.isButtonDisabled,
                    attachments: state.attachments,
                    l10n: l10n,
                    onAttach: () async {
                      await controller.pickFile();
                    },
                    onRemove: () {
                      controller.removeAttachment();
                    },
                    onSend: () async {
                      await controller.sendChatMessage(
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
                    },
                    onReject: () async {
                      controller.showApprovalCommentDialog(
                        type: ApprovalDialogType.reject,
                        approverId: approverId ?? 0,
                        requestId: requestId ?? 0,
                      );
                    },
                  )
                else if (selectedTab == 2)
                  CommonAttachmentsTabContent(
                    attachments: attachments,
                    l10n: l10n,

                    onDelete: (attachment) async {
                      await controller.deleteAttachment(
                        attachment.id ?? 0,
                        requestId: attachment.requestId ?? requestId,
                      );
                    },
                  )
                else if (selectedTab == 3)
                  RequestWorkflowTimeline(
                    details: state.requestDetails,
                    l10n: l10n,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
