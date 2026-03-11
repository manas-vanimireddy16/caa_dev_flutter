part of '../view.dart';

@RoutePage()
class LogisticsForeignRequestDetailsTabScreen extends ConsumerWidget {
  final int id;
  final String from;

  const LogisticsForeignRequestDetailsTabScreen({
    super.key,
    this.from = '',
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateController = ref.read(_vsProvider.notifier);
    final state = ref.watch(_vsProvider);
    final selectedTab = ref.watch(requestDeatilsTabSelectedProvider);

    // ✅ Call only once when the screen first opens (prevents re-fetching)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!state.isLoading && state.requestForeignDataById.data == null) {
        await stateController.fetchRequestsById(id);
      }
    });

    final LogisticsForeignDetailModel details = state.requestForeignDataById;
    final ForeignRequestData? result = details.data;
    final List<WorkflowDetail> workflows = result?.workflowDetails ?? [];
    final List<Attachment>? attachments = result?.attachments ?? [];
    final List<ChatMessages>? chats = result?.chatMessages;
    final List<ForeignApprovalDetail>? approvals = result?.approvalDetails;

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Request Detail')),

      // ✅ Show loading spinner while fetching data
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  /// Profile Card
                  ProfileCard(
                    title: "Profile",
                    subtitle: "User Info",
                    name: result?.request?.createdByUser?.employeeName ?? '',
                    avatarUrl: "https://i.pravatar.cc/150?img=3",
                    isOnline: true,
                    info: {
                      "Request ID": (result?.request?.id ?? 0).toString(),
                      "Employee ID":
                          result?.request?.createdByUser?.employeeId ?? 'N/A',
                      "Job Title/Designation":
                          result?.request?.createdByUser?.directorate ?? 'N/A',
                      "email": result?.request?.createdByUser?.email ?? 'N/A',
                      "Department":
                          result?.request?.createdByUser?.category ?? 'N/A',
                      "Contact Number":
                          result?.request?.createdByUser?.mobile ?? 'N/A',
                    },
                  ),

                  5.toHorizontalSizedBox,

                  RequestTabs(selectedTab: selectedTab),

                  5.toHorizontalSizedBox,
                  const Divider(thickness: 1),

                  /// Tab Content
                  if (selectedTab == 0)
                    RequestDetailsTabContent(request: result, from: from)
                  else if (selectedTab == 1)
                    RequestHistoryTabContent(
                      comments: chats ?? [],
                      id: id,
                      approvals: approvals ?? [],
                    )
                  else if (selectedTab == 2)
                    AttachmentsTabContent(attachments: attachments ?? [])
                  else if (selectedTab == 3)
                    WorkflowTabContent(workflows: workflows),
                ],
              ),
            ),
    );
  }
}
