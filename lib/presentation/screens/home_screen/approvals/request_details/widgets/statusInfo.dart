import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/statusWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusInfo extends StatelessWidget {
  final String userName;
  final String initials;
  final String message;
  // final String status;
  final String dateTime;

  StatusInfo({
    required this.userName,
    required this.initials,
    required this.message,
    // required this.status,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar (initials)
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.indigo,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 4),

                // Message box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(message, style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(height: 6),

                // Status + Date
                Row(
                  children: [
                    // StatusChip(status: status),
                    const Spacer(),
                    Text(
                      formatDateTime(dateTime),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatDateTime(String isoString) {
  try {
    final dateTime = DateTime.parse(isoString);
    return DateFormat("dd MMM yyyy").format(dateTime.toLocal());
  } catch (e) {
    return "-";
  }
}
