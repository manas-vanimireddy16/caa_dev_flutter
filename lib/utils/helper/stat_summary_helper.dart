import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:flutter/material.dart';

class StatSummaryHelper {
  static const List<String> ignoredKeys = ['pendingActionItems'];

  static List<StatSummaryData> buildStatList(Map<String, dynamic>? map) {
    if (map == null) return [];

    return map.entries
        .where(
          (entry) => entry.value != null && !ignoredKeys.contains(entry.key),
        )
        .map(
          (item) => StatSummaryData(
            title: formatKey(item.key),
            count: item.value.toString(),
            description: "",
            icon: getIcon(item.key),
            iconBgColor: getColor(item.key),
          ),
        )
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
      case 'approved':
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
      case 'approved':
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
