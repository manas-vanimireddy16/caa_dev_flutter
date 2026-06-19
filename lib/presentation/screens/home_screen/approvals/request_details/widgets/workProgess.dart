import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/model/requestProgressModel.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final Task task;
  final bool isLast;

  const TimelineItem({super.key, required this.task, this.isLast = false});

  Color _getStatusColor() {
    switch (task.status) {
      case "completed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (task.status) {
      case "completed":
        return Icons.check_circle;
      case "pending":
        return Icons.radio_button_checked;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Left side (status + vertical line)
        Column(
          children: [
            Icon(_getStatusIcon(), color: _getStatusColor(), size: 28),
            if (!isLast)
              Container(
                width: 2.toAutoScaledWidth,
                height: 50.toAutoScaledHeight,
                color: Colors.grey.shade400,
              ),
          ],
        ),
        const SizedBox(width: 10),

        /// Right side (task details)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.taskName,
                style: AppTextStyles.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Approved by: ${task.approvedBy}",
                style: AppTextStyles.cairo(color: Colors.black54),
              ),
              if (task.date != null)
                Text(
                  task.date!,
                  style: AppTextStyles.cairo(color: Colors.black45),
                ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
