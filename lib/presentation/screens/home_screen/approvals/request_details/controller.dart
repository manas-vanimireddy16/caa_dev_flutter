import 'package:code_setup/presentation/screens/home_screen/approvals/model/attachmentsModel.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/model/requestProgressModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

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

final List<CommentItem> comments = [
  CommentItem(
    userName: "Alice Johnson",
    initials: "AJ",
    message: "I’ve reviewed the request. Looks good to me.",
    status: "Approved",
    dateTime: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  CommentItem(
    userName: "Bob Smith",
    initials: "BS",
    message: "Please add more details about the project timeline.",
    status: "Pending",
    dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  ),
  CommentItem(
    userName: "Catherine Lee",
    initials: "CL",
    message: "I’ve attached the required documents for further processing.",
    status: "Submitted",
    dateTime: DateTime.now().subtract(const Duration(days: 2)),
  ),
  CommentItem(
    userName: "David Kim",
    initials: "DK",
    message: "This request has been rejected due to budget constraints.",
    status: "Rejected",
    dateTime: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
  ),
];

List<Task> tasksData = [
  Task(
    taskName: "Request Submitted",
    status: "completed",
    approvedBy: "Husam-Uddin",
    date: "02 Sep, 2025",
  ),
  Task(
    taskName: "Request Approved By HOS",
    status: "completed",
    approvedBy: "Al-Rehman",
    date: "03 Sep, 2025",
  ),
  Task(
    taskName: "Request Pending from You",
    status: "pending",
    approvedBy: "NA",
  ),
  Task(
    taskName: "Email / Notification Sent",
    status: "not_started",
    approvedBy: "",
  ),
];

final List<Attachmentsmodel> attachments = [
  Attachmentsmodel(
    documentName: "Error Request Image",
    fileType: "Error.png",
    uploadedDate: "12 Sep 2025",
    downloadUrl: "https://example.com/project_plan.pdf",
    action: "Edit/Delete",
  ),
  Attachmentsmodel(
    documentName: "Stamp Approval",
    fileType: "Stamp.pdf",
    uploadedDate: "14 Sep 2025",
    downloadUrl: "https://example.com/ui_mockups.png",
    action: "Edit/Delete",
  ),
  Attachmentsmodel(
    documentName: "Error Request Pdf",
    fileType: "Error request.pdf",
    uploadedDate: "15 Sep 2025",
    downloadUrl: "https://example.com/meeting_notes.docx",
    action: "Edit/Delete",
  ),
  Attachmentsmodel(
    documentName: "Manager Approval",
    fileType: "apprvoal.pdf",
    uploadedDate: "16 Sep 2025",
    downloadUrl: "https://example.com/final_report.pdf",
    action: "Edit/Delete",
  ),
];
