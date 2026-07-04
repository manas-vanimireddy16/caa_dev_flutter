part of '../view.dart';

@RoutePage()
class RequestforCoverageDetailsScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const RequestforCoverageDetailsScreen({
    super.key,
    required this.id,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.from = '',
  });

  @override
  ConsumerState createState() => _RequestforCoverageDetailsScreenState();
}

class _RequestforCoverageDetailsScreenState
    extends ConsumerState<RequestforCoverageDetailsScreen> {
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
          final requestId =
              state.requestDetails.request?.id ?? state.requestDetails.id;
          final approverId = active?.id;
          final isFromActionItems = widget.from.toLowerCase() == 'action items';
          final coverageDetails = controller.buildCoverageDetailsCardData(l10n);

          Widget coverageSection() => CoverageDetailsCard(
            l10n: l10n,
            eventName: coverageDetails.eventName,
            status: coverageDetails.status,
            suggestedPhotography: coverageDetails.suggestedPhotography,
            eventDetails: coverageDetails.eventDetails,
            postedOn: coverageDetails.postedOn,
            department: coverageDetails.department,
            phone: coverageDetails.phone,
            email: coverageDetails.email,
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
                  coverageSection(),
                  CommonRequestDetails(
                    statusInformationTitle: l10n.coverageInformationSection,
                    requestInformationTitle: l10n.requestDetailsLabel(
                      'Request Information',
                    ),
                    requestDetailsLabelBuilder: l10n.requestDetailsLabel,
                    statusInfo: controller.buildCoverageInformation(l10n),
                    requestInfo: controller.buildRequestInformationData(l10n),
                  ),
                ] else if (selectedTab == 1) ...[
                  coverageSection(),
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
                  coverageSection(),
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
                  coverageSection(),
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
