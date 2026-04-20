part of '../view.dart';

@RoutePage()
class AirportEntryRequestDetailsTabScreen extends ConsumerStatefulWidget {
  final String from;
  final int id;
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const AirportEntryRequestDetailsTabScreen({
    super.key,
    required this.id,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.from = '',
  });

  @override
  ConsumerState createState() => _AirportEntryRequestDetailsTabScreenState();
}

class _AirportEntryRequestDetailsTabScreenState
    extends ConsumerState<AirportEntryRequestDetailsTabScreen> {
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
                // from: 'salalah',
                // data: state.requestDetails,
                else if (selectedTab == 1)
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
                    onClose: () async {},
                    onApprove: () async {
                      controller.onAssignRejectClose(
                        approverId ?? 0,
                        requestId ?? 0,
                        'Approved',
                      );
                    },
                    onReject: () async {
                      controller.onAssignRejectClose(
                        approverId ?? 0,
                        requestId ?? 0,
                        'Rejected',
                      );
                    },
                    onAssign: () async {}, // You can connect later
                    onReassign: () async {
                      controller.showAssignEngineerDialog(
                        requestId: requestId ?? 0,
                        approverRoleId: approverId ?? 0,
                        // departmentId: userInfo?.departmentId,
                        // sectionId: userInfo?.sectionId,
                      );
                    },
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
