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
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

abstract final class _RequestDetailsIconSize {
  static const double statusSection = 14;
}

class CardInfo extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Map<String, String> info;
  final Widget? customContent;
  final String? headerIcon;

  final String Function(String key)? requestDetailsBuilder;
  final String Function(String status)? statusLabelBuilder;
  final bool isShowClosed;
  final bool hideEmptyValues;

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
    this.hideEmptyValues = false,
  });

  String _label(String key) {
    return requestDetailsBuilder?.call(key) ?? key;
  }

  bool _isStatusKey(String key) {
    final normalized = key.toLowerCase();
    return normalized == 'status' || normalized == 'approval status';
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

  bool _isEmptyValue(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return true;

    final lower = trimmed.toLowerCase();
    return lower == 'n/a' ||
        lower == 'na' ||
        lower == '-' ||
        lower == 'null';
  }

  bool _isApproverKey(String key) {
    final normalized = key.toLowerCase();
    return normalized == 'approver' ||
        normalized == 'approver name' ||
        normalized == 'approver email';
  }

  bool _isDescriptionKey(String key) {
    return key.toLowerCase() == 'description';
  }

  bool _isLongTextKey(String key) {
    final normalized = key.toLowerCase();
    return normalized == 'problem statement' ||
        normalized == 'description' ||
        normalized == 'request title';
  }

  bool _isStatusSection(String sectionTitle) {
    return sectionTitle.toLowerCase().contains('status');
  }

  String? _valueForKey(Map<String, String> data, List<String> keys) {
    for (final entry in data.entries) {
      final normalized = entry.key.toLowerCase();
      if (keys.any((key) => normalized == key.toLowerCase())) {
        return entry.value;
      }
    }
    return null;
  }

  BoxDecoration _borderedFieldDecoration() {
    return BoxDecoration(
      color: const Color(0xFFF6F6F9),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFD8D8D8)),
    );
  }

  Widget _buildBorderedTextBlock({
    required String label,
    required String value,
    required String emptyPlaceholder,
  }) {
    final displayValue = _isEmptyValue(value) ? emptyPlaceholder : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.requestDetailsFieldHeading()),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: _borderedFieldDecoration(),
          child: Text(
            displayValue,
            style: AppTextStyles.requestDetailsFieldContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSectionLayout({
    required Map<String, String> resolvedInfo,
    required MapEntry<String, String>? statusEntry,
    required ({String? name, String? email}) approverDetails,
    required bool showApproverCard,
  }) {
    final assignedTo = _valueForKey(resolvedInfo, ['assigned to']);
    final requestedDate = _valueForKey(resolvedInfo, ['requested date']);
    final department = _valueForKey(resolvedInfo, ['department']);
    final section = _valueForKey(resolvedInfo, ['section']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isEmptyValue(assignedTo)) ...[
          InfoTile(
            title: _label('Assigned To'),
            text: assignedTo,
          ),
          const SizedBox(height: 16),
        ],
        if (showApproverCard) ...[
          Text(
            _label('Approver'),
            style: AppTextStyles.requestDetailsFieldHeading(),
          ),
          const SizedBox(height: 8),
          _ApproverInfoCard(
            name: approverDetails.name ?? '',
            email: approverDetails.email ?? '',
            initials: _initialsFromName(approverDetails.name ?? ''),
            iconSize: _RequestDetailsIconSize.statusSection,
          ),
          const SizedBox(height: 16),
        ],
        if (statusEntry != null) ...[
          Text(
            _label(statusEntry.key),
            style: AppTextStyles.requestDetailsFieldHeading(),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusChip(
              status: _resolveStatus(statusEntry.value),
              displayLabel: _statusLabel(statusEntry.value),
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (!_isEmptyValue(requestedDate))
          InfoTile(
            title: _label('Requested Date'),
            text: requestedDate,
            leadingIcon: Icons.calendar_today_outlined,
            iconSize: _RequestDetailsIconSize.statusSection,
          ),
        if (!_isEmptyValue(department)) ...[
          const SizedBox(height: 16),
          InfoTile(
            title: _label('Department'),
            text: department,
          ),
        ],
        if (!_isEmptyValue(section)) ...[
          const SizedBox(height: 16),
          InfoTile(
            title: _label('Section'),
            text: section,
          ),
        ],
      ],
    );
  }

  String _initialsFromName(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  Map<String, String> _resolvedInfo() {
    if (!hideEmptyValues) return info;

    return Map.fromEntries(
      info.entries.where((entry) {
        if (_isDescriptionKey(entry.key)) return true;
        return !_isEmptyValue(entry.value);
      }),
    );
  }

  ({String? name, String? email}) _extractApproverDetails(
    Map<String, String> resolvedInfo,
  ) {
    String? name;
    String? email;

    for (final entry in resolvedInfo.entries) {
      final normalized = entry.key.toLowerCase();
      final value = entry.value.trim();

      if (_isEmptyValue(value)) continue;

      if (normalized == 'approver name') {
        name = value;
      } else if (normalized == 'approver email') {
        email = value;
      } else if (normalized == 'approver') {
        if (value.contains('@')) {
          email ??= value;
        } else {
          name ??= value;
        }
      }
    }

    return (name: name, email: email);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final resolvedInfo = _resolvedInfo();
    final statusEntry = resolvedInfo.entries
        .where((entry) => _isStatusKey(entry.key))
        .map((entry) => MapEntry(entry.key, entry.value))
        .firstOrNull;
    final approverDetails = _extractApproverDetails(resolvedInfo);
    final isStatusSection = _isStatusSection(title);
    final showApproverCard =
        isStatusSection &&
        (approverDetails.name?.isNotEmpty == true ||
            approverDetails.email?.isNotEmpty == true);

    // Split grid fields vs long-text fields
    final gridEntries = resolvedInfo.entries.where(
      (e) =>
          !_isStatusKey(e.key) &&
          !_isLongTextKey(e.key) &&
          !(isStatusSection && _isApproverKey(e.key)) &&
          !(isStatusSection &&
              [
                'assigned to',
                'requested date',
                'department',
                'section',
              ].contains(e.key.toLowerCase())),
    );

    final problemStatement = resolvedInfo.entries
        .where((e) => e.key.toLowerCase() == 'problem statement')
        .map((entry) => MapEntry(entry.key, entry.value))
        .firstOrNull;

    final requestTitle = resolvedInfo.entries
        .where((e) => e.key.toLowerCase() == 'request title')
        .map((entry) => MapEntry(entry.key, entry.value))
        .firstOrNull;

    final description = resolvedInfo.entries
        .where((e) => e.key.toLowerCase() == 'description')
        .map((entry) => MapEntry(entry.key, entry.value))
        .firstOrNull;

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
                  width: isStatusSection
                      ? _RequestDetailsIconSize.statusSection
                      : 22,
                  height: isStatusSection
                      ? _RequestDetailsIconSize.statusSection
                      : 22,
                  tintColor: Color(0xFF000000),
                ),
                const SizedBox(width: 8),
                Text(title, style: AppTextStyles.requestDetailsSectionHeading()),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 16),

            // Optional subtitle
            if (subtitle != null) ...[
              Text(subtitle!, style: AppTextStyles.requestDetailsFieldContent()),
              const SizedBox(height: 16),
            ],

            /// ✅ GRID / STATUS LAYOUT
            if (isStatusSection)
              _buildStatusSectionLayout(
                resolvedInfo: resolvedInfo,
                statusEntry: statusEntry,
                approverDetails: approverDetails,
                showApproverCard: showApproverCard,
              )
            else
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

            if (!isStatusSection && statusEntry != null) ...[
              const SizedBox(height: 8),
              Text(
                _label(statusEntry.key),
                style: AppTextStyles.requestDetailsFieldHeading(),
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

            if (!isStatusSection && showApproverCard) ...[
              const SizedBox(height: 16),
              Text(
                _label('Approver'),
                style: AppTextStyles.requestDetailsFieldHeading(),
              ),
              const SizedBox(height: 8),
              _ApproverInfoCard(
                name: approverDetails.name ?? '',
                email: approverDetails.email ?? '',
                initials: _initialsFromName(approverDetails.name ?? ''),
              ),
            ],

            if (!isStatusSection ||
                gridEntries.isNotEmpty ||
                requestTitle != null ||
                problemStatement != null ||
                description != null ||
                customContent != null)
              const SizedBox(height: 16),

            /// ✅ Request Title
            if (requestTitle != null) ...[
              _buildBorderedTextBlock(
                label: _label(requestTitle.key),
                value: requestTitle.value,
                emptyPlaceholder: l10n.noDescriptionProvided,
              ),
              const SizedBox(height: 16),
            ],

            /// ✅ Problem Statement
            if (problemStatement != null &&
                !_isEmptyValue(problemStatement.value)) ...[
              _buildBorderedTextBlock(
                label: _label(problemStatement.key),
                value: problemStatement.value,
                emptyPlaceholder: l10n.noDescriptionProvided,
              ),
              const SizedBox(height: 16),
            ],

            /// ✅ CUSTOM CONTENT
            if (customContent != null) ...[
              const SizedBox(height: 16),
              customContent!,
            ],

            /// ✅ Description
            if (description != null) ...[
              _buildBorderedTextBlock(
                label: _label(description.key),
                value: description.value,
                emptyPlaceholder: l10n.noDescriptionProvided,
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
  final IconData? leadingIcon;
  final String? leadingIconAsset;
  final double iconSize;

  const InfoTile({
    super.key,
    required this.title,
    this.text,
    this.textWidget,
    this.leadingIcon,
    this.leadingIconAsset,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.requestDetailsFieldHeading()),
        const SizedBox(height: 2),
        textWidget ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leadingIcon != null) ...[
                  Icon(
                    leadingIcon,
                    size: iconSize,
                    color: const Color(0xFF818184),
                  ),
                  const SizedBox(width: 6),
                ] else if (leadingIconAsset != null) ...[
                  KImageProvider(
                    image: leadingIconAsset,
                    width: iconSize,
                    height: iconSize,
                    tintColor: const Color(0xFF818184),
                  ),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    text ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.requestDetailsFieldContent(),
                  ),
                ),
              ],
            ),
      ],
    );
  }
}

class _ApproverInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String initials;
  final double iconSize;

  const _ApproverInfoCard({
    required this.name,
    required this.email,
    required this.initials,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD8D8D8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE8A0BF),
            child: Text(
              initials,
              style: AppTextStyles.cairo(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name.isNotEmpty) ...[
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.requestDetailsFieldContent().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                if (email.isNotEmpty) ...[
                  KImageProvider(
                    image: AppIcons.mailEmployeeCard,
                    width: iconSize,
                    height: iconSize,
                    tintColor: const Color(0xFF818184),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.requestDetailsFieldContent(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
