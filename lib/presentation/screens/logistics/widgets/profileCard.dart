import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String name;

  // Keep receiving image URL but don't show in UI
  final String avatarUrl;

  final bool isOnline;
  final Color accentColor;
  final double avatarSize;

  // Dynamic fields
  final Map<String, String> info;

  const ProfileCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
    required this.info,
    this.accentColor = const Color(0xFF6C63FF),
    this.avatarSize = 120,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.toAutoScaledWidth,
                  height: 40.toAutoScaledHeight,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.event_note,
                    color: accentColor,
                    size: 22.toAutoScaledHeight,
                  ),
                ),

                12.toHorizontalSizedBox,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: currentTheme.fontSizes.s16,
                          fontWeight: currentTheme.fontWeights.wBold,
                        ),
                      ),

                      2.toVerticalSizedBox,

                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: currentTheme.fontSizes.s13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            12.toVerticalSizedBox,

            Divider(color: Colors.grey.shade300, thickness: 1),

            16.toVerticalSizedBox,

            /// NAME LEFT SIDE
            Text(
              name,
              style: TextStyle(
                fontSize: currentTheme.fontSizes.s16,
                fontWeight: FontWeight.w600,
              ),
            ),

            20.toVerticalSizedBox,

            /// INFO LIST
            ...info.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InfoRow(
                  icon: _getIconForKey(entry.key),
                  title: entry.key,
                  text: entry.value,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  /// KEY -> ICON
  IconData _getIconForKey(String key) {
    switch (key.toLowerCase()) {
      case "email":
        return Icons.email;

      case "phone":
        return Icons.phone;

      case "location":
        return Icons.location_on;

      case "role":
        return Icons.work;

      case "department":
        return Icons.apartment;

      case "designation":
        return Icons.badge;

      default:
        return Icons.info_outline;
    }
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.indigo.shade900, size: 20.toAutoScaledHeight),

        12.toHorizontalSizedBox,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              2.toVerticalSizedBox,

              Text(
                text,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
