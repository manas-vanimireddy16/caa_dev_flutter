import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;

  const HeaderSection({this.title, this.subtitle, this.icon, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDE8),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(10),
            child: Center(child: Icon(icon, color: const Color(0xFF8D2814))),
          ),
        if (icon != null) const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: Color(0xFF808080),
                ),
              ),
          ],
        ),
        // KAppX.extendedRouter.bottomSheet,
      ],
    );
  }
}
