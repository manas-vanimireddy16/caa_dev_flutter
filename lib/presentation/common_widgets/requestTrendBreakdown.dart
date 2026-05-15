// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class RequestTrendBreakdownCard extends StatelessWidget {
//   final List<int> monthlyData; // 12 values for Jan–Dec
//   final List<String> monthLabels; // ["Jan", "Feb", ...]
//   final String selectedYear;
//   final String metric;
//   final Color barColor;
//   final void Function()? onYearTap;
//   final Function(String?) onChanged;
//   final List<String> filterLabelList;

//   const RequestTrendBreakdownCard({
//     super.key,
//     required this.monthlyData,
//     required this.monthLabels,
//     this.metric = 'Total Tickets',
//     this.selectedYear = "2025",
//     this.barColor = const Color(0xFFBD8A52),
//     this.onYearTap,
//     required this.onChanged,
//     required this.filterLabelList,
//   });
//   // : assert(monthlyData.length == 12),
//   //      assert(monthLabels.length == 12);

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     return Card(
//       color: currentTheme.colors.onPrimary,
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//         side: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFDCE7F6),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: const Icon(
//                     Icons.insert_chart_outlined,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 12.toHorizontalSizedBox,
//                 Expanded(
//                   child: Text(
//                     "Request Trend  Breakdown",
//                     style: textTheme.labelLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       fontSize: currentTheme.fontSizes.s16,
//                     ),
//                   ),
//                 ),
//                 // _YearDropdown(label: selectedYear.toString(), onTap: onYearTap),
//                 SizedBox(
//                   width: 120.toAutoScaledWidth,
//                   child: KDropdownField<dynamic>(
//                     value: selectedYear,
//                     // fieldHeadingText: 'New Bank Name *',
//                     hintText: 'Select',

//                     items:
//                         filterLabelList
//                             ?.map<KDropdownItem<dynamic>>(
//                               (opt) => KDropdownItem<dynamic>(
//                                 value: opt,
//                                 child: Text(opt),
//                               ),
//                             )
//                             .toList() ??
//                         [],

//                     onChanged: (v) {
//                       onChanged(v);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Divider(thickness: 1, color: const Color(0xFFE5E7EB)),
//             const SizedBox(height: 6),
//             // Legend Row
//             Row(
//               children: [
//                 Container(
//                   width: 18,
//                   height: 18,
//                   margin: const EdgeInsets.only(right: 8),
//                   decoration: BoxDecoration(
//                     color: barColor,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Text(
//                   metric,
//                   style: textTheme.bodyMedium?.copyWith(
//                     color: currentTheme.colors.secondary,
//                     fontWeight: currentTheme.fontWeights.wRegular,
//                   ),
//                 ),
//               ],
//             ),
//             16.toVerticalSizedBox,
//             // Bar Chart Section
//             AspectRatio(
//               aspectRatio: 1.8,
//               child: _RequestTrendBarChart(
//                 data: monthlyData,
//                 barColor: barColor,
//                 labels: monthLabels,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Bar Chart Implementation with interactive tooltip (hover/tap)
// class _RequestTrendBarChart extends StatefulWidget {
//   final List<int> data;
//   final Color barColor;
//   final List<String> labels;

//   const _RequestTrendBarChart({
//     required this.data,
//     required this.barColor,
//     required this.labels,
//   });

//   @override
//   State<_RequestTrendBarChart> createState() => _RequestTrendBarChartState();
// }

// class _RequestTrendBarChartState extends State<_RequestTrendBarChart> {
//   int? touchedIndex;

//   @override
//   Widget build(BuildContext context) {
//     int maxValue = 0;
//     if (widget.data.isNotEmpty) {
//       maxValue = (widget.data.reduce((a, b) => a > b ? a : b) * 1.2).ceil();
//     }
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     final maxDataValue = widget.data.reduce((a, b) => a > b ? a : b);
//     final maxY = (maxDataValue * 1.2).ceilToDouble();

//     double calculateInterval(double maxY) {
//       if (maxY <= 10) return 2;
//       if (maxY <= 50) return 10;
//       if (maxY <= 200) return 20;
//       if (maxY <= 500) return 50;
//       if (maxY > 500) return 100;
//       return (maxY / 5).ceilToDouble();
//     }

//     return BarChart(
//       BarChartData(
//         minY: 0,
//         maxY: maxValue.toDouble(),
//         barGroups: List.generate(
//           12,
//           (i) => BarChartGroupData(
//             x: i,
//             barRods: [
//               BarChartRodData(
//                 toY: widget.data.isNotEmpty ? widget.data[i].toDouble() : 0.0,
//                 color: widget.barColor,
//                 width: 20.toAutoScaledWidth,
//                 borderRadius: BorderRadius.circular(0),
//                 borderSide: BorderSide.none,
//                 // Optional - subtle elevation on touch
//                 rodStackItems: [],
//               ),
//             ],
//           ),
//         ),
//         borderData: FlBorderData(show: false),
//         gridData: FlGridData(show: false),
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 36,
//               interval: calculateInterval(maxY),
//               minIncluded: true, // ⭐ ensures 0 is shown
//               getTitlesWidget: (value, meta) {
//                 return SideTitleWidget(
//                   meta: meta,
//                   child: Text(
//                     value.toInt().toString(),
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       fontSize: 10,
//                       color: const Color(0xFF9CA3AF),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 28,
//               interval: 1, // ⭐ show EVERY month
//               getTitlesWidget: (value, meta) {
//                 final index = value.toInt();

//                 final month = widget.labels[index];

//                 /// ⭐ force short name (Jan Feb Mar)
//                 final shortMonth = month.length >= 3
//                     ? month.substring(0, 3)
//                     : month;

//                 return SideTitleWidget(
//                   meta: meta,
//                   child: Text(
//                     shortMonth,
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       fontSize: 10, // ⭐ keep small
//                       color: const Color(0xFF9CA3AF),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         barTouchData: BarTouchData(
//           enabled: true,
//           touchTooltipData: BarTouchTooltipData(
//             getTooltipColor: (group) =>
//                 Colors.white, // custom tooltip background color
//             tooltipBorderRadius: BorderRadius.circular(8.toAutoScaledWidth),
//             fitInsideVertically: true,
//             fitInsideHorizontally: true,
//             tooltipPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 8,
//             ),
//             getTooltipItem: (group, groupIndex, rod, rodIndex) {
//               final month = widget.labels[groupIndex];
//               final value = widget.data[groupIndex];
//               return BarTooltipItem(
//                 '$month, ${DateTime.now().year} : $value',
//                 const TextStyle(
//                   color: Color(0xFF282357),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _YearDropdown extends StatelessWidget {
//   final String label;
//   final VoidCallback? onTap;
//   const _YearDropdown({required this.label, this.onTap});
//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 36.toAutoScaledHeight,
//         decoration: BoxDecoration(
//           border: Border.all(color: const Color(0xFFC1C7D0)),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               label,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black87,
//                 fontSize: currentTheme.fontSizes.s14,
//               ),
//             ),
//             const Icon(
//               Icons.keyboard_arrow_down,
//               size: 20,
//               color: Colors.black54,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/chart_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RequestTrendBreakdownCard extends StatelessWidget {
  final List<int> monthlyData; // 12 values for Jan–Dec
  final List<String> monthLabels; // ["Jan", "Feb", ...]
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
    this.selectedYear = "2025",
    this.barColor = const Color(0xFF283593),
    this.onYearTap,
    required this.onChanged,
    required this.filterLabelList,
    this.title = 'Request Trend Breakdown',
  });
  // : assert(monthlyData.length == 12),
  //      assert(monthLabels.length == 12);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE7F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.insert_chart_outlined,
                    color: Colors.black87,
                  ),
                ),
                12.toHorizontalSizedBox,
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: currentTheme.fontSizes.s16,
                    ),
                  ),
                ),
                // _YearDropdown(label: selectedYear.toString(), onTap: onYearTap),
                SizedBox(
                  width: 120.toAutoScaledWidth,
                  child: KDropdownField<dynamic>(
                    value: selectedYear,
                    // fieldHeadingText: 'New Bank Name *',
                    hintText: 'Select',

                    items:
                        filterLabelList
                            ?.map<KDropdownItem<dynamic>>(
                              (opt) => KDropdownItem<dynamic>(
                                value: opt,
                                child: Text(opt),
                              ),
                            )
                            .toList() ??
                        [],

                    onChanged: (v) {
                      onChanged(v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(thickness: 1, color: const Color(0xFFE5E7EB)),
            const SizedBox(height: 6),
            // Legend Row
            Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text(
                  metric,
                  style: textTheme.bodyMedium?.copyWith(
                    color: currentTheme.colors.secondary,
                    fontWeight: currentTheme.fontWeights.wRegular,
                  ),
                ),
              ],
            ),
            16.toVerticalSizedBox,
            // Bar Chart Section
            AspectRatio(
              aspectRatio: 1.8,
              child: _RequestTrendBarChart(
                data: monthlyData,
                barColor: barColor,
                labels: monthLabels,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bar Chart Implementation with interactive tooltip (hover/tap)
class _RequestTrendBarChart extends StatefulWidget {
  final List<int> data;
  final Color barColor;
  final List<String> labels;

  const _RequestTrendBarChart({
    required this.data,
    required this.barColor,
    required this.labels,
  });

  @override
  State<_RequestTrendBarChart> createState() => _RequestTrendBarChartState();
}

class _RequestTrendBarChartState extends State<_RequestTrendBarChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    int maxValue = 0;
    if (widget.data.isNotEmpty) {
      maxValue = (widget.data.reduce((a, b) => a > b ? a : b) * 1.2).ceil();
    }
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final maxDataValue = widget.data.isEmpty
        ? 0
        : widget.data.reduce((a, b) => a > b ? a : b).toDouble();

    final rawMax = maxDataValue * 1.2;

    final interval = ChartUtils.calculateInterval(rawMax);
    final maxY = ChartUtils.calculateNiceMaxY(rawMax);
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxValue.toDouble(),
        barGroups: List.generate(
          12,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: widget.data.isNotEmpty ? widget.data[i].toDouble() : 0.0,
                color: widget.barColor,
                width: 20.toAutoScaledWidth,
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
                // Optional - subtle elevation on touch
                rodStackItems: [],
              ),
            ],
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: interval,
              minIncluded: true, // ⭐ ensures 0 is shown
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    value.toInt().toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                );
              },
            ),
          ),

          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1, // ⭐ show EVERY month
              getTitlesWidget: (value, meta) {
                final index = value.toInt();

                final month = widget.labels[index];

                /// ⭐ force short name (Jan Feb Mar)
                final shortMonth = month.length >= 3
                    ? month.substring(0, 3)
                    : month;

                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    shortMonth,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10, // ⭐ keep small
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) =>
                Colors.white, // custom tooltip background color
            tooltipBorderRadius: BorderRadius.circular(8.toAutoScaledWidth),
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final month = widget.labels[groupIndex];
              final value = widget.data[groupIndex];
              return BarTooltipItem(
                '$month, ${DateTime.now().year} : $value',
                const TextStyle(
                  color: Color(0xFF282357),
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

class _YearDropdown extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _YearDropdown({required this.label, this.onTap});
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
          border: Border.all(color: const Color(0xFFC1C7D0)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: currentTheme.fontSizes.s14,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
