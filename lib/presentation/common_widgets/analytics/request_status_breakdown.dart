import 'package:code_setup/presentation/common_widgets/analytics/analytics_period_dropdown.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Status breakdown — FM HRMS proportions:
/// compact fixed dropdown, donut + legend (wide ≥ 560 → Row),
/// chart size 200 or (maxWidth*0.46).clamp(150,190).
class RequestStatusBreakdownCard extends StatelessWidget {
  static const double _wideLayoutBreakpoint = 560;

  final StatusData? breakdown;
  final List<ChartData> data;
  final String filterLabel;
  final String title;
  final IconData? icon;
  final VoidCallback? onFilterTap;
  final Function(String?) onChanged;
  final List<String> filterLabelList;
  final String centerMetricLabel;
  final String legendHeading;
  final String Function(String status)? statusLabelBuilder;
  final bool preserveFilterLabelOnChange;

  const RequestStatusBreakdownCard({
    super.key,
    required this.data,
    this.title = 'Requests Status Breakdown',
    this.filterLabel = 'Weekly',
    this.icon = Icons.pie_chart_outline,
    this.onFilterTap,
    required this.breakdown,
    this.filterLabelList = const ['Weekly', 'Monthly', 'Quarterly', 'Yearly'],
    required this.onChanged,
    this.centerMetricLabel = 'Total Requests',
    this.legendHeading = 'Breakdown',
    this.statusLabelBuilder,
    this.preserveFilterLabelOnChange = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
            const SizedBox(height: 20),
            _buildContent(context, data),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 20, color: const Color(0xFF374151)),
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        AnalyticsPeriodDropdown(
          value: filterLabel,
          filterLabelList: filterLabelList,
          onChanged: (v) {
            if (v != null) {
              onChanged(
                preserveFilterLabelOnChange
                    ? v.toString()
                    : v.toString().toLowerCase(),
              );
            }
          },
        ),
      ],
    );
  }

  bool _isTotalStatus(String? status) {
    final normalized = status?.toLowerCase().trim() ?? '';
    return normalized == 'total' ||
        normalized == 'total requests' ||
        normalized == 'total tickets' ||
        normalized == 'total approvals';
  }

  int _resolveCenterTotal(List<ChartData> chartSections) {
    for (final section in chartSections) {
      if (_isTotalStatus(section.status) && section.count != null) {
        return section.count!;
      }
    }

    final fromBreakdown =
        breakdown?.totalRequests ?? breakdown?.totalApprovals;
    if (fromBreakdown != null) return fromBreakdown;

    return chartSections
        .where((section) => !_isTotalStatus(section.status))
        .fold<int>(0, (sum, section) => sum + (section.count ?? 0));
  }

  List<ChartData> _pieSections(List<ChartData> chartSections) {
    final hasClosed = chartSections.any(
      (e) => e.status?.toLowerCase() == 'closed',
    );

    final filtered = hasClosed
        ? chartSections
              .where((e) => e.status?.toLowerCase() != 'approved')
              .toList()
        : chartSections;

    return filtered
        .where((section) => !_isTotalStatus(section.status))
        .where((section) => section.status?.toLowerCase() != 'cancelled')
        .toList();
  }

  Widget _buildContent(BuildContext context, List<ChartData> chartSections) {
    final pieSections = _pieSections(chartSections);
    final totalValue = _resolveCenterTotal(chartSections);

    final legend = _BreakdownLegend(
      totalValue: totalValue,
      sections: pieSections,
      legendHeading: legendHeading,
      centerMetricLabel: centerMetricLabel,
      statusLabelBuilder: statusLabelBuilder,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideLayoutBreakpoint;
        final chartSize = isWide
            ? 200.0
            : (constraints.maxWidth * 0.46).clamp(150.0, 190.0);

        final chart = _StatusDonutChart(
          chartSize: chartSize,
          totalValue: totalValue,
          centerLabel: centerMetricLabel,
          sections: pieSections,
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: chart),
              const SizedBox(width: 24),
              Expanded(child: legend),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            chart,
            const SizedBox(height: 24),
            legend,
          ],
        );
      },
    );
  }
}

class _StatusDonutChart extends StatelessWidget {
  final double chartSize;
  final int totalValue;
  final String centerLabel;
  final List<ChartData> sections;

  const _StatusDonutChart({
    required this.chartSize,
    required this.totalValue,
    required this.centerLabel,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    // Modest ring + large enough hole for two text lines (matches image 1).
    final centerSpaceRadius = chartSize * 0.36;
    final sectionRadius = chartSize * 0.13;
    final centerBoxSize = centerSpaceRadius * 1.85;

    return Center(
      child: SizedBox(
        height: chartSize,
        width: chartSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: centerSpaceRadius,
                centerSpaceColor: Colors.white,
                sections: sections.isEmpty
                    ? [
                        PieChartSectionData(
                          color: const Color(0xFFE5E7EB),
                          value: 1,
                          title: '',
                          radius: sectionRadius,
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ]
                    : sections.map((section) {
                        final rawValue = (section.count?.toDouble() ?? 0) > 0
                            ? section.count!.toDouble()
                            : (section.percentage ?? 0);
                        return PieChartSectionData(
                          color: getStatusColor(section.status),
                          value: rawValue > 0 ? rawValue : 0.001,
                          title: '',
                          radius: sectionRadius,
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        );
                      }).toList(),
              ),
              swapAnimationDuration: const Duration(milliseconds: 800),
              swapAnimationCurve: Curves.easeInOut,
            ),
            SizedBox(
              width: centerBoxSize,
              height: centerBoxSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$totalValue',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                            fontSize: 24,
                            height: 1.1,
                          ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    centerLabel,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF818184),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakdownLegend extends StatelessWidget {
  final int totalValue;
  final List<ChartData> sections;
  final String legendHeading;
  final String centerMetricLabel;
  final String Function(String status)? statusLabelBuilder;

  const _BreakdownLegend({
    required this.totalValue,
    required this.sections,
    required this.legendHeading,
    required this.centerMetricLabel,
    this.statusLabelBuilder,
  });

  String _resolveLabel(ChartData section) {
    if (statusLabelBuilder != null) {
      return statusLabelBuilder!(section.status ?? 'NA');
    }
    return section.status ?? 'NA';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          legendHeading,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _LegendItem(
          color: const Color(0xFFE5E7EB),
          label: centerMetricLabel,
          value: totalValue,
        ),
        const SizedBox(height: 8),
        ...sections.map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _LegendItem(
              color: getStatusColor(section.status),
              label: _resolveLabel(section),
              value: section.count ?? 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280),
              fontSize: 12,
            ),
          ),
        ),
        Text(
          '$value',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

Color getStatusColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'pending':
      return AppColors.warningOrange;
    case 'completed':
    case 'closed':
    case 'approved':
      return AppColors.successGreen;
    case 'in progress':
      return AppColors.alertAmber;
    case 'rejected':
    case 'failed':
    case 'expired':
      return AppColors.errorRed;
    case 'assigned':
      return AppColors.infoBlue;
    default:
      return AppColors.disabledGrey;
  }
}
