part of '../view.dart';

@RoutePage()
class SalalahRequestDetailsTabScreen extends ConsumerStatefulWidget {
  final int id;
  final Service service;
  final SubService subService;
  const SalalahRequestDetailsTabScreen({
    super.key,
    required this.id,
    required this.service,
    required this.subService,
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

          final request = state.requestDetails?.request;
          final requestId = request?.id;
          final workflows = state.requestDetails?.workflowDetails ?? [];
          final attachments = state.requestDetails?.attachments ?? [];
          final chats = state.requestDetails?.chatMessages ?? [];
          final selectedTab = state.requestDetailTab;
          final approverId = state?.requestDetails?.approvalDetails?[0].id;

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
                    "Request Type": request?.requestFor ?? 'N/A',
                  },
                ),

                5.toHorizontalSizedBox,
                RequestTabs(
                  selectedTab: selectedTab,
                  service: widget.service,
                  subService: widget.subService,
                ),
                5.toHorizontalSizedBox,
                const Divider(thickness: 1),

                /// ------------ TABS -----------------
                if (selectedTab == 0)
                  SalalahRequestDetailScreen(
                    // from: 'salalah',
                    data: state.requestDetails,
                  )
                else if (selectedTab == 1)
                  CommentsCard(
                    entries: chats,
                    controller: controller.chatController,
                    onSend: () async {},
                    attachments: [],
                    onApprove: () async {
                      controller.onClose(
                        approverId ?? 0,
                        requestId ?? 0,
                        "Approved",
                      );
                    },
                    actionType: ActionButtonsType.none,
                    onReject: () async {
                      controller.onClose(
                        approverId ?? 0,
                        requestId ?? 0,
                        "Rejected",
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
