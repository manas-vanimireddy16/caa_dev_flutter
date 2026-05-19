part of '../view.dart';

@RoutePage()
class SalalahRequestDetailsTabScreen extends ConsumerStatefulWidget {
  final int id;
  final String from;
  final Service service;
  final SubService subService;

  final int serviceId;
  final int subServiceId;
  const SalalahRequestDetailsTabScreen({
    super.key,
    required this.id,
    this.from = '',
    required this.service,
    required this.subService,
    required this.serviceId,
    required this.subServiceId,
  });

  @override
  ConsumerState createState() => _SalalahRequestDetailsTabScreenState();
}

class _SalalahRequestDetailsTabScreenState
    extends ConsumerState<SalalahRequestDetailsTabScreen> {
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
                    showButtons: actionType != ActionButtonsType.none,
                    actionType: actionType, // ✅ FIX HERE
                    entries: chats,
                    controller: controller.chatController,
                    buttonsDisabled: state.isButtonDisabled,
                    attachments: state.attachments,
                    // l10n: l10n,
                    onAttach: () async {
                      await controller.pickFile();
                    },

                    onSend: () async {
                      await controller.sendChatMessage(
                        serviceId: widget.serviceId,
                        subServiceId: widget.subServiceId,
                      );
                    },
                    onAssign: () async {
                      controller.onAssign(approverId ?? 0, requestId ?? 0);
                    },

                    onClose: () async {
                      controller.showApprovalCommentDialog(
                        type: ApprovalDialogType.close,
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
                  )
                else if (selectedTab == 2)
                  CommonAttachmentsTabContent(attachments: attachments)
                else if (selectedTab == 3)
                  ITServicesRequestWorkflowTimeline(
                    details: state.requestDetails,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
