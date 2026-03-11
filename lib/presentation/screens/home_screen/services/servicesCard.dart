import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final List<String> subServices;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;
  final VoidCallback? onMoreTap;
  final VoidCallback? onCardTap;
  final void Function(String)? onSubServiceTap; // 👈 added

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.subServices,
    required this.isBookmarked,
    this.onBookmarkToggle,
    this.onMoreTap,
    this.onCardTap,
    this.onSubServiceTap, // 👈 added
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, color: iconColor),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onBookmarkToggle,
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 8),

              /// Sub-service chips
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: subServices.map((tag) {
                  final bool isMore = tag == '+ More';
                  return InkWell(
                    onTap: isMore
                        ? onMoreTap
                        : () => onSubServiceTap?.call(tag),
                    child: Chip(
                      label: Text(tag),
                      backgroundColor: isMore
                          ? Colors.grey.shade300
                          : Colors.grey.shade100,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
