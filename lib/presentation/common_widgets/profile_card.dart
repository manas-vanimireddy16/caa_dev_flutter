import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String name;

  // Keep avatarUrl receiving, but do not show in UI
  final String avatarUrl;

  final bool isOnline;
  final Color accentColor;

  // Dynamic info map
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
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
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

            /// NAME ONLY (LEFT SIDE)
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
                  iconAsset: _getIconAssetForKey(entry.key),
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

  /// Helper: Map field names to icons
  String? _getIconAssetForKey(String key) {
    if (_isPhoneKey(key)) return AppIcons.phoneEmployeeCard;
    return null;
  }

  bool _isPhoneKey(String key) {
    final normalized = key.toLowerCase();
    return normalized.contains('phone') || key.contains('هاتف');
  }

  IconData _getIconForKey(String key) {
    final normalized = key.toLowerCase();
    if (_isPhoneKey(key)) return Icons.phone;
    if (normalized.contains('email') || normalized.contains('mail') || key.contains('بريد')) {
      return Icons.email;
    }
    if (normalized.contains('location') || key.contains('موقع')) {
      return Icons.location_on;
    }
    if (normalized.contains('role') || key.contains('دور')) {
      return Icons.work;
    }
    if (normalized.contains('department') || key.contains('دائرة')) {
      return Icons.apartment;
    }
    if (normalized.contains('section') || key.contains('قسم')) {
      return Icons.apartment;
    }
    if (normalized.contains('designation')) {
      return Icons.badge;
    }

    switch (normalized) {
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
  final String? iconAsset;
  final String title;
  final String text;

  const InfoRow({
    super.key,
    required this.icon,
    this.iconAsset,
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
        if (iconAsset != null)
          KImageProvider(
            image: iconAsset,
            width: 20.toAutoScaledHeight,
            height: 20.toAutoScaledHeight,
            tintColor: Colors.indigo.shade900,
          )
        else
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
