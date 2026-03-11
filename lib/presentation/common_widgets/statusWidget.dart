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
        bg = Colors.green.shade100;
        text = Colors.green.shade700;
        icon = Icons.check_circle;
        break;
      case "completed":
        bg = Colors.green.shade100;
        text = Colors.green.shade700;
        icon = Icons.check_circle;
        break;
      case "pending":
        bg = Colors.orange.shade100;
        text = Colors.orange.shade700;
        icon = Icons.access_time;
        break;
      case "in progress":
        bg = Colors.green.shade100;
        text = const Color.fromARGB(255, 94, 147, 233);
        icon = Icons.check_circle;
        break;
      case "assigned":
        bg = Colors.green.shade100;
        text = const Color.fromARGB(255, 94, 147, 233);
        icon = Icons.check_circle;
        break;
      case "rejected":
        bg = Colors.red.shade100;
        text = Colors.red.shade700;
        icon = Icons.cancel;
        break;
      // no `default` needed anymore since we set initial values
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
