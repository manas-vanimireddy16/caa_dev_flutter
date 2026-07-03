import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Shared analytics card title bar (icon, title, trailing control).
class AnalyticsCardHeader extends StatelessWidget {
  static const double minHeight = 44;
  static const double gap = 12;
  static const double iconBoxSize = 36;

  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final TextStyle? titleStyle;
  final Widget trailing;

  const AnalyticsCardHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.iconBackgroundColor = const Color(0xFFF3F4F6),
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTitleStyle =
        (titleStyle ?? AppTextStyles.requestStatusBreakdownTitle())
            .copyWith(height: 1);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: minHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: iconBoxSize,
            height: iconBoxSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF374151)),
          ),
          const SizedBox(width: gap),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: resolvedTitleStyle,
            ),
          ),
          const SizedBox(width: gap),
          trailing,
        ],
      ),
    );
  }
}
