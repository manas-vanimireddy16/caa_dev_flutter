import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Device width breakpoints for page-level mobile vs tablet layouts.
/// Prefer [LayoutBuilder] for card-level switches so they work in drawers/split panes.
class Responsive extends ConsumerWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive(this.mobile, this.tablet, {super.key});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1400;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1400;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return tablet;
        }
        return mobile;
      },
    );
  }
}
