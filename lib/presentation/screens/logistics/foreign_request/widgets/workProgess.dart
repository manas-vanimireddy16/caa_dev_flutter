import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_foreign_model.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final WorkflowDetail task;
  final bool isLast;

  const TimelineItem({super.key, required this.task, this.isLast = false});

  Color _getStatusColor() {
    switch (task.status) {
      case "Completed":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (task.status) {
      case "Completed":
        return Icons.check_circle;
      case "Pending":
        return Icons.radio_button_checked;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
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
        10.toHorizontalSizedBox,

        /// Right side (task details)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.content ?? 'N/A',
                style: TextStyle(
                  fontWeight: currentTheme.fontWeights.wBold,
                  fontSize: currentTheme.fontSizes.s16,
                ),
              ),
              4.toVerticalSizedBox,
              Text(
                "Approved by: ${task.id}",
                style: TextStyle(color: Colors.black54),
              ),
              if (task.createdBy != null)
                Text(
                  (task.createdBy).toString(),
                  style: TextStyle(color: Colors.black45),
                ),
              12.toVerticalSizedBox,
            ],
          ),
        ),
      ],
    );
  }
}
