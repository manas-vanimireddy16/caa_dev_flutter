import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Default values (fixes the error)
    Color bg = Colors.grey.shade200;
    Color text = Colors.grey.shade600;
    IconData icon = Icons.help_outline;

    switch (status.toLowerCase()) {
      case "approved":
        bg = const Color(0xFFD6E4D6);
        text = const Color(0xFF0D652D);
        icon = Icons.check_circle;
        break;

      case "completed":
        bg = const Color(0xFFD6E4D6);
        text = const Color(0xFF0D652D);
        icon = Icons.check_circle;
        break;

      case "pending":
        bg = const Color(0xFFF9F2EB);
        text = const Color(0xFFD79334);
        icon = Icons.access_time;
        break;

      case "in progress":
        bg = const Color(0xFFE8EEFF);
        text = const Color(0xFF283593);
        icon = Icons.sync;
        break;

      case "assigned":
        bg = const Color(0xFFE8EEFF);
        text = const Color(0xFF283593);
        icon = Icons.assignment_turned_in;
        break;

      case "rejected":
        bg = const Color(0xFFF2DADA);
        text = const Color(0xFFA50E0E);
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: text),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(color: text, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
