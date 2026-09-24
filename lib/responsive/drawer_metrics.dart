import 'dart:math' as math;

import 'package:code_setup/responsive/app_page_layout.dart';
import 'package:flutter/material.dart';

/// Fixed drawer metrics — avoid width-based auto-scaling so iPad stays compact.
class DrawerMetrics {
  final bool isTablet;

  const DrawerMetrics._(this.isTablet);

  factory DrawerMetrics.of(BuildContext context) =>
      DrawerMetrics._(AppPageLayout.isTablet(context));

  double drawerWidthFor(double screenWidth) {
    if (isTablet) {
      return math.min(360.0, screenWidth * 0.42);
    }
    return math.max(280.0, screenWidth - 56);
  }

  double get topInset => isTablet ? 48 : 52;
  double get avatar => isTablet ? 40 : 42;
  double get nameSize => isTablet ? 15 : 16;
  double get emailSize => 12;
  double get sectionIcon => 18;
  double get sectionTitle => isTablet ? 14 : 15;
  double get itemIcon => isTablet ? 20 : 22;
  double get itemText => isTablet ? 13.5 : 14;
  double get itemVPad => isTablet ? 8 : 10;
  double get itemHPad => 12;
  double get itemMarginH => 12;
  double get itemMarginV => 2;
  double get radius => 10;
}
