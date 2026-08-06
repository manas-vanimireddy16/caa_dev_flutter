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
      appBar: KAppBar(
        title: KAppBar.requestDetailsTitle(l10n.requestDetailScreenTitle),
      ),

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
                      'Follow Up Report Request Information',
                    ),
                    technicalInformationTitle: l10n.technicalDetailsSection,
                    requestDetailsLabelBuilder: l10n.requestDetailsLabel,
                    statusInfo: controller.buildStatusInformation(),

                    requestInfo: controller.buildRequestInformationData(),
                    requestCustomContent: _FollowUpReportItemsList(
                      items: controller.buildFollowUpReportItems(),
                      l10n: l10n,
                    ),
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
                    showButtons: actionType != ActionButtonsType.none,
                    actionType: actionType, // ✅ FIX HERE
                    entries: chats,
                    controller: controller.chatController,
                    buttonsDisabled: actionType == ActionButtonsType.update
                        ? false
                        : state.isButtonDisabled,
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

class _FollowUpReportItemsList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final DashboardL10n l10n;

  const _FollowUpReportItemsList({required this.items, required this.l10n});

  String _value(Map<String, dynamic> item, String key, {String? fallbackKey}) {
    final value = item[key] ?? (fallbackKey == null ? null : item[fallbackKey]);
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? 'N/A' : text;
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < items.length; index++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE1E3E8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l10n.requestDetailsLabel('Follow Up Report')} ${index + 1}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF24262B),
                  ),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - 12) / 2;
                    final item = items[index];
                    return Wrap(
                      spacing: 12,
                      runSpacing: 14,
                      children: [
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel(
                            'Reference Number / Letter Date (Sent By)',
                          ),
                          value: _value(
                            item,
                            'reference_type',
                            fallbackKey: 'sent_by',
                          ),
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel('Letter Date'),
                          value: _value(item, 'letter_date'),
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel('Subject'),
                          value: _value(item, 'subject'),
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel(
                            'Subject Classification',
                          ),
                          value: _value(item, 'subject_classification'),
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel(
                            "General Manager's Comment",
                          ),
                          value: _value(item, 'general_manager_comment'),
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel(
                            'Response Date (Target Date)',
                          ),
                          value: _value(item, 'response_date_target'),
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel('Action Status'),
                          value: _value(item, 'action_status'),
                          isStatus: true,
                        ),
                        _FollowUpInfoField(
                          width: itemWidth,
                          label: l10n.requestDetailsLabel('Delay Period'),
                          value: _value(item, 'delay_period'),
                        ),
                        _FollowUpInfoField(
                          width: constraints.maxWidth,
                          label: l10n.requestDetailsLabel('Action Taken'),
                          value: _value(item, 'action_taken'),
                        ),
                        _FollowUpInfoField(
                          width: constraints.maxWidth,
                          label: l10n.requestDetailsLabel('Attachment'),
                          value: _attachmentName(item['attachment']),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          if (index < items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  String _attachmentName(dynamic attachment) {
    if (attachment is Map) {
      final name = attachment['file_name'] ?? attachment['originalName'];
      if (name != null && name.toString().trim().isNotEmpty) {
        return name.toString();
      }
    }
    return 'N/A';
  }
}

class _FollowUpInfoField extends StatelessWidget {
  final double width;
  final String label;
  final String value;
  final bool isStatus;

  const _FollowUpInfoField({
    required this.width,
    required this.label,
    required this.value,
    this.isStatus = false,
  });

  ({Color background, Color foreground}) _statusColors(String status) {
    switch (status.toLowerCase().trim()) {
      case 'no response':
        return (
          background: const Color(0xFFE3F2FD),
          foreground: const Color(0xFF1565C0),
        );
      case 'completed':
        return (
          background: const Color(0xFFE8F5E9),
          foreground: const Color(0xFF558B2F),
        );
      case 'in progress':
        return (
          background: const Color(0xFFFFF9C4),
          foreground: const Color(0xFFF9A825),
        );
      case 'overdue':
        return (
          background: const Color(0xFFF5F5F5),
          foreground: const Color(0xFF616161),
        );
      default:
        return (
          background: const Color(0xFFF5F5F5),
          foreground: const Color(0xFF616161),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColors = _statusColors(value);

    return SizedBox(
      width: width,
      child: Column(
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
          const SizedBox(height: 5),
          if (isStatus)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusColors.background,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: statusColors.foreground,
                ),
              ),
            )
          else
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF25272C),
                height: 1.3,
              ),
            ),
        ],
      ),
    );
  }
}
