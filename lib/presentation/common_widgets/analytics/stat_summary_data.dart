import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class StatSummaryData {
  final String title;
  final String count;
  final String description;
  final String icon;
  final Color iconBgColor;
  final Color iconColor;

  StatSummaryData({
    required this.title,
    required this.count,
    required this.description,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}

/// Responsive KPI strip:
/// - phone / narrow: 2×2 grid
/// - tablet / wide (≥ 600) and ≤4 stats: single row of equal cards
class StatSummaryRow extends StatelessWidget {
  final List<StatSummaryData> stats;
  final double spacing;
  final double horizontalPadding;

  /// Width at which we switch from 2 columns to a single row.
  static const double tabletBreakpoint = 600;

  const StatSummaryRow({
    super.key,
    required this.stats,
    this.spacing = 10,
    this.horizontalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 8,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final useSingleRow =
              width >= tabletBreakpoint && stats.length <= 4;
          final columns = useSingleRow ? stats.length.clamp(1, 4) : 2;

          return _StatSummaryGrid(
            stats: stats,
            columns: columns,
            spacing: spacing,
          );
        },
      ),
    );
  }
}

class _StatSummaryGrid extends StatelessWidget {
  final List<StatSummaryData> stats;
  final int columns;
  final double spacing;

  const _StatSummaryGrid({
    required this.stats,
    required this.columns,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var start = 0; start < stats.length; start += columns) {
      final end = (start + columns).clamp(0, stats.length);
      final rowChildren = <Widget>[];

      for (var i = start; i < end; i++) {
        if (i > start) rowChildren.add(SizedBox(width: spacing));
        rowChildren.add(
          Expanded(
            child: StatSummaryCard(
              data: stats[i],
              compact: columns > 2,
            ),
          ),
        );
      }

      // Fill remaining columns so last row stays aligned.
      final remaining = columns - (end - start);
      for (var i = 0; i < remaining; i++) {
        rowChildren.add(SizedBox(width: spacing));
        rowChildren.add(const Expanded(child: SizedBox.shrink()));
      }

      if (rows.isNotEmpty) rows.add(SizedBox(height: spacing));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowChildren,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class StatSummaryCard extends StatelessWidget {
  final StatSummaryData data;

  /// Slightly tighter padding when 4 cards share one row (tablet).
  final bool compact;

  const StatSummaryCard({
    super.key,
    required this.data,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final horizontalPad = compact ? 10.0 : 14.0;
    final verticalPad = compact ? 12.0 : 16.0;
    final titleSize = compact
        ? currentTheme.fontSizes.s11
        : currentTheme.fontSizes.s12;
    final valueSize = compact
        ? currentTheme.fontSizes.s18
        : currentTheme.fontSizes.s20;
    final iconSize = compact ? 16.0 : 18.0;

    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPad,
          vertical: verticalPad,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: titleSize,
                      color: const Color(0xFF111827),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.count,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: valueSize,
                      color: const Color(0xFF111827),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Container(
              decoration: BoxDecoration(
                color: data.iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(5),
              child: KImageProvider(
                image: data.icon,
                width: iconSize,
                height: iconSize,
                tintColor: data.iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
