import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:flutter/material.dart';

class StatSummaryHelper {
  static const List<String> ignoredKeys = ['pendingActionItems'];

  static List<StatSummaryData> buildStatList(
    Map<String, dynamic>? map, {
    bool isSecurityThreat = false,

    /// NEW FLAG
    bool isShowApprovalAsClose = false,

    String Function(String key)? titleForKey,
  }) {
    if (map == null) return [];

    return map.entries
        .where((entry) {
          if (entry.value == null) return false;

          if (ignoredKeys.contains(entry.key)) return false;

          /// Hide original closed card
          /// because approved becomes closed
          if (isShowApprovalAsClose && entry.key == 'closed') {
            return false;
          }

          return true;
        })
        .map((item) {
          String key = item.key;
          String count = item.value.toString();

          /// Replace Approved -> Closed
          if (isShowApprovalAsClose && item.key == 'approved') {
            count = (map['approved'] ?? 0).toString();
            key = 'closed';
          }

          String title = titleForKey != null
              ? titleForKey(key)
              : formatKey(key);

          return StatSummaryData(
            title: title,
            count: count,
            description: "",
            icon: getIcon(key),
            iconBgColor: getColor(key),
          );
        })
        .toList();
  }

  static String formatKey(String key) {
    final withSpaces = key
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .replaceAll('_', ' ');

    return withSpaces.replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }

  static IconData getIcon(String key) {
    switch (key) {
      case 'total_requests':
        return Icons.assignment_outlined;

      case 'assigned':
        return Icons.task_alt_outlined;

      case 'in_progress':
        return Icons.timelapse_outlined;

      case 'completed':
        return Icons.check_circle_outline;

      case 'approved':
      case 'closed':
        return Icons.check_circle_outline;

      case 'pending':
        return Icons.pending_actions_outlined;

      case 'rejected':
        return Icons.cancel_outlined;

      case 'expired':
        return Icons.timer_off_outlined;

      default:
        return Icons.insert_chart_outlined;
    }
  }

  static Color getColor(String key) {
    switch (key) {
      case 'total_requests':
        return const Color(0xFFF3F4F6);

      case 'assigned':
        return const Color(0xFFE3F2FD);

      case 'in_progress':
        return const Color(0xFFFFF8E1);

      case 'completed':
        return const Color(0xFFE8F5E9);

      case 'approved':
      case 'closed':
        return const Color(0xFFE8F5E9);

      case 'pending':
        return const Color(0xFFFFF8E1);

      case 'rejected':
        return const Color(0xFFFFEBEE);

      case 'expired':
        return const Color(0xFFF3E5F5);

      default:
        return const Color(0xFFE3F2FD);
    }
  }
}
