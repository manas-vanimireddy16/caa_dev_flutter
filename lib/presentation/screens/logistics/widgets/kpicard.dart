import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/kpi.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

/// -----------------------------
/// StatSummaryRow dynamically renders cards
/// -----------------------------
class StatSummaryRow extends StatelessWidget {
  final KpiData? data;
  final double spacing;
  final double runSpacing;

  const StatSummaryRow({
    super.key,
    required this.data,
    this.spacing = 12,
    this.runSpacing = 18,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    // ✅ Convert KpiData to Map for dynamic rendering
    final entries = data?.toMap().entries.toList() ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardMaxWidth = ((constraints.maxWidth - spacing) / 2)
              .clamp(120, 180)
              .toDouble();

          return Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            children: entries.map((entry) {
              return StatSummaryCard(
                title: entry.key,
                count: entry.value.toString(),
                maxWidth: cardMaxWidth,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

/// -----------------------------
/// StatSummaryCard dynamically renders single card
/// -----------------------------
class StatSummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final double maxWidth;

  const StatSummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 110.toAutoScaledWidth,
        maxWidth: maxWidth,
      ),
      child: Card(
        color: currentTheme.colors.onPrimary,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.toAutoScaledWidth,
            vertical: 12.toAutoScaledHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: currentTheme.fontSizes.s14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                count,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: currentTheme.fontSizes.s20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
