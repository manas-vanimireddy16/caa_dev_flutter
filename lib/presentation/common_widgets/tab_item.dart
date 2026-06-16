import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    final icon = _iconForText(text);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF26285F) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? const Color(0xFF26285F) : Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              KImageProvider(
                image: icon,
                width: 18,
                height: 18,
                tintColor: isSelected ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _iconForText(String label) {
    final normalized = label
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (normalized.contains('request detail')) {
      return AppIcons.requestDetailsRequestDetails;
    }
    if (normalized.contains('request history') ||
        normalized.contains('routing history')) {
      return AppIcons.routingHistoryRequestDetails;
    }
    if (normalized.contains('attachment')) {
      return AppIcons.attachmentsRequestDetails;
    }
    if (normalized.contains('workflow') || normalized.contains('work flow')) {
      return AppIcons.workflowRequestDetails;
    }
    return null;
  }
}
