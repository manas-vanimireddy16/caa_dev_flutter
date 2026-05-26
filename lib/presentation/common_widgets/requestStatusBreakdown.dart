import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RequestStatusBreakdownCard extends StatelessWidget {
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
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final chartSections = data;
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            20.toVerticalSizedBox,
            _buildContent(context, chartSections),
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
          14.toHorizontalSizedBox,
        ],
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
        ),
        // _FilterDropdown(label: filterLabel, onTap: onFilterTap),
        SizedBox(
          width: 120.toAutoScaledWidth,
          child: KDropdownField<dynamic>(
            value: filterLabel,
            // fieldHeadingText: 'New Bank Name *',
            hintText: 'Select',

            items:
                filterLabelList
                    ?.map<KDropdownItem<dynamic>>(
                      (opt) =>
                          KDropdownItem<dynamic>(value: opt, child: Text(opt)),
                    )
                    .toList() ??
                [],

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
        ),
      ],
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pie Chart Section
        SizedBox(
          height: 190,
          width: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 40,

                  sections: filteredSections
                      .where(
                        (section) => section.status?.toLowerCase() != 'total',
                      )
                      .map((section) {
                        return PieChartSectionData(
                          color: getStatusColor(section.status),
                          value: section.percentage,
                          title: '',
                          radius: 22,
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

              // ✅ Properly centered content
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${data.isNotEmpty ? data[0].count ?? 0 : 0}',
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFDADADA),
                        fontSize: currentTheme.fontSizes.s10,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        32.toHorizontalSizedBox,

        // Legend Section
        Expanded(
          child: _BreakdownLegend(
            sections: filteredSections,
            legendHeading: legendHeading,
            statusLabelBuilder: statusLabelBuilder,
          ),
        ),
      ],
    );
  }
}

class _BreakdownLegend extends StatelessWidget {
  final List<ChartData> sections;
  final String legendHeading;
  final String Function(String status)? statusLabelBuilder;

  const _BreakdownLegend({
    required this.sections,
    required this.legendHeading,
    this.statusLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          legendHeading,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
          ),
        ),
        16.toVerticalSizedBox,
        // Total Tickets Row
        // _LegendItem(
        //   color: const Color(0xFFE5E7EB),
        //   label: 'Total Tickets',
        //   value: totalValue,
        // ),
        8.toVerticalSizedBox,
        // Dynamic legend
        ...sections
            .where((section) => section.status?.toLowerCase() != 'cancelled')
            .map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _LegendItem(
                  color: getStatusColor(section.status),
                  label: statusLabelBuilder != null
                      ? statusLabelBuilder!(section.status ?? 'NA')
                      : (section.status ?? 'NA'),
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
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280),
              fontSize: currentTheme.fontSizes.s14,
            ),
          ),
        ),
        Text(
          '$value',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontSize: currentTheme.fontSizes.s14,
          ),
        ),
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
    // make it case-insensitive
    case 'pending':
      return const Color(0xFFFFA726);
    case 'completed':
    case 'closed':
      return const Color(0xFF0D652D);
    case 'approved':
      return const Color(0xFF0D652D);
    case 'expired':
      return const Color(0xFFC02211);
    case 'in progress':
      return Color(0xFFFFB74D);
    case 'failed':
      return const Color(0xFFC02211);
    case 'rejected':
      return const Color(0xFFC02211);
    case 'assigned':
      return Color(0xFF1976D2);
    default:
      return Colors.grey; // default color if status doesn't match
  }
}
