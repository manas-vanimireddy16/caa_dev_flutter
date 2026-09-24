import 'package:flutter/material.dart';

/// Shared page padding / radius constants and tablet detection for drawers.
///
/// Tablet rule: shortestSide ≥ 600 OR width ≥ 700.
/// Do NOT auto-scale drawer chrome with width — use [DrawerMetrics] instead.
class AppPageLayout {
  AppPageLayout._();

  static const double pagePad = 16;
  static const double cardPad = 16;
  static const double sectionGap = 12;
  static const double itemGap = 12;
  static const double radius = 16;
  static const double pageTitleSize = 22;
  static const double cardRadius = 14;
  static const double cardIconSize = 40;

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.shortestSide >= 600 || size.width >= 700;
  }

  static EdgeInsets get pageInsets =>
      const EdgeInsets.symmetric(horizontal: pagePad);

  static EdgeInsets get pageInsetsWithTop =>
      const EdgeInsets.fromLTRB(pagePad, 12, pagePad, 0);
}
