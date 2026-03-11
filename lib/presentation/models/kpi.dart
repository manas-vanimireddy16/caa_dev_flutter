import 'package:flutter/material.dart';

class StatSummaryRData {
  final String title;
  final String count;
  final String description;
  final IconData icon;
  final Color iconBgColor;

  StatSummaryRData({
    required this.title,
    required this.count,
    required this.description,
    required this.icon,
    required this.iconBgColor,
  });

  /// Optional: Factory constructor from JSON (if you plan to fetch from API)
  factory StatSummaryRData.fromJson(Map<String, dynamic> json) {
    return StatSummaryRData(
      title: json['title'] ?? '',
      count: json['count']?.toString() ?? '0',
      description: json['description'] ?? '',
      icon: json['icon'] ?? Icons.info, // fallback icon
      iconBgColor: json['iconBgColor'] != null
          ? Color(json['iconBgColor'])
          : Colors.grey,
    );
  }

  /// Optional: Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'count': count,
      'description': description,
      'icon': icon.codePoint, // store icon as int
      'iconBgColor': iconBgColor.value, // store color as int
    };
  }
}
