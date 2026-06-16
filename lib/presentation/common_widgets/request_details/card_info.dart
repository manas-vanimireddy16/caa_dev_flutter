// import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/statusWidget.dart';
// import 'package:flutter/material.dart';

// class CardInfo extends StatelessWidget {
//   final String title;
//   final String? subtitle;
//   final Map<String, String> info;
//   final Widget? customContent;

//   const CardInfo({
//     super.key,
//     required this.title,
//     this.subtitle,
//     required this.info,
//     this.customContent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Split grid fields vs long-text fields
//     final gridEntries = info.entries.where(
//       (e) =>
//           e.key.toLowerCase() != "problem statement" &&
//           e.key.toLowerCase() != "description",
//     );

//     final problemStatement = info.entries.firstWhere(
//       (e) => e.key.toLowerCase() == "problem statement",
//       orElse: () => const MapEntry("", ""),
//     );
//     final description = info.entries.firstWhere(
//       (e) => e.key.toLowerCase() == "description",
//       orElse: () => const MapEntry("", ""),
//     );

//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       elevation: 0,
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title Row
//             Row(
//               children: [
//                 Icon(Icons.info_outline, color: Colors.indigo.shade900),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),
//             Divider(color: Colors.grey.shade300, thickness: 1),
//             const SizedBox(height: 16),

//             // Optional subtitle
//             if (subtitle != null) ...[
//               Text(
//                 subtitle!,
//                 style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
//               ),
//               const SizedBox(height: 16),
//             ],

//             // ✅ Grid for short info
//             // ✅ Replace your GridView.count with this
//             Column(
//               children: [
//                 for (int i = 0; i < gridEntries.length; i += 2)
//                   Row(
//                     children: [
//                       // Left column
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(6),
//                           child: InfoTile(
//                             title: gridEntries.elementAt(i).key,
//                             text:
//                                 gridEntries.elementAt(i).key.toLowerCase() ==
//                                     "status"
//                                 ? null
//                                 : gridEntries.elementAt(i).value,
//                             textWidget:
//                                 gridEntries.elementAt(i).key.toLowerCase() ==
//                                     "status"
//                                 ? StatusChip(
//                                     status: gridEntries.elementAt(i).value,
//                                   )
//                                 : null,
//                           ),
//                         ),
//                       ),

//                       // Right column (if exists)
//                       if (i + 1 < gridEntries.length)
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(6),
//                             child: InfoTile(
//                               title: gridEntries.elementAt(i + 1).key,
//                               text:
//                                   gridEntries
//                                           .elementAt(i + 1)
//                                           .key
//                                           .toLowerCase() ==
//                                       "status"
//                                   ? null
//                                   : gridEntries.elementAt(i + 1).value,
//                               textWidget:
//                                   gridEntries
//                                           .elementAt(i + 1)
//                                           .key
//                                           .toLowerCase() ==
//                                       "status"
//                                   ? StatusChip(
//                                       status: gridEntries
//                                           .elementAt(i + 1)
//                                           .value,
//                                     )
//                                   : null,
//                             ),
//                           ),
//                         )
//                       else
//                         const Expanded(
//                           child: SizedBox(),
//                         ), // keep alignment if odd count
//                     ],
//                   ),
//               ],
//             ),

//             const SizedBox(height: 16),

//             // ✅ Problem Statement (full width)
//             if (problemStatement.key.isNotEmpty) ...[
//               Text(
//                 problemStatement.key,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   problemStatement.value,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//             if (customContent != null) ...[
//               const SizedBox(height: 16),
//               customContent!,
//             ],

//             // ✅ Description (full width)
//             if (description.key.isNotEmpty) ...[
//               Text(
//                 description.key,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   description.value,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// class InfoTile extends StatelessWidget {
//   final String title;
//   final String? text;
//   final Widget? textWidget;

//   const InfoTile({super.key, required this.title, this.text, this.textWidget});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(_getIconForKey(title), color: Colors.indigo.shade900, size: 20),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//               ),
//               const SizedBox(height: 2),
//               textWidget ??
//                   Text(
//                     text ?? "",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   IconData _getIconForKey(String key) {
//     switch (key.toLowerCase()) {
//       case "status":
//         return Icons.verified;
//       case "requested date":
//         return Icons.calendar_today;
//       case "approver":
//         return Icons.person;
//       case "assigned to":
//         return Icons.work_outline;
//       default:
//         return Icons.info_outline;
//     }
//   }
// }
import 'package:code_setup/presentation/common_widgets/status_widget.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Map<String, String> info;
  final Widget? customContent;
  final String? headerIcon;

  final String Function(String key)? requestDetailsBuilder;
  final String Function(String status)? statusLabelBuilder;
  final bool isShowClosed;

  const CardInfo({
    super.key,
    required this.title,
    this.subtitle,
    required this.info,
    this.customContent,
    this.headerIcon,
    this.requestDetailsBuilder,
    this.statusLabelBuilder,
    this.isShowClosed = false,
  });

  String _label(String key) {
    return requestDetailsBuilder?.call(key) ?? key;
  }

  bool _isStatusKey(String key) {
    final normalized = key.toLowerCase();
    return normalized == 'status' || normalized == 'approval status';
  }

  MapEntry<String, String>? _statusEntry() {
    for (final entry in info.entries) {
      if (_isStatusKey(entry.key)) return entry;
    }
    return null;
  }

  String _resolveStatus(String status) {
    final value = status.trim();
    if (value.isEmpty) return 'Draft';
    return value[0].toUpperCase() + value.substring(1);
  }

  String _statusLabel(String status) {
    final resolved = _resolveStatus(status);

    if (isShowClosed && resolved.toLowerCase() == 'approved') {
      return 'Closed';
    }

    return statusLabelBuilder?.call(resolved) ?? resolved;
  }

  @override
  Widget build(BuildContext context) {
    final statusEntry = _statusEntry();

    // Split grid fields vs long-text fields
    final gridEntries = info.entries.where(
      (e) =>
          !_isStatusKey(e.key) &&
          e.key.toLowerCase() != "problem statement" &&
          e.key.toLowerCase() != "description",
    );

    final problemStatement = info.entries.firstWhere(
      (e) => e.key.toLowerCase() == "problem statement",
      orElse: () => const MapEntry("", ""),
    );

    final description = info.entries.firstWhere(
      (e) => e.key.toLowerCase() == "description",
      orElse: () => const MapEntry("", ""),
    );

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: const Color(0xFFD8D8D8)),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                KImageProvider(
                  image: headerIcon ?? _headerIcon(),
                  width: 22,
                  height: 22,
                  tintColor: Color(0xFF000000),
                ),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(color: AppColors.mainTitleColor)),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 16),

            // Optional subtitle
            if (subtitle != null) ...[
              Text(subtitle!, style: TextStyle(color: AppColors.contentColor)),
              const SizedBox(height: 16),
            ],

            /// ✅ GRID
            Column(
              children: [
                for (int i = 0; i < gridEntries.length; i += 2)
                  Row(
                    children: [
                      /// LEFT
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: InfoTile(
                            title: _label(gridEntries.elementAt(i).key),
                            text: gridEntries.elementAt(i).value,
                          ),
                        ),
                      ),

                      /// RIGHT
                      if (i + 1 < gridEntries.length)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: InfoTile(
                              title: _label(gridEntries.elementAt(i + 1).key),
                              text: gridEntries.elementAt(i + 1).value,
                            ),
                          ),
                        )
                      else
                        const Expanded(child: SizedBox()),
                    ],
                  ),
              ],
            ),

            if (statusEntry != null) ...[
              const SizedBox(height: 8),
              Text(
                _label(statusEntry.key),
                style: TextStyle(color: AppColors.headingColor),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: StatusChip(
                  status: _resolveStatus(statusEntry.value),
                  displayLabel: _statusLabel(statusEntry.value),
                ),
              ),
            ],

            const SizedBox(height: 16),

            /// ✅ Problem Statement
            if (problemStatement.key.isNotEmpty) ...[
              Text(
                _label(problemStatement.key),
                style: TextStyle(color: AppColors.headingColor),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  problemStatement.value,
                  style: TextStyle(color: AppColors.contentColor),
                ),
              ),
              const SizedBox(height: 16),
            ],

            /// ✅ CUSTOM CONTENT
            if (customContent != null) ...[
              const SizedBox(height: 16),
              customContent!,
            ],

            /// ✅ Description
            if (description.key.isNotEmpty) ...[
              Text(
                _label(description.key),
                style: TextStyle(color: AppColors.headingColor),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  description.value,
                  style: TextStyle(color: AppColors.contentColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _headerIcon() {
    final normalized = title.toLowerCase();
    if (normalized.contains('status')) {
      return AppIcons.statusInfoRequestDetails;
    }
    if (normalized.contains('technical')) {
      return AppIcons.technicalInfoRequestDetails;
    }
    return AppIcons.requestInfoRequestDetails;
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String? text;
  final Widget? textWidget;

  const InfoTile({super.key, required this.title, this.text, this.textWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: AppColors.headingColor)),
        const SizedBox(height: 2),
        textWidget ??
            Text(text ?? "", style: TextStyle(color: AppColors.contentColor)),
      ],
    );
  }
}
