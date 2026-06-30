import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KDrawerHeader extends ConsumerWidget {
  final VoidCallback? onClose;

  const KDrawerHeader({super.key, this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;
    final user = KAppX.globalProvider.read(userProvider);
    final name = user?.employeeName?.trim() ?? '';
    final email = user?.email?.trim() ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toAutoScaledWidth),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularTextAvatar(
            text: name,
            width: 32.toAutoScaledWidth,
          ),
          12.toHorizontalSizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s18,
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
                      fontSize: currentTheme.fontSizes.s12,
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

  CircularTextAvatar({required this.text, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: currentTheme.colors.primary,
        shape: BoxShape.circle,
      ),
      child: text != ''
          ? Text(
              text.substring(0, 1).toUpperCase() ?? '',

              // state.activityList[index].username!.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: currentTheme.fontSizes.s16,
              ),
            )
          : Text(
              '',

              // state.activityList[index].username!.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: currentTheme.fontSizes.s16,
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
    required this.data,
    required this.isSelected,
    required this.currentTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? currentTheme.colors.primary.withOpacity(0.08)
        : Colors.transparent;

    final iconColor = isSelected
        ? currentTheme.colors.primary
        : currentTheme.colors.onBackground;

    final textColor = iconColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.toAutoScaledWidth),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.toAutoScaledWidth,
          vertical: 4.toAutoScaledHeight,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.toAutoScaledWidth,
          vertical: 10.toAutoScaledHeight,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.toAutoScaledWidth),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22.toAutoScaledWidth,
              height: 22.toAutoScaledWidth,

              // child: data.icon,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn, // allows tinting
                ),
                child: data.icon,
              ),
            ),

            12.toHorizontalSizedBox,
            Expanded(
              child: Text(
                data.label,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: isSelected
                      ? currentTheme.fontWeights.wBold
                      : currentTheme.fontWeights.wRegular,
                  color: textColor,
                  // fontFamily: GoogleFonts.mitr().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
