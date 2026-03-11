import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final Workflow task;
  final bool isLast;
  final String? actorName;
  final dynamic actorId;
  final bool isCreatedBy; // NEW: indicates created-by row
  final String? roleName;

  const TimelineItem({
    super.key,
    required this.task,
    this.isLast = false,
    required this.actorName,
    required this.roleName,
    this.actorId,
    this.isCreatedBy = false, // default false
  });

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
              // label changes when this row is the creator
              Text(
                isCreatedBy
                    ? "Created by: ${actorName ?? task.createdBy ?? 'N/A'}"
                    : "Approved by: ${actorName ?? task.id ?? 'N/A'}",
                style: TextStyle(color: Colors.black54),
              ),
              if (actorId != null)
                Text(
                  "ID: ${actorId.toString()}",
                  style: TextStyle(color: Colors.black45),
                ),

              if (roleName != null)
                Text(
                  isCreatedBy ? '' : "${roleName.toString()}",
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
