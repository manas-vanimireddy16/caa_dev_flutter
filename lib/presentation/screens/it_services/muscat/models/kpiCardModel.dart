import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketStat {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  TicketStat({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });
}

/// Provider returning read-only list
final ticketProvider = Provider<List<TicketStat>>((ref) {
  return [
    TicketStat(
      title: "Total Tickets",
      count: 48,
      icon: Icons.list_alt_outlined,
      color: Colors.grey,
    ),
    TicketStat(
      title: "Open Tickets",
      count: 32,
      icon: Icons.lock_open_rounded,
      color: Colors.blue,
    ),
    TicketStat(
      title: "In Progress",
      count: 8,
      icon: Icons.access_time,
      color: Colors.orange,
    ),
    TicketStat(
      title: "Closed",
      count: 8,
      icon: Icons.lock,
      color: Colors.green,
    ),
  ];
});
