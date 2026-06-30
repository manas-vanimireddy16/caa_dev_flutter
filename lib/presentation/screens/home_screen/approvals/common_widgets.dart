import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/icons.dart';
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9), // Background color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.event_note,
                    color: Color(0xFF094368), // Icon color
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.cairo(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 16),

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
                    child: ClipOval(
                      child: KImageProvider(
                        image: avatarUrl,
                        width: avatarSize,
                        height: avatarSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Optional online indicator
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                name,
                style: AppTextStyles.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Build Info from map
            ...info.entries
                .where((entry) => entry.value.trim().isNotEmpty)
                .map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InfoRow(
                      icon: _getIconForKey(entry.key),
                      label: entry.key,
                      value: entry.value,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  String _getIconForKey(String key) {
    final normalized = key.toLowerCase();
    if (normalized.contains('mail') ||
        normalized.contains('email') ||
        normalized.contains('بريد')) {
      return AppIcons.mailEmployeeCard;
    }
    if (normalized.contains('phone') ||
        normalized.contains('هاتف') ||
        normalized.contains('contact')) {
      return AppIcons.phoneEmployeeCard;
    }
    if (normalized.contains('location') || normalized.contains('موقع')) {
      return AppIcons.locationOn;
    }
    if (normalized.contains('role') ||
        normalized.contains('دور') ||
        normalized.contains('department') ||
        normalized.contains('دائرة') ||
        normalized.contains('section') ||
        normalized.contains('قسم') ||
        normalized.contains('employee id') ||
        normalized.contains('موظف')) {
      return AppIcons.departmentEmployeeCard;
    }
    switch (normalized) {
      case "email":
        return AppIcons.mailEmployeeCard;
      case "phone":
        return AppIcons.phoneEmployeeCard;
      case "location":
        return AppIcons.locationOn;
      case "role":
        return AppIcons.departmentEmployeeCard;
      default:
        return AppIcons.defaultIcon;
    }
  }
}

class InfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KImageProvider(
          image: icon,
          tintColor: AppColors.primaryBlue75,
          width: 24.toAutoScaledWidth,
          height: 24.toAutoScaledHeight,
        ),
        // Icon(icon, color: Colors.indigo.shade900, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$label: ",
                  style: AppTextStyles.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: AppTextStyles.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
