import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class StatSummaryData {
  final String title;
  final String count;
  final String description;
  final IconData icon;
  final Color iconBgColor;

  StatSummaryData({
    required this.title,
    required this.count,
    required this.description,
    required this.icon,
    required this.iconBgColor,
  });
}

class StatSummaryRow extends StatelessWidget {
  final List<StatSummaryData> stats;
  final double spacing;
  final double runSpacing;

  const StatSummaryRow({
    super.key,
    required this.stats,
    this.spacing = 16,
    this.runSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < stats.length; i += 2) {
      if (i > 0) {
        rows.add(SizedBox(height: runSpacing));
      }

      rows.add(
        Row(
          children: [
            Expanded(child: StatSummaryCard(data: stats[i])),
            SizedBox(width: spacing),
            Expanded(
              child: i + 1 < stats.length
                  ? StatSummaryCard(data: stats[i + 1])
                  : const SizedBox(),
            ),
          ],
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

  const StatSummaryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final hasDescription = data.description.trim().isNotEmpty;

    return SizedBox(
      height: 110,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: currentTheme.colors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),

                    Text(
                      data.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: currentTheme.fontSizes.s14,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      data.count,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: currentTheme.fontSizes.s20,
                          ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: data.iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data.icon, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// /// -----------------------------
// /// StatSummaryRow dynamically renders cards
// /// -----------------------------
// class StatSummaryRow extends StatelessWidget {
//   final KPIData? data;
//   final double spacing;
//   final double runSpacing;

//   const StatSummaryRow({
//     super.key,
//     required this.data,
//     this.spacing = 12,
//     this.runSpacing = 18,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     // ✅ Convert KpiData to Map for dynamic rendering
//     final entries = data?.toMap().entries.toList() ?? [];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final cardMaxWidth = ((constraints.maxWidth - spacing) / 2)
//               .clamp(120, 180)
//               .toDouble();

//           return Wrap(
//             spacing: spacing,
//             runSpacing: runSpacing,
//             children: entries.map((entry) {
//               return StatSummaryCard(
//                 title: entry.key,
//                 count: entry.value.toString(),
//                 maxWidth: cardMaxWidth,
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// /// -----------------------------
// /// StatSummaryCard dynamically renders single card
// /// -----------------------------
// class StatSummaryCard extends StatelessWidget {
//   final String title;
//   final String count;
//   final double maxWidth;

//   const StatSummaryCard({
//     super.key,
//     required this.title,
//     required this.count,
//     required this.maxWidth,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         minWidth: 110.toAutoScaledWidth,
//         maxWidth: maxWidth,
//       ),
//       child: Card(
//         color: currentTheme.colors.onPrimary,
//         margin: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
//         ),
//         elevation: 0,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 12.toAutoScaledWidth,
//             vertical: 12.toAutoScaledHeight,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   fontSize: currentTheme.fontSizes.s14,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 count,
//                 style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   fontSize: currentTheme.fontSizes.s20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
