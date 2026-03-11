import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final ActivitiesFeedData item;

  const ActivityTile({super.key, required this.item});

  /// ✅ Calculate "x min/hr/day ago" directly here
  String getTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays} days ago';
  }

  /// ✅ Convert status → bool for icon color
  bool getIsCompleted(String status) {
    return status.toLowerCase() == 'approved';
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = getIsCompleted(item.status ?? '');
    final timeAgo = getTimeAgo(item.timestamp ?? DateTime.now());

    return Column(
      children: [
        ListTile(
          leading: Icon(
            isCompleted ? Icons.check_circle : Icons.access_time,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
          title: Text(
            item.title ?? '',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${item.type} • ${item.subType} • ${item.status}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          trailing: Text(
            timeAgo,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
