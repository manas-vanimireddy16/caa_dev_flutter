part of '../view.dart';

@RoutePage()
class RequestforDutyMissionUnplannedDetailsScreen
    extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const RequestforDutyMissionUnplannedDetailsScreen({
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
      _RequestforDutyMissionUnplannedDetailsScreenState();
}

class _RequestforDutyMissionUnplannedDetailsScreenState
    extends ConsumerState<RequestforDutyMissionUnplannedDetailsScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
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
          final attachments = state.requestDetails.attachments ?? [];
          final chats = state.chatById;
          final approvals = state.requestDetails.approvalDetails ?? [];
          final selectedTab = state.requestDetailTab;
          final active = controller.getActiveApprovalLevel(
            state.requestDetails.approvalDetails ?? [],
          );
          final actionType = controller.getActionButtonsType(
            state.requestDetails,
            approvals,
          );
          final nextApprover = controller.getNextApprovalDetails(approvals);
          final approverId = active?.id;
          final allowanceEmployees = state.allowanceEmployees;
          final isFromActionItems = widget.from.toLowerCase() == 'action items';

          Widget employeeSection() => EmployeeInformationCard(
            l10n: l10n,
            requestId: requestId?.toString(),
            status: request?.status,
            assignedTo: controller.buildAssignedToLabel(approvals),
            user: createdByUser,
            labelBuilder: l10n.requestDetailsLabel,
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
                if (selectedTab == 0) ...[
                  employeeSection(),
                  CommonRequestDetails(
                    allowanceEmployees: allowanceEmployees,
                    showAllowanceSection: true,
                    statusInformationTitle: l10n.requestDetailsLabel(
                      'Status Information',
                    ),
                    requestInformationTitle: l10n.requestDetailsLabel(
                      'Request Information',
                    ),
                    technicalInformationTitle: l10n.technicalDetailsSection,
                    requestDetailsLabelBuilder: l10n.requestDetailsLabel,
                    statusInfo: {
                      "Request Date": request?.createdAt.toString() ?? 'N/A',
                      "Status": request?.status ?? "N/A",
                      "Approver": nextApprover?.approverUser?.email ?? 'N/A',
                      "Assigned To":
                          nextApprover?.approverUser?.employeeName ?? 'N/A',
                    },
                    requestInfo: {
                      'Priority': request?.priority ?? 'N/A',
                      'Task Title': request?.taskTitle ?? 'N/A',
                      'Task Description': request?.taskDescription ?? 'N/A',
                      'Completion Date': request?.completionDate ?? 'N/A',
                      'Assigned Employee':
                          request?.assignedEmployeeName ?? 'N/A',
                    },
                    technicalInfo: {
                      'Extension Number':
                          request?.createdByUser?.extensionNumber.toString() ??
                          'N/A',
                    },
                  ),
                ] else if (selectedTab == 1) ...[
                  employeeSection(),
                  CommentsCard(
                    from: widget.from,
                    showButtons:
                        isFromActionItems &&
                        actionType != ActionButtonsType.none,
                    actionType: actionType,
                    entries: chats,
                    controller: controller.chatController,
                    buttonsDisabled: state.isButtonDisabled,
                    attachments: state.attachments,
                    l10n: l10n,
                    onAttach: () async {
                      await controller.pickFile();
                    },
                    onRemove: controller.removeAttachment,
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
                  ),
                ] else if (selectedTab == 2) ...[
                  employeeSection(),
                  CommonAttachmentsTabContent(
                    attachments: attachments,
                    l10n: l10n,
                    useActionsMenu: true,
                    onDelete: (attachment) async {
                      await controller.deleteAttachment(
                        attachment.id ?? 0,
                        requestId: attachment.requestId ?? requestId,
                      );
                    },
                  ),
                ] else if (selectedTab == 3) ...[
                  employeeSection(),
                  RequestWorkflowTimeline(
                    details: state.requestDetails,
                    l10n: l10n,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
