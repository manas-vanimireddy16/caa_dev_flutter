// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/modules/router/app_router.gr.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';

// class NewRequestPopup {
//   static void show(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 6),
//                 _popupItem(
//                   title: "Request a Vehicle",
//                   background: const Color(0xFFF2F4E3),
//                   onTap: () {
//                     KAppX.router.push(LogisticsVehicleRequestRoute());
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const SizedBox(height: 8),
//                 _popupItem(
//                   title: "Transport Foreign Employees",
//                   background: const Color(0xFFE4F6F6),
//                   onTap: () {
//                     KAppX.router.push(LogisticsPassengersVehicleRequestRoute());
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static Widget _popupItem({
//     required String title,
//     required Color background,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: background,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//         child: Row(
//           children: [
//             const Icon(Icons.add, size: 22),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
