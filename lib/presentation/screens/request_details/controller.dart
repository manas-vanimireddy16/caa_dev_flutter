part of 'view.dart';

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);
final remarksCommentProvider = StateProvider<String>((ref) => "");

class CommentItem {
  final String userName;
  final String initials;
  final String message;
  final String status;
  final DateTime dateTime;

  CommentItem({
    required this.userName,
    required this.initials,
    required this.message,
    required this.status,
    required this.dateTime,
  });
}

final List<CommentItemRD> comments1 = [
  CommentItemRD(
    userName: "Alice Johnson",
    initials: "AJ",
    message: "I’ve reviewed the request. Looks good to me.",
    status: "Approved",
    dateTime: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  CommentItemRD(
    userName: "Bob Smith",
    initials: "BS",
    message: "Please add more details about the project timeline.",
    status: "Pending",
    dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  ),
  CommentItemRD(
    userName: "Catherine Lee",
    initials: "CL",
    message: "I’ve attached the required documents for further processing.",
    status: "Submitted",
    dateTime: DateTime.now().subtract(const Duration(days: 2)),
  ),
  CommentItemRD(
    userName: "David Kim",
    initials: "DK",
    message: "This request has been rejected due to budget constraints.",
    status: "Rejected",
    dateTime: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
  ),
];

List<TaskRD> tasksData1 = [
  TaskRD(
    taskName: "Request Submitted",
    status: "completed",
    approvedBy: "Husam-Uddin",
    date: "02 Sep, 2025",
  ),
  TaskRD(
    taskName: "Request Approved By HOS",
    status: "completed",
    approvedBy: "Al-Rehman",
    date: "03 Sep, 2025",
  ),
  TaskRD(
    taskName: "Request Pending from You",
    status: "pending",
    approvedBy: "NA",
  ),
  TaskRD(
    taskName: "Email / Notification Sent",
    status: "not_started",
    approvedBy: "",
  ),
];

final List<AttachmentsmodelRD> attachments1 = [
  AttachmentsmodelRD(
    documentName: "Error Request Image1",
    fileType: "Error.png",
    uploadedDate: "12 Sep 2025",
    downloadUrl: "https://example.com/project_plan.pdf",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Stamp Approval",
    fileType: "Stamp.pdf",
    uploadedDate: "14 Sep 2025",
    downloadUrl: "https://example.com/ui_mockups.png",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Error Request Pdf",
    fileType: "Error request.pdf",
    uploadedDate: "15 Sep 2025",
    downloadUrl: "https://example.com/meeting_notes.docx",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Manager Approval",
    fileType: "apprvoal.pdf",
    uploadedDate: "16 Sep 2025",
    downloadUrl: "https://example.com/final_report.pdf",
    action: "Edit/Delete",
  ),
];
// =============================================

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();

      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String selectedRole;

  _ViewState({required this.isLoading, required this.selectedRole});

  _ViewState.init() : this(isLoading: false, selectedRole: '');

  _ViewState copyWith({bool? isLoading, String? selectedRole}) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  late TextEditingController chatController;

  _VSController() : super(_ViewState.init());

  final dashboardinstance = RequestDetailRepository();

  void initState() {
    chatController = TextEditingController();
  }

  void onSelectedRole(String role) =>
      state = state.copyWith(selectedRole: role);

  /// sendChat
  ///
  Future<String> sendChat(int id, String message) async {
    try {
      state = state.copyWith(isLoading: true);

      // 2️⃣ Build payload
      final payload = {
        "request_id": id,
        "message": message,
        "is_internal": true,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      final resMessage = await dashboardinstance.sendChat(payload, id);
      return resMessage;
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
      return 'Not sent';
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
