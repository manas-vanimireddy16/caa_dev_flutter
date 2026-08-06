part of '../view.dart';

@RoutePage()
class RaiseLegalComplaintDetailsScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const RaiseLegalComplaintDetailsScreen({
    super.key,
    required this.id,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.from = '',
  });

  @override
  ConsumerState createState() => _RaiseLegalComplaintDetailsScreenState();
}

class _RaiseLegalComplaintDetailsScreenState
    extends ConsumerState<RaiseLegalComplaintDetailsScreen> {
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

          if (state.requestDetails == null || state.isLoading) {
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
                16.toVerticalSizedBox,
                RequestDetailsTabs(
                  selectedTab: selectedTab,
                  service: widget.service,
                  subService: widget.subService,
                ),
                5.toHorizontalSizedBox,

                /// ------------ TABS -----------------
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
                    statusInfo: controller.buildStatusInformation(),
                    requestInfo: controller.buildRequestInformationData(),
                    requestCustomContent: _LegalComplaintRequestSections(
                      l10n: l10n,
                      header: controller.buildLegalComplaintHeaderFields(),
                      complaintFields:
                          controller.buildComplaintDetailsFields(l10n),
                      complainantFields:
                          controller.buildComplainantDetailsFields(l10n),
                      complainedEmployeeFields: controller
                          .buildComplainedEmployeeDetailsFields(l10n),
                    ),
                    technicalInfo: controller.buildTechnicalInformation(),
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
                      await controller.sendChatMessage(
                        serviceId: widget.serviceId,
                        subServiceId: widget.subServiceId,
                      );
                    },
                    onAssign: () async {
                      controller.showAllocateUserDialog(context);
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

class _LegalComplaintRequestSections extends StatelessWidget {
  final DashboardL10n l10n;
  final ({String title, String description}) header;
  final List<({String label, String value})> complaintFields;
  final List<({String label, String value})> complainantFields;
  final List<({String label, String value})> complainedEmployeeFields;

  const _LegalComplaintRequestSections({
    required this.l10n,
    required this.header,
    required this.complaintFields,
    required this.complainantFields,
    required this.complainedEmployeeFields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LegalComplaintHeaderField(
          label: l10n.titleOfComplaint,
          value: header.title,
        ),
        const SizedBox(height: 14),
        _LegalComplaintHeaderField(
          label: l10n.descriptionLabel,
          value: header.description,
        ),
        const SizedBox(height: 18),
        _LegalComplaintInfoSubsection(
          title: l10n.legalComplaintStepComplaintIncident,
          fields: complaintFields,
        ),
        const SizedBox(height: 16),
        _LegalComplaintInfoSubsection(
          title: l10n.requestDetailsLabel('Complainant Details'),
          fields: complainantFields,
        ),
        const SizedBox(height: 16),
        _LegalComplaintInfoSubsection(
          title: l10n.legalComplaintComplainedEmployeeDetails,
          fields: complainedEmployeeFields,
        ),
      ],
    );
  }
}

class _LegalComplaintHeaderField extends StatelessWidget {
  final String label;
  final String value;

  const _LegalComplaintHeaderField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF777A80),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF25272C),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _LegalComplaintInfoSubsection extends StatelessWidget {
  final String title;
  final List<({String label, String value})> fields;

  const _LegalComplaintInfoSubsection({
    required this.title,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF24262B),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, thickness: 1, color: Color(0xFFE6E6E6)),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 12) / 2;
            return Wrap(
              spacing: 12,
              runSpacing: 14,
              children: [
                for (final field in fields)
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          field.label,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF777A80),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          field.value,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF25272C),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
