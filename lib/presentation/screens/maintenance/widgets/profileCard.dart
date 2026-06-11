import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final Color accentColor;
  final double avatarSize;

  // Instead of separate fields, use a map
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
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.toAutoScaledWidth,
                  height: 40.toAutoScaledHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.event_note,
                    color: accentColor,
                    size: 22.toAutoScaledHeight,
                  ),
                ),
                12.toHorizontalSizedBox,
                Column(
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
              ],
            ),

            12.toVerticalSizedBox,
            Divider(color: Colors.grey.shade300, thickness: 1),
            16.toVerticalSizedBox,

            // Avatar + Name
            Center(
              child: Stack(
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: accentColor, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: avatarSize / 2,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                  ),
                  if (isOnline)
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            12.toVerticalSizedBox,
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            20.toVerticalSizedBox,

            // Build Info from map
            ...info.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InfoRow(
                  icon: _getIconForKey(entry.key),
                  text: entry.value,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  /// Helper function: Map key → Icon
  IconData _getIconForKey(String key) {
    switch (key) {
      case "email":
        return Icons.email;
      case "phone":
        return Icons.phone;
      case "location":
        return Icons.location_on;
      case "role":
        return Icons.apartment;
      default:
        return Icons.info;
    }
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Row(
      children: [
        Icon(icon, color: Colors.indigo.shade900, size: 20.toAutoScaledHeight),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: currentTheme.fontSizes.s14),
          ),
        ),
      ],
    );
  }
}
