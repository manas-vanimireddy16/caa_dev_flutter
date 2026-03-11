import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketStat {
  final String title;
  final String count;
  final String description;
  final IconData icon;
  final Color iconBgColor;

  TicketStat({
    required this.title,
    required this.count,
    required this.icon,
    required this.iconBgColor,
    required this.description,
  });
}

/// Provider returning read-only list
final ticketProvider = Provider<List<TicketStat>>((ref) {
  return [
    TicketStat(
      title: "Total Tickets",
      count: "48",
      description: "All tickets recorded so far",
      icon: Icons.list_alt_outlined,
      iconBgColor: Colors.grey,
    ),
    TicketStat(
      title: "Open Tickets",
      count: "32",
      description: "Tickets waiting for action",
      icon: Icons.lock_open_rounded,
      iconBgColor: Colors.blue,
    ),
    TicketStat(
      title: "In Progress",
      count: "8",
      description: "Currently being worked on",
      icon: Icons.access_time,
      iconBgColor: Colors.orange,
    ),
    TicketStat(
      title: "Closed",
      count: "8",
      description: "Completed and resolved tickets",
      icon: Icons.lock,
      iconBgColor: Colors.green,
    ),
  ];
});
