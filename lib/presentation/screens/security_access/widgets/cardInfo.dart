import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/status_widget.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Map<String, String> info;

  const CardInfo({
    super.key,
    required this.title,
    this.subtitle,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    // Split grid fields vs long-text fields
    final gridEntries = info.entries.where(
      (e) =>
          e.key.toLowerCase() != "problem statement" &&
          e.key.toLowerCase() != "description",
    );

    final problemStatement = info.entries.firstWhere(
      (e) => e.key.toLowerCase() == "problem statement",
      orElse: () => const MapEntry("", ""),
    );
    final description = info.entries.firstWhere(
      (e) => e.key.toLowerCase() == "description",
      orElse: () => const MapEntry("", ""),
    );

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.indigo.shade900),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s16,
                    fontWeight: currentTheme.fontWeights.wBold,
                  ),
                ),
              ],
            ),

            12.toVerticalSizedBox,
            Divider(color: Colors.grey.shade300, thickness: 1),
            16.toVerticalSizedBox,

            // Optional subtitle
            if (subtitle != null) ...[
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  color: Colors.grey.shade700,
                ),
              ),
              16.toVerticalSizedBox,
            ],

            // ✅ Grid for short info
            // ✅ Replace your GridView.count with this
            Column(
              children: [
                for (int i = 0; i < gridEntries.length; i += 2)
                  Row(
                    children: [
                      // Left column
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: InfoTile(
                            title: gridEntries.elementAt(i).key,
                            text:
                                gridEntries.elementAt(i).key.toLowerCase() ==
                                    "status"
                                ? null
                                : gridEntries.elementAt(i).value,
                            textWidget:
                                gridEntries.elementAt(i).key.toLowerCase() ==
                                    "status"
                                ? StatusChip(
                                    status: gridEntries.elementAt(i).value,
                                  )
                                : null,
                          ),
                        ),
                      ),

                      // Right column (if exists)
                      if (i + 1 < gridEntries.length)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: InfoTile(
                              title: gridEntries.elementAt(i + 1).key,
                              text:
                                  gridEntries
                                          .elementAt(i + 1)
                                          .key
                                          .toLowerCase() ==
                                      "status"
                                  ? null
                                  : gridEntries.elementAt(i + 1).value,
                              textWidget:
                                  gridEntries
                                          .elementAt(i + 1)
                                          .key
                                          .toLowerCase() ==
                                      "status"
                                  ? StatusChip(
                                      status: gridEntries
                                          .elementAt(i + 1)
                                          .value,
                                    )
                                  : null,
                            ),
                          ),
                        )
                      else
                        const Expanded(
                          child: SizedBox(),
                        ), // keep alignment if odd count
                    ],
                  ),
              ],
            ),

            16.toVerticalSizedBox,

            // ✅ Problem Statement (full width)
            if (problemStatement.key.isNotEmpty) ...[
              Text(
                problemStatement.key,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  fontWeight: currentTheme.fontWeights.wBold,
                  color: Colors.grey.shade600,
                ),
              ),
              6.toVerticalSizedBox,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  problemStatement.value,
                  style: TextStyle(fontSize: currentTheme.fontSizes.s14),
                ),
              ),
              16.toVerticalSizedBox,
            ],

            // ✅ Description (full width)
            if (description.key.isNotEmpty) ...[
              Text(
                description.key,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  fontWeight: currentTheme.fontWeights.wBold,
                  color: Colors.grey.shade600,
                ),
              ),
              6.toVerticalSizedBox,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  description.value,
                  style: TextStyle(fontSize: currentTheme.fontSizes.s14),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String? text;
  final Widget? textWidget;

  const InfoTile({super.key, required this.title, this.text, this.textWidget});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Row(
      children: [
        Icon(_getIconForKey(title), color: Colors.indigo.shade900, size: 20),
        8.toHorizontalSizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  color: Colors.grey.shade600,
                ),
              ),
              2.toVerticalSizedBox,
              textWidget ??
                  Text(
                    text ?? "",
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: currentTheme.fontWeights.wBold,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getIconForKey(String key) {
    switch (key.toLowerCase()) {
      case "status":
        return Icons.verified;
      case "requested date":
        return Icons.calendar_today;
      case "approver":
        return Icons.person;
      case "assigned to":
        return Icons.work_outline;
      default:
        return Icons.info_outline;
    }
  }
}
