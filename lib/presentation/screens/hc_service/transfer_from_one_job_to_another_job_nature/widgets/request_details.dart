part of '../view.dart';

@RoutePage()
class TransferFromOneJobtoAnotherJobNatureDetailsScreen
    extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const TransferFromOneJobtoAnotherJobNatureDetailsScreen({
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
      _TransferFromOneJobtoAnotherJobNatureDetailsScreenState();
}

class _TransferFromOneJobtoAnotherJobNatureDetailsScreenState
    extends ConsumerState<TransferFromOneJobtoAnotherJobNatureDetailsScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
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
      appBar: KAppBar(
        title: KAppBar.requestDetailsTitle(l10n.requestDetailScreenTitle),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(_vsProvider(_providerArgs));
          final details = state.requestDetails;
          final request = details.request;
          final requestId = request?.id ?? details.id;
          final detailsLoaded = requestId != null && requestId != 0;

          if (state.isLoading && !detailsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final createdByUser = request?.createdByUser ?? details.createdByUser;
          final attachments = state.attachmentsById;
          final chats = state.chatById;
          final approvals = details.approvalDetails ?? [];
          final selectedTab = state.requestDetailTab;
          final active = controller.getActiveApprovalLevel(approvals);
          final actionType = controller.getActionButtonsType(
            details,
            approvals,
          );
          final nextApprover = controller.resolveApproverMap(approvals);
          final approverId = active?.id;

          Widget employeeSection() => EmployeeInformationCard(
            l10n: l10n,
            requestId: requestId?.toString(),
            status: request?.status ?? details.status,
            assignedTo: controller.buildAssignedToLabel(approvals),
            user: createdByUser,
            labelBuilder: l10n.requestDetailsLabel,

            showStatusAndAssignedTo: selectedTab != 0,
          );

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
                if (selectedTab == 0) ...[
                  employeeSection(),
                  CommonRequestDetails(
                    statusInformationTitle: l10n.requestDetailsLabel(
                      'Status Information',
                    ),
                    requestInformationTitle: l10n.requestDetailsLabel(
                      'Request Information',
                    ),
                    technicalInformationTitle: l10n.technicalDetailsSection,
                    requestDetailsLabelBuilder: l10n.requestDetailsLabel,
                    statusInfo: {
                      "Approval Status":
                          request?.status ?? details.status ?? 'N/A',
                      "Requested Date":
                          formatDate(request?.createdAt ?? details.createdAt) ??
                          'N/A',
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
                      "Service Type":
                          request?.service?.name ??
                          details.service?.name ??
                          'N/A',
                      "Sub Service Type":
                          request?.subService?.subServiceName ??
                          details.subService?.subServiceName ??
                          'N/A',
                      "Employee Id":
                          request?.employeeId ?? details.employeeId ?? 'N/A',
                      "Current Job Position":
                          request?.currentJobPosition ??
                          details.currentJobPosition ??
                          'N/A',
                      "Position To be Transferred":
                          request?.positionToBeTransferred ??
                          details.positionToBeTransferred ??
                          'N/A',
                      "Effective From Date":
                          request?.effectiveFromDate ??
                          details.effectiveFromDate ??
                          'N/A',
                      "Civil Id Card Number":
                          request?.civilIdCardNumber ??
                          details.civilIdCardNumber ??
                          'N/A',
                      "Description":
                          request?.description ?? details.description ?? 'N/A',
                    },
                    technicalInfo: {
                      'Extension Number':
                          createdByUser?.extensionNumber?.toString() ?? '0',
                    },
                  ),
                ] else if (selectedTab == 1) ...[
                  employeeSection(),
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
                    onRemove: controller.removeAttachment,
                    onSend: () async {
                      await controller.sendChatMessage(
                        serviceId: widget.serviceId,
                        subServiceId: widget.subServiceId,
                      );
                    },
                    onAssign: () async {
                      controller.showAssignEngineerDialog(
                        approverId: approverId ?? 0,
                        context: context,
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

                    onDelete: (attachment) async {
                      await controller.deleteAttachment(
                        attachment.id ?? 0,
                        requestId: attachment.requestId ?? requestId,
                      );
                    },
                  ),
                ] else if (selectedTab == 3) ...[
                  employeeSection(),
                  RequestWorkflowTimeline(details: details, l10n: l10n),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
