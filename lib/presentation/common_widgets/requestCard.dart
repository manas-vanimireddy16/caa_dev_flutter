// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/common_widgets/statusWidget.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class RequestCard extends StatelessWidget {
//   final String from;
//   final Map<String, dynamic> data;
//   final VoidCallback? onTap; // used as "View"
//   final VoidCallback? onSelfAssign; // NEW: used for "Self assign"

//   const RequestCard({
//     super.key,
//     this.from = '',
//     required this.data,
//     this.onTap,
//     this.onSelfAssign, // NEW
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

//     // 🧠 Different layout for logistics vs others
//     final isLogistics = from.toLowerCase() == 'logistics';
//     final isVPn = from.toLowerCase() == 'vpn';
//     final isSalalah = from.toLowerCase() == 'salalah';
//     final isSecurityAccess = from.toLowerCase() == 'requestaccesscard';
//     final isHotelReservation = from.toLowerCase() == 'hotelreservation';

//     // NEW: special flag for salalahActionItems
//     final isSalalahActionItem =
//         from.toLowerCase() == 'salalahactionitem' ||
//         from.toLowerCase() == 'salalahactionitems';
//     final isMuscatActionItem =
//         from.toLowerCase() == 'muscatactionitems' ||
//         from.toLowerCase() == 'muscatactionitems';
//     final isSecurityActionItem =
//         from.toLowerCase() == 'requestcccesscardactionitems' ||
//         from.toLowerCase() == 'requestcccesscardactionitems';
//     final isHotelReservationActionItem =
//         from.toLowerCase() == 'requestcccesscardactionitems' ||
//         from.toLowerCase() == 'requestcccesscardactionitems';

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
//               /// Top Row → ID & Status (+ 3 dots for salalahActionItems)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "Request ID: ${data["id"] ?? "-"}",
//                       style: TextStyle(
//                         fontWeight: currentTheme.fontWeights.wBolder,
//                         fontSize: currentTheme.fontSizes.s16,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       StatusChip(status: data["status"] ?? ""),
//                       if (isSalalahActionItem) ...[
//                         4.toHorizontalSizedBox,
//                         IconButton(
//                           icon: const Icon(Icons.more_vert),
//                           onPressed: () => _showSalalahActionItemMenu(),
//                         ),
//                       ],
//                       if (isMuscatActionItem) ...[
//                         4.toHorizontalSizedBox,
//                         IconButton(
//                           icon: const Icon(Icons.more_vert),
//                           onPressed: () => _showSalalahActionItemMenu(),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//               12.toVerticalSizedBox,

//               /// Middle Section (differs for logistics)
//               if (isLogistics) ...[
//                 _buildInfoRow("Service Type", data["Service Type"] ?? "-"),
//                 if ((data["Vehicle Location"] ?? '').toString().isNotEmpty) ...[
//                   6.toVerticalSizedBox,
//                   _buildInfoRow(
//                     "Vehicle Location",
//                     data["Vehicle Location"] ?? "-",
//                   ),
//                 ],
//                 6.toVerticalSizedBox,
//                 _buildInfoRow(
//                   "Purpose of Travel",
//                   data["Purpose of Travel"] ?? "-",
//                 ),
//                 6.toVerticalSizedBox,
//                 _buildInfoRow("Approver", data["Approver"]?.toString() ?? "-"),
//                 const Divider(height: 20, thickness: 1),
//                 Row(
//                   children: [
//                     _buildInfo("Date", _formatDate(data["Date"].toString())),
//                     25.toHorizontalSizedBox,
//                   ],
//                 ),
//               ] else if (isVPn) ...[
//                 _buildInfoRow("Request Type", data["Request Type"] ?? "-"),
//                 _buildInfoRow("Request For", data["Request For"] ?? "-"),
//                 6.toVerticalSizedBox,
//                 const Divider(height: 20, thickness: 1),
//                 Row(
//                   children: [
//                     _buildInfo(
//                       "Start Date",
//                       _formatDate(data["Start Date"].toString()),
//                     ),
//                     25.toHorizontalSizedBox,
//                     _buildInfo(
//                       "End Date",
//                       _formatDate(data["End Date"].toString()),
//                     ),
//                   ],
//                 ),
//               ] else if (isSalalah ||
//                   isSalalahActionItem ||
//                   isMuscatActionItem) ...[
//                 // 🔥 SAME UI FOR salalah AND salalahActionItems
//                 _buildInfoRow("Problem", data["problem"] ?? "-"),
//                 _buildInfoRow("Service Type", data["service_type"] ?? "-"),

//                 6.toVerticalSizedBox,
//                 const Divider(height: 20, thickness: 1),

//                 Row(
//                   children: [
//                     _buildInfo(
//                       "Start Date",
//                       _formatDate(data["created_at"].toString()),
//                     ),
//                     25.toHorizontalSizedBox,
//                     _buildInfo(
//                       "Assigned To",
//                       data["assigned_to"]?.toString() ?? "-",
//                     ),
//                   ],
//                 ),
//               ] else if (isHotelReservation ||
//                   isHotelReservationActionItem) ...[
//                 // 🔥 SAME UI FOR salalah AND salalahActionItems
//                 _buildInfoRow("User Name", data["User Name"] ?? "-"),
//                 _buildInfoRow("Hotel Name", data["Hotel Name"] ?? "-"),

//                 6.toVerticalSizedBox,
//                 const Divider(height: 20, thickness: 1),

//                 Row(
//                   children: [
//                     _buildInfo("Date", _formatDate(data["Date"].toString())),
//                     25.toHorizontalSizedBox,
//                     _buildInfo(
//                       "Check-In Date",
//                       data["Check-In Date"]?.toString() ?? "-",
//                     ),
//                   ],
//                 ),
//               ] else if (isSecurityActionItem || isSecurityAccess) ...[
//                 // 🔥 SAME UI FOR salalah AND salalahActionItems
//                 _buildInfoRow("User Name", data["User Name"] ?? "-"),
//                 _buildInfoRow("Approver", data["Approver"] ?? "-"),

//                 6.toVerticalSizedBox,
//                 const Divider(height: 20, thickness: 1),

//                 Row(
//                   children: [
//                     _buildInfo(
//                       "Start Date",
//                       _formatDate(data["created_at"].toString()),
//                     ),
//                     25.toHorizontalSizedBox,
//                     _buildInfo(
//                       "Assigned To",
//                       data["assigned_to"]?.toString() ?? "-",
//                     ),
//                   ],
//                 ),
//               ] else ...[
//                 Text(
//                   "Request Name: ${data["requestName"] ?? "-"}",
//                   style: TextStyle(
//                     fontWeight: currentTheme.fontWeights.wBolder,
//                     fontSize: currentTheme.fontSizes.s16,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 4.toVerticalSizedBox,
//                 Text(
//                   "Service Type: ${data["serviceType"] ?? "-"}",
//                   style: TextStyle(
//                     fontSize: currentTheme.fontSizes.s14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const Divider(height: 20, thickness: 1),
//                 Row(
//                   children: [
//                     _buildInfo("Created on", _formatDate(data["date"] ?? "")),
//                     25.toHorizontalSizedBox,
//                     _buildInfo("Assigned to", data["assignedTo"] ?? ""),
//                   ],
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // NEW: dialog for salalahActionItems
//   void _showSalalahActionItemMenu() {
//     final bool isAssigned = data["isAssigned"] == true;
//     print(isAssigned);
//     KAppX.extendedRouter.dialog.showKDialog(
//       builder: (ctx) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             /// 🔵 Self Assign → only when NOT assigned
//             if (!isAssigned)
//               ListTile(
//                 leading: const Icon(Icons.person_add),
//                 title: const Text('Self Assign'),
//                 onTap: () {
//                   Navigator.of(ctx).pop();
//                   if (onSelfAssign != null) {
//                     onSelfAssign!();
//                   }
//                 },
//               ),

//             /// 🔵 Always show View
//             ListTile(
//               leading: const Icon(Icons.visibility),
//               title: const Text('View'),
//               onTap: () {
//                 Navigator.of(ctx).pop();
//                 if (onTap != null) {
//                   onTap!();
//                 }
//               },
//             ),
//           ],
//         );
//       },
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
//           style: const TextStyle(color: Colors.black54, fontSize: 12),
//         ),
//         2.toVerticalSizedBox,
//         SizedBox(
//           width: 80,
//           child: Text(
//             value,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontWeight: currentTheme.fontWeights.wBold,
//               fontSize: currentTheme.fontSizes.s14,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     return RichText(
//       text: TextSpan(
//         text: "$label: ",
//         style: TextStyle(
//           fontWeight: currentTheme.fontWeights.wBold,
//           fontSize: currentTheme.fontSizes.s14,
//           color: Colors.black87,
//         ),
//         children: [
//           TextSpan(
//             text: value,
//             style: TextStyle(
//               fontWeight: currentTheme.fontWeights.wBold,
//               color: Colors.grey[700],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/statusWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  static const _titleColor = Color(0xFF676767);
  static const _dataColor = Color(0xFF434347);
  static const _backgroundColor = Color(0xFFFFFFFF);
  static const _borderColor = Color(0xFFD8D8D8);
  static const _cardRadius = 8.0;
  static const _cardPadding = 24.0;
  static const _cardGap = 16.0;

  final String from;
  final Map<String, dynamic> data;
  final bool isShowClosed;
  final VoidCallback? onTap;
  final VoidCallback? onSelfAssign;
  final String Function(String key)? fieldLabelBuilder;
  final String Function(String status)? statusLabelBuilder;
  final String Function(String id)? requestIdLabelBuilder;

  const RequestCard({
    super.key,
    this.from = '',
    required this.data,
    this.onTap,
    this.onSelfAssign,
    this.fieldLabelBuilder,
    this.statusLabelBuilder,
    this.requestIdLabelBuilder,
    this.isShowClosed = false,
  });

  String _resolveStatus(dynamic status) {
    if (status == null || status.toString().trim().isEmpty) {
      return 'Draft';
    }
    final value = status.toString();
    return value[0].toUpperCase() + value.substring(1);
  }

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  bool _isDateLike(dynamic value) {
    if (value == null) return false;
    final v = value.toString();
    return v.contains('-') || v.contains('/') || v.contains('T');
  }

  bool _isStatusKey(String key) => key.toLowerCase() == 'status';

  bool _hasStatusKey() => data.keys.any(_isStatusKey);

  String _humanizeKey(String key) {
    if (fieldLabelBuilder != null) return fieldLabelBuilder!(key);
    return key
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .split(' ')
        .map((e) => e.isEmpty ? e : e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  dynamic _statusRawValue() {
    for (final entry in data.entries) {
      if (_isStatusKey(entry.key)) return entry.value;
    }
    return null;
  }

  String _statusLabel() {
    final status = _resolveStatus(_statusRawValue());

    if (isShowClosed && status.toLowerCase() == 'approved') {
      return 'Closed';
    }

    return statusLabelBuilder?.call(status) ?? status;
  }

  List<MapEntry<String, dynamic>> _contentEntries() {
    return data.entries.where((e) => !_isStatusKey(e.key)).toList();
  }

  String _displayValue(MapEntry<String, dynamic> entry) {
    final raw = entry.value;
    if (raw == null || raw.toString().trim().isEmpty) {
      return '-';
    }
    final text = raw.toString();
    return _isDateLike(raw) ? _formatDate(text) : text;
  }

  Widget _buildFieldCell(String key, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _humanizeKey(key),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.toAutoScaledWidth,
            fontWeight: FontWeight.w500,
            color: _titleColor,
            height: 1.3,
          ),
        ),
        SizedBox(height: 4.toAutoScaledHeight),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.toAutoScaledWidth,
            fontWeight: FontWeight.w600,
            color: _dataColor,
            height: 1.35,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicGrid(List<MapEntry<String, dynamic>> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final rows = <Widget>[];

    for (var i = 0; i < entries.length; i += 2) {
      if (i > 0) {
        rows.add(SizedBox(height: _cardGap.toAutoScaledHeight));
      }

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildFieldCell(
                entries[i].key,
                _displayValue(entries[i]),
              ),
            ),
            SizedBox(width: _cardGap.toAutoScaledWidth),
            Expanded(
              child: i + 1 < entries.length
                  ? _buildFieldCell(
                      entries[i + 1].key,
                      _displayValue(entries[i + 1]),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_hasStatusKey())
          Flexible(
            child: StatusChip(
              status: _resolveStatus(_statusRawValue()),
              displayLabel: _statusLabel(),
            ),
          )
        else
          const SizedBox.shrink(),
        Icon(
          Icons.open_in_new,
          size: 20.toAutoScaledWidth,
          color: _dataColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = _contentEntries();

    return Padding(
      padding: EdgeInsets.only(bottom: 12.toAutoScaledHeight),
      child: Material(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius.toAutoScaledWidth),
          side: const BorderSide(color: _borderColor, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(_cardPadding.toAutoScaledWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDynamicGrid(entries),
                if (entries.isNotEmpty || _hasStatusKey())
                  SizedBox(height: _cardGap.toAutoScaledHeight),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
