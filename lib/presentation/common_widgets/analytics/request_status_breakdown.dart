import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/analytics/analytics_card_header.dart';
import 'package:code_setup/presentation/common_widgets/analytics/analytics_period_dropdown.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RequestStatusBreakdownCard extends StatelessWidget {
  static const double _cardBorderRadius = 8;
  static const double _cardPadding = 16;
  static const double _sectionGap = 16;
  static const double _chartSize = 174;
  static const double _chartToBreakdownGap = 12;

  // Dynamic, fully flexible input
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

  //int get totalValue => data.values.fold(0, (prev, e) => prev + e.value);
  @override
  Widget build(BuildContext context) {
    final chartSections = data;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardBorderRadius),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const SizedBox(height: _sectionGap),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
            const SizedBox(height: _sectionGap),
            _buildContent(context, chartSections),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AnalyticsCardHeader(
      icon: icon ?? Icons.pie_chart_outline,
      title: title,
      titleStyle: AppTextStyles.requestStatusBreakdownTitle(),
      trailing: AnalyticsPeriodDropdown(
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
    );
  }

  //   Widget _buildContent(BuildContext context, List<ChartData> chartSections) {
  //     final currentTheme = KAppX.globalProvider
  //         .read(KAppX.theme.current)
  //         .themeBox;
  //     return Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Pie Chart Section
  //         SizedBox(
  //           height: 190,
  //           width: 140,
  //           child: Stack(
  //             alignment: Alignment.center,
  //             children: [
  //               PieChart(
  //                 PieChartData(
  //                   sectionsSpace: 3,
  //                   centerSpaceRadius: 45,
  //                   sections: chartSections
  //                       // ✅ Filter out any section where status == "Total"
  //                       .where(
  //                         (section) => section.status?.toLowerCase() != 'total',
  //                       )
  //                       .map((section) {
  //                         return PieChartSectionData(
  //                           color: getStatusColor(section.status),
  //                           value: section.percentage,
  //                           title: '', // you can add % if needed
  //                           radius: 22,
  //                           borderSide: const BorderSide(
  //                             color: Colors.white,
  //                             width: 2,
  //                           ),
  //                         );
  //                       })
  //                       .toList(),
  //                 ),
  //                 swapAnimationDuration: const Duration(milliseconds: 800),
  //                 swapAnimationCurve: Curves.easeInOut,
  //               ),

  //               // Center Total
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     '${data.isNotEmpty ? data[0].count ?? 0 : 0}',
  //                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
  //                       fontWeight: FontWeight.w700,
  //                       color: const Color(0xFF111827),
  //                       fontSize: currentTheme.fontSizes.s25,
  //                     ),
  //                   ),
  //                   2.toVerticalSizedBox,
  //                   Text(
  //                     'Total Requests',
  //                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                       color: const Color(0xFFDADADA),
  //                       fontSize: currentTheme.fontSizes.s11,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         32.toHorizontalSizedBox,
  //         // Legend Section
  //         Expanded(
  //           child: _BreakdownLegend(
  //             // totalValue: breakdown?.totalRequests ?? 0,
  //             sections: chartSections,
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }
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

  List<ChartData> _ensureTotalSection(List<ChartData> chartSections) {
    if (chartSections.any((section) => _isTotalStatus(section.status))) {
      return chartSections;
    }

    final total = _resolveCenterTotal(chartSections);
    return [
      ChartData(status: 'Total', count: total, percentage: 100),
      ...chartSections,
    ];
  }

  Widget _buildContent(BuildContext context, List<ChartData> chartSections) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    // ✅ Check if closed exists
    final hasClosed = chartSections.any(
      (e) => e.status?.toLowerCase() == 'closed',
    );

    // ✅ Remove approved if closed exists
    final filteredSections = hasClosed
        ? chartSections
              .where((e) => e.status?.toLowerCase() != 'approved')
              .toList()
        : chartSections;

    final sectionsWithTotal = _ensureTotalSection(filteredSections);
    final centerTotal = _resolveCenterTotal(sectionsWithTotal);
    final pieSections = sectionsWithTotal
        .where((section) => !_isTotalStatus(section.status))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: SizedBox(
            height: _chartSize,
            width: _chartSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 50,
                    sections: pieSections.map((section) {
                          final value =
                              (section.count?.toDouble() ?? 0) > 0
                              ? section.count!.toDouble()
                              : (section.percentage ?? 0);
                          return PieChartSectionData(
                            color: getStatusColor(section.status),
                            value: value,
                            title: '',
                            radius: 26,
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          );
                        })
                        .toList(),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 800),
                  swapAnimationCurve: Curves.easeInOut,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$centerTotal',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                            fontSize: currentTheme.fontSizes.s25,
                            height: 1,
                          ),
                    ),
                    4.toVerticalSizedBox,
                    Text(
                      centerMetricLabel,
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.requestStatusBreakdownDescriptionLabel(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: _chartToBreakdownGap),
        _BreakdownLegend(
          sections: sectionsWithTotal,
          legendHeading: legendHeading,
          centerMetricLabel: centerMetricLabel,
          statusLabelBuilder: statusLabelBuilder,
        ),
      ],
    );
  }
}

class _BreakdownLegend extends StatelessWidget {
  final List<ChartData> sections;
  final String legendHeading;
  final String centerMetricLabel;
  final String Function(String status)? statusLabelBuilder;

  const _BreakdownLegend({
    required this.sections,
    required this.legendHeading,
    required this.centerMetricLabel,
    this.statusLabelBuilder,
  });

  bool _isTotalStatus(String? status) {
    final normalized = status?.toLowerCase().trim() ?? '';
    return normalized == 'total' ||
        normalized == 'total requests' ||
        normalized == 'total tickets' ||
        normalized == 'total approvals';
  }

  String _resolveLabel(ChartData section) {
    if (_isTotalStatus(section.status)) {
      return centerMetricLabel;
    }

    if (statusLabelBuilder != null) {
      return statusLabelBuilder!(section.status ?? 'NA');
    }

    return section.status ?? 'NA';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            legendHeading,
            style: AppTextStyles.requestStatusBreakdownStatusLabel(),
          ),
        ),
        const SizedBox(height: RequestStatusBreakdownCard._sectionGap),
        ...sections
            .where((section) => section.status?.toLowerCase() != 'cancelled')
            .map(
              (section) => Padding(
                padding: const EdgeInsets.only(
                  bottom: RequestStatusBreakdownCard._sectionGap / 2,
                  left: 12,
                  right: 12,
                ),
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
          width: 12.toAutoScaledWidth,
          height: 12.toAutoScaledHeight,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        12.toHorizontalSizedBox,
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.requestStatusBreakdownDescriptionLabel(),
          ),
        ),
        Text('$value', style: AppTextStyles.requestStatusBreakdownCountValue()),
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _FilterDropdown({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.toAutoScaledHeight,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD1D5DB)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF374151),
                fontSize: currentTheme.fontSizes.s14,
              ),
            ),
            6.toHorizontalSizedBox,
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Color(0xFF6B7280),
            ),
          ],
        ),
      ),
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
      return AppColors.disabledGrey; // default color if status doesn't match
  }
}
