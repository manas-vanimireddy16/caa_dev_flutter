// part of '../view.dart';

// class RemarksSend extends ConsumerWidget {
//   final String? title;
//   final String? subtitle;
//   final List<ApprovalDetails> approvals;
//   final int id;

//   const RemarksSend({
//     super.key,
//     this.title,
//     this.subtitle,
//     required this.id,
//     required this.approvals,
//   });

//   bool _shouldShowApprovalButtons(
//     dynamic rolesData,
//     List<ApprovalDetails> approvals,
//   ) {
//     if (rolesData == null) return false;

//     final userId = rolesData['data']?['user_id'];
//     final roleDetails = rolesData['data']?['role_details'] ?? [];

//     for (final approval in approvals) {
//       for (final role in roleDetails) {
//         final roleId = role['role']?['id'];
//         final deptId = role['department']?['id'];
//         final sectionId = role['section']?['id'];

//         if (approval.approverUserId == userId &&
//             approval.approverRoleId == roleId &&
//             approval.departmentId == deptId &&
//             approval.sectionId == sectionId) {
//           return true; // ✅ All 4 fields matched
//         }
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     final state = ref.watch(_vsProvider);
//     final controller = ref.read(_vsProvider.notifier);
//     final rolesData = KAppX.globalProvider.read(rolesProvider);

//     final isChatNotEmpty = controller.checkInController.text.trim().isNotEmpty;
//     final hasAttachment = (state.attachments?.isNotEmpty ?? false);

//     // ✅ Enable Send if either text or attachment exists
//     final isSendEnabled = isChatNotEmpty || hasAttachment;

//     // ✅ Disable attachment if chat typed OR attachment exists
//     final isAttachmentEnabled = !isChatNotEmpty && !hasAttachment;

//     // ✅ Disable chat if attachment picked
//     final isChatEnabled = !hasAttachment;

//     final showButtons = _shouldShowApprovalButtons(rolesData, approvals);

//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(6),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (title != null)
//               Text(
//                 title ?? 'NA',
//                 style: TextStyle(
//                   fontSize: currentTheme.fontSizes.s14,
//                   fontWeight: currentTheme.fontWeights.wBold,
//                 ),
//               ),
//             if (subtitle != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
//                 child: Text(
//                   subtitle ?? 'NA',
//                   style: TextStyle(
//                     fontSize: currentTheme.fontSizes.s13,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),

//             // 💬 Chat + 📎 Attachment + 🚀 Send
//             Row(
//               children: [
//                 // 📎 Attachment Button
//                 IconButton(
//                   onPressed: isAttachmentEnabled
//                       ? () async {
//                           await controller.pickFile(); // pick single file
//                         }
//                       : null,
//                   icon: const Icon(Icons.attach_file),
//                   color: isAttachmentEnabled
//                       ? Colors.blueGrey
//                       : Colors.grey.shade400,
//                 ),

//                 // 💬 Comment TextField
//                 Expanded(
//                   child: TextField(
//                     // controller: controller.chatController,
//                     enabled: isChatEnabled,
//                     decoration: InputDecoration(
//                       hintText: "Add your comments",
//                       filled: true,
//                       fillColor: isChatEnabled
//                           ? Colors.white
//                           : Colors.grey.shade200,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 8,
//                         horizontal: 12,
//                       ),
//                     ),
//                     onChanged: (_) => controller.refreshUI(),
//                   ),
//                 ),

//                 const SizedBox(width: 8),

//                 // 🚀 Send Button
//                 ElevatedButton.icon(
//                   onPressed: isSendEnabled
//                       ? () {
//                           // controller.sendChat(
//                           //   id,
//                           //   controller.chatController.text.trim(),
//                           //   isChatNotEmpty
//                           //       ? 'text'
//                           //       : state.attachments.first["file_type"],
//                           // );
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: isSendEnabled
//                         ? Colors.blue
//                         : Colors.grey.shade400,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 10,
//                     ),
//                   ),
//                   icon: const Icon(Icons.send, color: Colors.white),
//                   label: const Text(
//                     "Send",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),

//             // 📂 Attachment Preview (Single File)
//             if (hasAttachment)
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.insert_drive_file, size: 18),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           state.attachments.first["file_name"] ?? "Attachment",
//                           style: const TextStyle(fontSize: 13),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           controller.removeFile(state.attachments!.first);
//                         },
//                         icon: const Icon(Icons.close, color: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             const SizedBox(height: 12),

//             // ✅ Approve / Reject buttons (conditional)
//             if (showButtons)
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         // controller.handleApproval(id, true);
//                       },
//                       icon: const Icon(Icons.check_circle, color: Colors.white),
//                       label: const Text("Approve"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         // controller.handleApproval(id, false);
//                       },
//                       icon: const Icon(Icons.cancel, color: Colors.white),
//                       label: const Text("Reject"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
