import 'package:code_setup/presentation/common_widgets/request_details/reusable_table_row_model.dart';
import 'package:flutter/material.dart';

class ReusableExpandableTable extends StatefulWidget {
  final List<String> headings;
  final List<ReusableTableRow> rows;
  final bool isExpandable;
  final String? totalText;
  final String? totalValue;

  const ReusableExpandableTable({
    super.key,
    required this.headings,
    required this.rows,
    this.isExpandable = false,
    this.totalText,
    this.totalValue,
  });

  @override
  State<ReusableExpandableTable> createState() =>
      _ReusableExpandableTableState();
}

class _ReusableExpandableTableState extends State<ReusableExpandableTable> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                for (var heading in widget.headings)
                  Expanded(
                    child: Text(
                      heading,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                if (widget.isExpandable) const SizedBox(width: 24),
              ],
            ),
          ),

          /// BODY
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.rows.length,
            itemBuilder: (context, index) {
              final row = widget.rows[index];
              bool isExpanded = expandedIndex == index;

              return InkWell(
                onTap: widget.isExpandable
                    ? () {
                        setState(() {
                          expandedIndex = isExpanded ? null : index;
                        });
                      }
                    : null,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          for (var cell in row.cells)
                            Expanded(
                              child: Text(
                                cell,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          if (widget.isExpandable)
                            AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: const Icon(Icons.keyboard_arrow_down),
                            ),
                        ],
                      ),
                    ),

                    /// EXPANDED
                    if (widget.isExpandable)
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: const SizedBox(),
                        secondChild: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                          color: Colors.blueGrey.withOpacity(.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(row.expandedTitle ?? ""),
                              const SizedBox(height: 6),
                              Text(row.expandedDescription ?? ""),
                            ],
                          ),
                        ),
                      ),

                    const Divider(height: 1),
                  ],
                ),
              );
            },
          ),

          /// TOTAL
          if (widget.totalText != null)
            Container(
              padding: const EdgeInsets.all(14),
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.totalText!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    widget.totalValue ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
