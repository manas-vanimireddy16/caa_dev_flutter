import 'dart:math' as math;

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/analytics/analytics_period_dropdown.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Request trend card — matches FM HRMS visual proportions:
/// compact fixed dropdown, brown bars (width 18), readable axis labels,
/// finite chart width + horizontal scroll when needed.
class RequestTrendBreakdownCard extends StatelessWidget {
  /// Minimum width reserved for each month group when scrolling.
  static const double _minBarGroupWidth = 52;

  final List<int> monthlyData;
  final List<String> monthLabels;
  final String selectedYear;
  final String metric;
  final Color barColor;
  final void Function()? onYearTap;
  final Function(String?) onChanged;
  final List<String> filterLabelList;
  final String title;

  const RequestTrendBreakdownCard({
    super.key,
    required this.monthlyData,
    required this.monthLabels,
    this.metric = 'Total Tickets',
    this.selectedYear = '2025',
    this.barColor = AppColors.trendBarColor,
    this.onYearTap,
    required this.onChanged,
    required this.filterLabelList,
    this.title = 'Request Trend Breakdown',
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    const borderColor = Color(0xFFE5E7EB);

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.insert_chart_outlined,
                    size: 20,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ),
                AnalyticsPeriodDropdown(
                  value: selectedYear,
                  filterLabelList: filterLabelList,
                  onChanged: (v) => onChanged(v as String?),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 1, color: borderColor),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  metric,
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF6B7280),
                    fontWeight: currentTheme.fontWeights.wRegular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final finiteParentWidth = constraints.maxWidth.isFinite
                    ? constraints.maxWidth
                    : (12 * _minBarGroupWidth).toDouble();
                final chartWidth = math.max(
                  finiteParentWidth,
                  12 * _minBarGroupWidth,
                );
                // Avoid shrinking too much in landscape.
                final chartHeight = math.max(220.0, 200.toAutoScaledHeight);

                return SizedBox(
                  height: chartHeight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: chartWidth,
                      child: _RequestTrendBarChart(
                        data: monthlyData,
                        barColor: barColor,
                        labels: monthLabels,
                        selectedYear: selectedYear,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestTrendBarChart extends StatelessWidget {
  final List<int> data;
  final Color barColor;
  final List<String> labels;
  final String selectedYear;

  const _RequestTrendBarChart({
    required this.data,
    required this.barColor,
    required this.labels,
    required this.selectedYear,
  });

  double _calculateInterval(double value) {
    if (value <= 0) return 1;
    if (value <= 5) return 1;
    if (value <= 12) return 2;
    if (value <= 25) return 5;
    if (value <= 50) return 10;
    if (value <= 100) return 20;
    if (value <= 250) return 50;
    if (value <= 500) return 100;
    return (value / 5).ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';
    final safeData = List<int>.generate(
      12,
      (i) => i < data.length ? data[i] : 0,
    );
    final maxDataValue = safeData.reduce((a, b) => a > b ? a : b);
    final maxValue = maxDataValue == 0 ? 2 : maxDataValue;
    final interval = _calculateInterval(maxValue.toDouble());
    final lastTick =
        math.max(interval, (maxValue / interval).ceil() * interval).toDouble();
    final maxY = lastTick + (interval * 0.35);

    final axisStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontSize: 12,
      color: const Color(0xFF6B7280),
      height: 1.1,
    );

    final yTitles = SideTitles(
      reservedSize: 36,
      showTitles: true,
      interval: interval,
      getTitlesWidget: (value, meta) {
        if (value > lastTick + 0.001) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 4),
          child: Text(value.toInt().toString(), style: axisStyle),
        );
      },
    );

    return BarChart(
      BarChartData(
        maxY: maxY,
        groupsSpace: 18,
        alignment: BarChartAlignment.spaceAround,
        barGroups: List.generate(12, (i) {
          final dataIndex = isRtl ? 11 - i : i;
          return BarChartGroupData(
            x: i,
            barsSpace: 0,
            barRods: [
              BarChartRodData(
                toY: safeData[dataIndex].toDouble(),
                color: barColor,
                width: 18,
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
                rodStackItems: const [],
              ),
            ],
          );
        }),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: isRtl
                ? const SideTitles(showTitles: false)
                : yTitles,
          ),
          rightTitles: AxisTitles(
            sideTitles: isRtl
                ? yTitles
                : const SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt().clamp(0, 11);
                final labelIdx = isRtl ? 11 - idx : idx;
                final raw = labelIdx < labels.length
                    ? labels[labelIdx]
                    : '';
                final short = raw.length >= 3 ? raw.substring(0, 3) : raw;
                return SideTitleWidget(
                  meta: meta,
                  space: 6,
                  child: Text(short, style: axisStyle),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.white,
            tooltipBorderRadius: BorderRadius.circular(8),
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final idx = isRtl ? 11 - groupIndex : groupIndex;
              final month = idx < labels.length ? labels[idx] : '';
              final value = safeData[idx];
              return BarTooltipItem(
                '$month, $selectedYear : $value',
                const TextStyle(
                  color: Color(0xFF111827),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
