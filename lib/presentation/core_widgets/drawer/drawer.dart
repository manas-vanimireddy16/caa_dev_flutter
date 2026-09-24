import 'package:code_setup/responsive/drawer_metrics.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App drawer shell. Width and chrome use [DrawerMetrics] (fixed phone/tablet
/// sizes) — do not width-auto-scale drawer chrome on iPad.
class KDrawer extends ConsumerWidget {
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final double? width;
  final Widget? child;
  final String? semanticLabel;

  const KDrawer({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.width,
    this.child,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);
    final metrics = DrawerMetrics.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final resolvedWidth = width ?? metrics.drawerWidthFor(screenWidth);

    return Drawer(
      backgroundColor:
          backgroundColor ?? currentTheme.themeBox.colors.background,
      elevation: elevation,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(metrics.radius),
              bottomRight: Radius.circular(metrics.radius),
            ),
          ),
      width: resolvedWidth,
      semanticLabel: semanticLabel,
      shadowColor: currentTheme.themeBox.colors.onBackground.withOpacity(0.7),
      child: child,
    );
  }
}
