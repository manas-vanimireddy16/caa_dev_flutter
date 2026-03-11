import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.event_note, color: accentColor, size: 22),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Build Info from map
            ...info.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InfoRow(
                  icon: _getIconForKey(entry.key),
                  label: entry.key,
                  value: entry.value,
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
        Icon(icon, color: Colors.indigo.shade900, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$label: ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold, // ✅ Bold Key
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal, // ✅ Normal Value
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
