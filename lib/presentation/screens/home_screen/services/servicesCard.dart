import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';

class CustomInfoCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color iconBackgroundColor;
  final List<String> subServices;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;
  final VoidCallback? onCardTap;
  final void Function(String)? onSubServiceTap;

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.iconBackgroundColor = const Color(0xFF1E3A5F),
    required this.subServices,
    required this.isBookmarked,
    this.onBookmarkToggle,
    this.onCardTap,
    this.onSubServiceTap,
  });

  @override
  State<CustomInfoCard> createState() => _CustomInfoCardState();
}

class _CustomInfoCardState extends State<CustomInfoCard> {
  bool _expanded = false;

  static const _borderColor = Color(0xFFE8E8E8);
  static const _subtitleColor = Color(0xFF6B7280);
  static const _chipBackground = Color(0xFFF3F4F6);
  static const _chipTextColor = Color(0xFF374151);

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.toAutoScaledHeight),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.toAutoScaledWidth),
          side: const BorderSide(color: _borderColor, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onCardTap,
          child: Padding(
            padding: EdgeInsets.all(16.toAutoScaledWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40.toAutoScaledWidth,
                      height: 40.toAutoScaledHeight,
                      decoration: BoxDecoration(
                        color: widget.iconBackgroundColor,
                        borderRadius: BorderRadius.circular(
                          8.toAutoScaledWidth,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: Colors.white,
                        size: 24.toAutoScaledWidth,
                      ),
                    ),
                    SizedBox(width: 12.toAutoScaledWidth),
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.toAutoScaledWidth,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.25,
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: widget.onBookmarkToggle,
                    //   behavior: HitTestBehavior.opaque,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(4.toAutoScaledWidth),
                    //     child: Icon(
                    //       widget.isBookmarked
                    //           ? Icons.bookmark
                    //           : Icons.bookmark_border,
                    //       color: Colors.black87,
                    //       size: 22.toAutoScaledWidth,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 10.toAutoScaledHeight),
                Text(
                  widget.subtitle,
                  maxLines: _expanded ? null : 3,
                  overflow: _expanded ? null : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.toAutoScaledWidth,
                    fontWeight: FontWeight.w400,
                    color: _subtitleColor,
                    height: 1.4,
                  ),
                ),
                if (_expanded && widget.subServices.isNotEmpty) ...[
                  SizedBox(height: 12.toAutoScaledHeight),
                  Wrap(
                    spacing: 8.toAutoScaledWidth,
                    runSpacing: 8.toAutoScaledHeight,
                    children: widget.subServices.map((tag) {
                      return InkWell(
                        onTap: () => widget.onSubServiceTap?.call(tag),
                        borderRadius: BorderRadius.circular(
                          20.toAutoScaledWidth,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.toAutoScaledWidth,
                            vertical: 6.toAutoScaledHeight,
                          ),
                          decoration: BoxDecoration(
                            color: _chipBackground,
                            borderRadius: BorderRadius.circular(
                              20.toAutoScaledWidth,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 12.toAutoScaledWidth,
                              fontWeight: FontWeight.w500,
                              color: _chipTextColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                SizedBox(height: 12.toAutoScaledHeight),
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    _expanded ? l10n.servicesLessInfo : l10n.servicesMoreInfo,
                    style: TextStyle(
                      fontSize: 13.toAutoScaledWidth,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Rotating accent colors for service icon containers (reference design).
Color serviceCardIconColorForIndex(int index) {
  const colors = [
    Color(0xFF1E3A5F),
    Color(0xFFC4A574),
    Color(0xFF2D5A4A),
    Color(0xFF4A5568),
    Color(0xFF5B4B8A),
  ];
  return colors[index % colors.length];
}
