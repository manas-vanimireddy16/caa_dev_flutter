import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

class KPICard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color bgColor;
  final double width;

  const KPICard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.bgColor,
    this.width = 180, // default width but can be overridden
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: currentTheme.paddings.h16,
            vertical: currentTheme.paddings.v12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: currentTheme.fontWeights.wBolder,
                    ),
                  ),
                  6.toVerticalSizedBox,
                  Text(
                    "$count",
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s20,
                      fontWeight: currentTheme.fontWeights.wBolder,
                    ),
                  ),
                ],
              ),
              // Right side
              CircleAvatar(
                radius: 18.toAutoScaledHeight,
                backgroundColor: bgColor.withOpacity(0.15),
                child: Icon(icon, color: bgColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
