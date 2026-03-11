// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/common_widgets/statusWidget.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class RequestCard extends StatelessWidget {
//   final String from;
//   final Map<String, dynamic> data;
//   final VoidCallback? onTap;

//   const RequestCard({
//     super.key,
//     required this.from,
//     required this.data,
//     this.onTap,
//   });

//   String _formatDate(String date) {
//     try {
//       final parsed = DateTime.parse(date);
//       return DateFormat("dd/MM/yyyy").format(parsed);
//     } catch (_) {
//       return date;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         color: Colors.white,
//         margin: const EdgeInsets.only(bottom: 12),
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         shadowColor: Colors.grey.withOpacity(0.2),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Top Row → Request ID & Status
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Request ID: ${data["requestId"] ?? "-"}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: currentTheme.fontSizes.s16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   StatusChip(status: data["status"] ?? ""),
//                 ],
//               ),
//               12.toVerticalSizedBox,

//               /// Middle Row → Request Name & Service Type
//               Text(
//                 "Request Name: ${data["requestName"] ?? "-"}",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: currentTheme.fontSizes.s16,
//                   color: Colors.black87,
//                 ),
//               ),
//               4.toVerticalSizedBox,
//               Text(
//                 "Service Type: ${data["serviceType"] ?? "-"}",
//                 style: TextStyle(
//                   fontSize: currentTheme.fontSizes.s14,
//                   color: Colors.grey,
//                 ),
//               ),
//               const Divider(height: 20, thickness: 1),

//               /// Info Row → Created on, Assigned to, Request ID
//               Row(
//                 children: [
//                   _buildInfo("Created on", _formatDate(data["date"] ?? "")),
//                   25.toHorizontalSizedBox,
//                   _buildInfo("Assigned to", data["assignedTo"] ?? ""),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfo(String label, String value) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.black54,
//             fontSize: currentTheme.fontSizes.s12,
//           ),
//         ),
//         2.toVerticalSizedBox,
//         SizedBox(
//           width: 80.toAutoScaledWidth, // fixed width for alignment
//           child: Text(
//             value,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: currentTheme.fontSizes.s14,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
