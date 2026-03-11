import 'package:flutter/material.dart';

import '../models/activityField.dart';

class ActivityTile extends StatelessWidget {
  final ActivityItem item;

  const ActivityTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            item.isCompleted ? Icons.check_circle : Icons.access_time,
            color: item.isCompleted ? Colors.green : Colors.orange,
          ),
          title: Text(
            item.title,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item.subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          trailing: Text(
            item.timeAgo,
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
