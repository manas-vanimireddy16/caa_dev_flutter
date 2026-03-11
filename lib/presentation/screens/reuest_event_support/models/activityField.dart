import 'package:flutter/material.dart';

class ActivityItem {
  final String title;
  final String subtitle;
  final String timeAgo;
  final bool isCompleted;

  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.isCompleted,
  });
}
