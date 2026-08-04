part of '../view.dart';

@RoutePage()
class FollowUpReportDetailsScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const FollowUpReportDetailsScreen({
    super.key,
    required this.id,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.from = '',
  });

  @override
  ConsumerState createState() => _FollowUpReportDetailsScreenState();
}

class _FollowUpReportDetailsScreenState
    extends ConsumerState<FollowUpReportDetailsScreen> {
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
      backgroundColor: Colors.white,
      appBar: KAppBar(title: KAppBar.requestDetailsTitle(l10n.requestDetailScreenTitle)),

      /// IMPORTANT — This fixes your issue.
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider(_providerArgs));
          final l10n = DashboardL10n.of(context);

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // final request = state.requestDetails.request == null
          //     ? null
          //     : state.requestDetails;
          final request = state.requestDetails.request;
          final requestId = request?.id;
          final List<AttachmentModel> attachments = state.attachmentsById;
          final chats = state.chatById;
          final List<ApprovalDetailModel> approvals =
              state.requestDetails.approvalDetails ?? [];
          final selectedTab = state.requestDetailTab;

          final createdByUser =
              request?.createdByUser ?? state.requestDetails.createdByUser;
          final active = controller.getActiveApprovalLevel(
            state.requestDetails.approvalDetails ?? [],
          );
          final actionType = controller.getActionButtonsType(
            state.requestDetails,
            approvals,
          );
          final isFromActionItems = widget.from.toLowerCase() == 'action items';

          final approverId = active?.id;

          // controller.onSelectedApprovalId(approverRoleId ?? 0);
          // final canApprove = controller.shouldShowApprovalButtons(approvals);

          return SingleChildScrollView(
            child: Column(
              children: [
                /// ----------- Profile Section --------------
                16.toVerticalSizedBox,
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

                    showStatusAndAssignedTo: selectedTab != 0,
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
                ] else if (selectedTab == 1) ...[
                  EmployeeInformationCard(
                    l10n: l10n,
                    requestId: requestId?.toString(),
                    status: request?.status,
                    assignedTo: controller.buildAssignedToLabel(approvals),
                    user: createdByUser,
                    labelBuilder: l10n.requestDetailsLabel,

                    showStatusAndAssignedTo: selectedTab != 0,
                  ),
                  CommentsCard(
                    from: widget.from,
                    showButtons:
                        isFromActionItems &&
                        actionType != ActionButtonsType.none,
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
                    },
                    onUpdate: () async {
                      await controller.openEditRequestForm(requestId ?? 0);
                    },
                  ),
                ] else if (selectedTab == 2) ...[
                  EmployeeInformationCard(
                    l10n: l10n,
                    requestId: requestId?.toString(),
                    status: request?.status,
                    assignedTo: controller.buildAssignedToLabel(approvals),
                    user: createdByUser,
                    labelBuilder: l10n.requestDetailsLabel,

                    showStatusAndAssignedTo: selectedTab != 0,
                  ),
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
                  EmployeeInformationCard(
                    l10n: l10n,
                    requestId: requestId?.toString(),
                    status: request?.status,
                    assignedTo: controller.buildAssignedToLabel(approvals),
                    user: createdByUser,
                    labelBuilder: l10n.requestDetailsLabel,

                    showStatusAndAssignedTo: selectedTab != 0,
                  ),
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
