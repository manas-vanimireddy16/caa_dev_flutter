import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  static const _tabBorderColor = Color(0xFFBFBFBF);
  static const _tabWidth = 140.0;
  static const _tabHeight = 38.0;
  static const _tabGap = 8.0;

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
        width: _tabWidth,
        height: _tabHeight,
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        margin: EdgeInsetsDirectional.only(
          start: index == 0 ? 16 : 0,
          end: _tabGap,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue75 : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue75 : _tabBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              KImageProvider(
                image: icon,
                width: 16,
                height: 16,
                tintColor: isSelected
                    ? AppColors.loginText
                    : AppColors.secondaryText,
              ),
              const SizedBox(width: _tabGap),
            ],
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.requestTabLabel(isSelected: isSelected),
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
