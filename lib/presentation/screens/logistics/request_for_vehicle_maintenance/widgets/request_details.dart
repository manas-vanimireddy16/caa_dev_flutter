part of '../view.dart';

@RoutePage()
class RequestForVehicleMaintenanceDetailsTabScreen
    extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const RequestForVehicleMaintenanceDetailsTabScreen({
    super.key,
    required this.id,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.from = '',
  });

  @override
  ConsumerState createState() =>
      _RequestForVehicleMaintenanceDetailsTabScreenState();
}

class _RequestForVehicleMaintenanceDetailsTabScreenState
    extends ConsumerState<RequestForVehicleMaintenanceDetailsTabScreen> {
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
      final controller = ref.read(_vsProvider(_providerArgs).notifier);
      final pendingTab = PendingRequestDetailTabRegistry.consumeIfPresent(
        serviceId: widget.serviceId,
        subServiceId: widget.subServiceId,
      );
      if (pendingTab != null) {
        controller.updateRequestTab(pendingTab);
      }
      controller.fetchRequestDetailsById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: AppColors.homeSurfaceColor,
      appBar: KAppBar(title: KAppBar.requestDetailsTitle(l10n.requestDetailScreenTitle)),

      /// IMPORTANT — This fixes your issue.
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider(_providerArgs));

          if (state.requestDetails == null || state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

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

          return SingleChildScrollView(
            child: Column(
              children: [
                16.toVerticalSizedBox,
                RequestDetailsTabs(
                  selectedTab: selectedTab,
                  service: widget.service,
                  subService: widget.subService,
                ),
                5.toHorizontalSizedBox,

                EmployeeInformationCard(
                  l10n: l10n,
                  requestId: requestId?.toString(),
                  status: request?.status,
                  assignedTo: controller.buildAssignedToLabel(approvals),
                  user: createdByUser,
                  labelBuilder: l10n.requestDetailsLabel,
                  showStatusAndAssignedTo: selectedTab != 0,
                ),

                /// ------------ TABS -----------------
                if (selectedTab == 0) ...[
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
                  ),
                ] else if (selectedTab == 1)
                  CommentsCard(
                    from: widget.from,
                    showButtons: actionType != ActionButtonsType.none,
                    actionType: actionType,
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
