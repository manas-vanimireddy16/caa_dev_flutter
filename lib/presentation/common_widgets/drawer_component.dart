import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/responsive/drawer_metrics.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Drawer header — fixed [DrawerMetrics] sizes (no width auto-scaling).
class KDrawerHeader extends ConsumerWidget {
  final VoidCallback? onClose;

  const KDrawerHeader({super.key, this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;
    final metrics = DrawerMetrics.of(context);
    final user = KAppX.globalProvider.read(userProvider);
    final name = user?.employeeName?.trim() ?? '';
    final email = user?.email?.trim() ?? '';

    return Padding(
      padding: EdgeInsets.fromLTRB(
        metrics.itemMarginH,
        metrics.topInset / 4,
        metrics.itemMarginH,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularTextAvatar(
            text: name,
            width: metrics.avatar,
            fontSize: metrics.nameSize,
          ),
          SizedBox(width: metrics.itemHPad),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: metrics.nameSize,
                    fontWeight: currentTheme.fontWeights.wBolder,
                    color: currentTheme.colors.onBackground,
                  ),
                ),
                if (email.isNotEmpty)
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: metrics.emailSize,
                      fontWeight: currentTheme.fontWeights.wRegular,
                      color: currentTheme.colors.onBackground,
                    ),
                  ),
              ],
            ),
          ),
          if (onClose != null) ...[
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Close',
              onPressed: onClose,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),
          ],
        ],
      ),
    );
  }
}

class CircularTextAvatar extends ConsumerWidget {
  final String text;
  final double width;
  final double? fontSize;

  const CircularTextAvatar({
    super.key,
    required this.text,
    required this.width,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;
    final letter = text.isNotEmpty ? text.substring(0, 1).toUpperCase() : '';

    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: currentTheme.colors.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        letter,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? currentTheme.fontSizes.s16,
        ),
      ),
    );
  }
}

class DrawerItemData {
  final int index;
  final Widget icon;
  final String label;
  final String? code;

  const DrawerItemData({
    required this.index,
    required this.icon,
    required this.label,
    this.code,
  });
}

class DrawerMenuItem extends StatelessWidget {
  final DrawerItemData data;
  final bool isSelected;
  final KThemeBox currentTheme;
  final VoidCallback onTap;

  const DrawerMenuItem({
    super.key,
    required this.data,
    required this.isSelected,
    required this.currentTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = DrawerMetrics.of(context);
    final bgColor = isSelected
        ? currentTheme.colors.primary.withOpacity(0.08)
        : Colors.transparent;

    final iconColor = isSelected
        ? currentTheme.colors.primary
        : currentTheme.colors.onBackground;

    final textColor = iconColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(metrics.radius),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: metrics.itemMarginH,
          vertical: metrics.itemMarginV,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: metrics.itemHPad,
          vertical: metrics.itemVPad,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(metrics.radius),
        ),
        child: Row(
          children: [
            SizedBox(
              width: metrics.itemIcon,
              height: metrics.itemIcon,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
                child: data.icon,
              ),
            ),
            SizedBox(width: metrics.itemHPad),
            Expanded(
              child: Text(
                data.label,
                style: TextStyle(
                  fontSize: metrics.itemText,
                  fontWeight: isSelected
                      ? currentTheme.fontWeights.wBold
                      : currentTheme.fontWeights.wRegular,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
