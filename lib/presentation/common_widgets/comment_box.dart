// // Model for each comment entry
// import 'package:code_setup/presentation/models/details_models.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';

// // class CommentEntryModel {
// //   final String userName;
// //   final String userInitials;
// //   final bool isSelf;
// //   final String message;
// //   final String? statusLabel;
// //   final CommentStatus? status;
// //   final String time;
// //   CommentEntryModel({
// //     required this.userName,
// //     required this.userInitials,
// //     required this.isSelf,
// //     required this.message,
// //     this.statusLabel,
// //     this.status,
// //     required this.time,
// //   });
// // }

// enum CommentStatus { pending, validating, approved }

// class StatusBadge extends StatelessWidget {
//   final CommentStatus status;
//   final String label;

//   const StatusBadge({super.key, required this.status, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     Color bg;
//     Color fg;
//     IconData icon;
//     switch (status) {
//       case CommentStatus.pending:
//         bg = const Color(0xFFFDF5DF);
//         fg = const Color(0xFFF4B31C);
//         icon = Icons.access_time;
//         break;
//       case CommentStatus.validating:
//         bg = const Color(0xFFE2EEFF);
//         fg = const Color(0xFF1A99F2);
//         icon = Icons.autorenew;
//         break;
//       case CommentStatus.approved:
//         bg = const Color(0xFFC9F1DF);
//         fg = const Color(0xFF31B480);
//         icon = Icons.check_circle_outline;
//         break;
//     }
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return Container(
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(7),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: fg, size: 17),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: fg,
//               fontWeight: FontWeight.w600,
//               fontSize: currentTheme.fontSizes.s14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Main comment bubble widget
// class CommentEntry extends StatelessWidget {
//   final ChatMessageModel data;
//   const CommentEntry({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     final headerStyle = data.isSelf
//         ? const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.red,
//             fontSize: 15,
//           )
//         : const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF59623F),
//             fontSize: 15,
//           );
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Avatar or Initials
//           CircleAvatar(
//             radius: 18,
//             backgroundColor: data.isSelf ? Colors.grey[400] : Colors.green[100],
//             child: Text(
//               data.userInitials,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(width: 14),
//           // Body
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(data.userName, style: headerStyle),
//                 const SizedBox(height: 2),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F8FB),
//                     borderRadius: BorderRadius.circular(9),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 11,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data.message,
//                         style: TextStyle(fontSize: currentTheme.fontSizes.s14),
//                       ),
//                       if (data.status != null && data.statusLabel != null) ...[
//                         const SizedBox(height: 7),
//                         StatusBadge(
//                           status: data.status!,
//                           label: data.statusLabel!,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 4, left: 2),
//                   child: Text(
//                     data.time,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFFADB5BD),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Reusable input section
// class AddCommentBox extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback? onAttach, onSend, approve, reject;

//   const AddCommentBox({
//     super.key,
//     required this.controller,
//     this.onAttach,
//     this.onSend,
//     this.approve,
//     this.reject,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return Card(
//       color: currentTheme.colors.onPrimary,
//       margin: const EdgeInsets.only(top: 24),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(11),
//         side: const BorderSide(color: Color(0xFFEAEAEF)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(13),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Comments / Notes",
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               "Remarks (Optional)",
//               style: TextStyle(
//                 color: Colors.blue[200],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Container(
//               height: 43,
//               margin: const EdgeInsets.symmetric(vertical: 9),
//               padding: const EdgeInsets.symmetric(horizontal: 7),
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xFFDFE6ED), width: 1),
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Add your comments",
//                         hintStyle: TextStyle(
//                           color: Color(0xFFC1CDD0),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.attach_file,
//                       color: Color(0xFF344B5A),
//                       size: 22,
//                     ),
//                     onPressed: onAttach,
//                     splashRadius: 22,
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.send,
//                       color: Color(0xFF344B5A),
//                       size: 23,
//                     ),
//                     onPressed: onSend,
//                     splashRadius: 22,
//                   ),
//                 ],
//               ),
//             ),
//             const Text(
//               "Note : This Option is Enabled based on the Access",
//               style: TextStyle(fontSize: 12, color: Color(0xFFA5A6B4)),
//             ),
//             const SizedBox(height: 13),
//             // Row for Approve & Reject actions
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     approve?.call();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF249E51),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     minimumSize: const Size(100, 36),
//                   ),
//                   icon: const Icon(
//                     Icons.check_circle_outline,
//                     color: Colors.white,
//                     size: 16,
//                   ),
//                   label: Text(
//                     "Approve",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: currentTheme.fontSizes.s15,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     reject?.call();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFD13A28),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     minimumSize: const Size(100, 36),
//                   ),
//                   icon: const Icon(
//                     Icons.cancel_outlined,
//                     color: Colors.white,
//                     size: 16,
//                   ),
//                   label: Text(
//                     "Reject",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: currentTheme.fontSizes.s15,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Main Overview Section
// class CommentsRoutingOverview extends StatelessWidget {
//   final List<ChatMessageModel> entries;
//   final TextEditingController controller = TextEditingController();

//   CommentsRoutingOverview({super.key, required this.entries});

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return Card(
//       color: currentTheme.colors.onPrimary,
//       // margin: const EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.history, color: Colors.black87, size: 18),
//                 SizedBox(width: 8),
//                 Text(
//                   "Comments / Routing Overview",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: currentTheme.fontSizes.s16,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Divider(),
//             // Comments List
//             ...entries.map((entry) => CommentEntry(data: entry)),
//             AddCommentBox(
//               controller: controller,
//               onAttach: () {
//                 /* Attach callback */
//               },
//               onSend: () {
//                 /* Send callback */
//               },
//               approve: () {},
//               reject: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
