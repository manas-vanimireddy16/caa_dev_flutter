import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';

enum ServicesListFilter { all, myServices }

class ServicesSearchField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final String hintText;

  const ServicesSearchField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<ServicesSearchField> createState() => _ServicesSearchFieldState();
}

class _ServicesSearchFieldState extends State<ServicesSearchField> {
  late final TextEditingController _controller;

  static const _borderColor = Color(0xFFE5E7EB);
  static const _hintColor = Color(0xFF9CA3AF);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant ServicesSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.cairo(
          fontSize: 14.toAutoScaledWidth,
          fontWeight: FontWeight.w400,
          color: _hintColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: _hintColor,
          size: 22.toAutoScaledWidth,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.toAutoScaledHeight,
          horizontal: 12.toAutoScaledWidth,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
          borderSide: BorderSide(
            color: Colors.black.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
      ),
      style: AppTextStyles.cairo(
        fontSize: 14.toAutoScaledWidth,
        color: Colors.black87,
      ),
    );
  }
}

class ServicesFilterToggle extends StatelessWidget {
  final ServicesListFilter selected;
  final ValueChanged<ServicesListFilter> onChanged;
  final String allServicesLabel;
  final String myServicesLabel;

  const ServicesFilterToggle({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.allServicesLabel,
    required this.myServicesLabel,
  });

  static const _activeBackground = Colors.black;
  static const _inactiveBorder = Color(0xFFE5E7EB);
  static const _inactiveText = Colors.black87;

  static const _barHeight = 38.0;
  static const _buttonHeight = 38.0;
  static const _gap = 8.0;
  static const _buttonRadius = 4.0;
  static const _buttonPaddingH = 10.0;
  static const _buttonPaddingV = 7.0;
  static const _iconGap = 6.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _barHeight.toAutoScaledHeight,
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              height: _buttonHeight.toAutoScaledHeight,
              radius: _buttonRadius.toAutoScaledWidth,
              paddingH: _buttonPaddingH.toAutoScaledWidth,
              paddingV: _buttonPaddingV.toAutoScaledHeight,
              iconGap: _iconGap.toAutoScaledWidth,
              label: allServicesLabel,
              icon: Icons.grid_view_rounded,
              isSelected: selected == ServicesListFilter.all,
              onTap: () => onChanged(ServicesListFilter.all),
            ),
          ),
          SizedBox(width: _gap.toAutoScaledWidth),
          Expanded(
            child: _SegmentButton(
              height: _buttonHeight.toAutoScaledHeight,
              radius: _buttonRadius.toAutoScaledWidth,
              paddingH: _buttonPaddingH.toAutoScaledWidth,
              paddingV: _buttonPaddingV.toAutoScaledHeight,
              iconGap: _iconGap.toAutoScaledWidth,
              label: myServicesLabel,
              icon: Icons.bookmark_border,
              isSelected: selected == ServicesListFilter.myServices,
              onTap: () => onChanged(ServicesListFilter.myServices),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final double height;
  final double radius;
  final double paddingH;
  final double paddingV;
  final double iconGap;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.height,
    required this.radius,
    required this.paddingH,
    required this.paddingV,
    required this.iconGap,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = isSelected ? Colors.white : ServicesFilterToggle._inactiveText;
    final bg = isSelected
        ? ServicesFilterToggle._activeBackground
        : Colors.white;
    final border = isSelected
        ? ServicesFilterToggle._activeBackground
        : ServicesFilterToggle._inactiveBorder;

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: border, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              paddingH,
              paddingV,
              paddingH,
              paddingV,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18.toAutoScaledWidth, color: fg),
                SizedBox(width: iconGap),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cairo(
                      fontSize: 13.toAutoScaledWidth,
                      fontWeight: FontWeight.w600,
                      color: fg,
                      height: 1.2,
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
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.04),
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
                        size: 22.toAutoScaledWidth,
                      ),
                    ),
                    SizedBox(width: 12.toAutoScaledWidth),
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cairo(
                          fontSize: 16.toAutoScaledWidth,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.25,
                        ),
                      ),
                    ),
                    _BookmarkToggleButton(
                      isBookmarked: widget.isBookmarked,
                      onTap: widget.onBookmarkToggle,
                    ),
                  ],
                ),
                SizedBox(height: 10.toAutoScaledHeight),
                Text(
                  widget.subtitle,
                  maxLines: _expanded ? null : 3,
                  overflow: _expanded ? null : TextOverflow.ellipsis,
                  style: AppTextStyles.cairo(
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
                            style: AppTextStyles.cairo(
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
                    style: AppTextStyles.cairo(
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

class _BookmarkToggleButton extends StatefulWidget {
  final bool isBookmarked;
  final VoidCallback? onTap;

  const _BookmarkToggleButton({required this.isBookmarked, this.onTap});

  @override
  State<_BookmarkToggleButton> createState() => _BookmarkToggleButtonState();
}

class _BookmarkToggleButtonState extends State<_BookmarkToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.onTap == null) return;
    await _scaleController.forward();
    await _scaleController.reverse();
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(
            left: 4.toAutoScaledWidth,
            top: 2.toAutoScaledHeight,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              key: ValueKey(widget.isBookmarked),
              color: Colors.black87,
              size: 22.toAutoScaledWidth,
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
