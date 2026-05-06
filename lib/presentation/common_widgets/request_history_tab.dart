// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request_by_id.dart';
// import 'package:code_setup/presentation/screens/it_services/vpn/view.dart';
// import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/statusInfo.dart';
// import 'package:code_setup/presentation/screens/logistics/foreign_request/view.dart';
// import 'package:code_setup/presentation/screens/logistics/logistics_employee/view.dart';
// import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
// import 'package:flutter/material.dart';

// class RequestHistoryTabContent<T> extends StatelessWidget {
//   final String from;
//   final List<dynamic> comments;
//   final List<dynamic> approvals;
//   final int id;

//   const RequestHistoryTabContent({
//     super.key,
//     this.from = '',
//     required this.comments,
//     required this.id,
//     required this.approvals,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // 🛑 Handle empty list first
//     // if (comments.isEmpty) {
//     //   return _buildHistoryContainer(
//     //     child: const Center(child: Text("No history available")),
//     //     remarks: _buildRemarksSection(),
//     //   );
//     // }
//     final fromPage = from;
//     // ✅ Detect type safely (after confirming not empty)
//     // final firstComment = comments.first;
//     if (fromPage == 'logistics') {
//       //|| firstComment is ChatMessage
//       return _buildLogisticsHistory();
//     } else if (fromPage == 'vpn approval details' || fromPage == 'vpn') {
//       // firstComment is VPNChatMessage

//       return _buildVpnHistory();
//     } else {
//       return const Center(child: Text("Unsupported request type"));
//     }
//   }

//   // 🟦 1. Logistics History UI
//   Widget _buildLogisticsHistory() {
//     final logisticsComments = comments.cast<ChatMessage>();
//     final logisticsApprovals = approvals.cast<ApprovalDetails>();

//     return _buildHistoryContainer(
//       child: ListView.builder(
//         itemCount: logisticsComments.length,
//         itemBuilder: (context, index) {
//           final comment = logisticsComments[index];
//           return StatusInfo(
//             userName: comment.user?.employeeName ?? 'NA',
//             initials: getInitials(comment.user?.employeeName ?? 'NA'),
//             message: comment.message ?? 'NA',
//             dateTime: comment.createdAt?.toString() ?? 'N/A',
//           );
//         },
//       ),
//       remarks: RemarksSend(
//         title: "Add Remarks",
//         subtitle: "You can add your comments or remarks below.",
//         // approvals: logisticsApprovals,
//         id: id,
//       ),
//     );
//   }

//   // 🟩 2. VPN History UI
//   Widget _buildVpnHistory() {
//     final vpnComments = comments.cast<VPNChatMessage>();
//     final vpnApprovals = approvals.cast<VPNApprovalDetail>();

//     return _buildHistoryContainer(
//       child: ListView.builder(
//         itemCount: vpnComments.length,
//         itemBuilder: (context, index) {
//           final comment = vpnComments[index];
//           return StatusInfo(
//             userName: comment.user?.employeeName ?? 'NA',
//             initials: getInitials(comment.user?.employeeName ?? 'NA'),
//             message: comment.message ?? 'NA',
//             dateTime: comment.createdAt?.toString() ?? 'N/A',
//           );
//         },
//       ),
//       remarks: VPNRemarksSend(
//         from: from,
//         title: "Add VPN Remarks",
//         subtitle: "Provide VPN-specific comments below.",
//         approvals: vpnApprovals,
//         id: id,
//       ),
//     );
//   }

//   // ♻️ Common container builder
//   Widget _buildHistoryContainer({
//     required Widget child,
//     required Widget remarks,
//   }) {
//     return Card(
//       color: Colors.white,
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             SizedBox(height: 400.toAutoScaledHeight, child: child),
//             remarks,
//           ],
//         ),
//       ),
//     );
//   }

//   // 🧩 Helper: placeholder remarks if empty
//   Widget _buildRemarksSection() {
//     // You can adjust depending on "from" value if needed
//     if (from == 'vpn approval status') {
//       final vpnApprovals = approvals.cast<VPNApprovalDetail>();
//       return VPNRemarksSend(
//         from: from,
//         title: "Add VPN Remarks",
//         subtitle: "Provide VPN-specific comments below.",
//         approvals: vpnApprovals,
//         id: id,
//       );
//     } else {
//       final logisticsApprovals = approvals.cast<ApprovalDetails>();
//       return RemarksSend(
//         title: "Add Remarks",
//         subtitle: "You can add your comments or remarks below.",
//         approvals: logisticsApprovals,
//         id: id,
//       );
//     }
//   }
// }

// // 🧩 Common helper for initials
// String getInitials(String? name) {
//   if (name == null || name.isEmpty) return "NA";
//   final parts = name.trim().split(" ");
//   if (parts.length == 1) {
//     return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
//   } else {
//     return (parts[0][0] + parts[1][0]).toUpperCase();
//   }
// }
