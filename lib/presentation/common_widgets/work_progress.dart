import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';

class TimelineItem<T> extends StatelessWidget {
  final T task;
  final bool isLast;

  const TimelineItem({super.key, required this.task, this.isLast = false});

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
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
    // extract unified data once
    String? status;
    String? content;
    String? createdBy;
    String? idText;
    String? name;
    String? role;

    if (task is Workflow) {
      final w = task as Workflow;
      status = w.status;
      content = w.content;
      createdBy = w.createdBy.toString();
      idText = w.id?.toString();
    } else {
      // fallback: try toString
      content = task?.toString();
    }

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              _getStatusIcon(status),
              color: _getStatusColor(status),
              size: 28,
            ),
            if (!isLast)
              Container(
                width: 2.toAutoScaledWidth,
                height: 50.toAutoScaledHeight,
                color: Colors.grey.shade400,
              ),
          ],
        ),
        10.toHorizontalSizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content ?? 'N/A',
                style: TextStyle(
                  fontWeight: currentTheme.fontWeights.wBold,
                  fontSize: currentTheme.fontSizes.s16,
                ),
              ),
              4.toVerticalSizedBox,
              Text(
                "Approved by: ${idText ?? 'N/A'}",
                style: TextStyle(color: Colors.black54),
              ),
              if (createdBy != null)
                Text(createdBy, style: TextStyle(color: Colors.black45)),
              12.toVerticalSizedBox,
            ],
          ),
        ),
      ],
    );
  }
}
