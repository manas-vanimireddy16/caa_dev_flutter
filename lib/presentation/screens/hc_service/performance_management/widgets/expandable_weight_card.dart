import 'package:flutter/material.dart';

class ExpandableWeightCard extends StatefulWidget {
  final String title;
  final String description;
  final int weight;
  final Function(int) onChanged;

  const ExpandableWeightCard({
    super.key,
    required this.title,
    required this.description,
    required this.weight,
    required this.onChanged,
  });

  @override
  State<ExpandableWeightCard> createState() => _ExpandableWeightCardState();
}

class _ExpandableWeightCardState extends State<ExpandableWeightCard>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.weight == 0 ? "" : widget.weight.toString(),
    );
  }

  /// ⭐ VERY IMPORTANT → sync controller when parent updates weight
  @override
  void didUpdateWidget(covariant ExpandableWeightCard oldWidget) {
    if (oldWidget.weight != widget.weight) {
      controller.text = widget.weight == 0 ? "" : widget.weight.toString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          /// HEADER ROW
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: toggleExpand,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                children: [
                  /// TITLE
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                      ),
                    ),
                  ),

                  /// WEIGHT FIELD
                  SizedBox(
                    width: 85,
                    child: GestureDetector(
                      onTap: () {}, // prevent expand when typing
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "0-100",
                          suffixText: "%",
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onChanged: (v) {
                          widget.onChanged(int.tryParse(v) ?? 0);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  /// CHEVRON
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(Icons.keyboard_arrow_down, size: 26),
                  ),
                ],
              ),
            ),
          ),

          /// EXPANDED DESCRIPTION
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.description,
                style: TextStyle(color: Colors.grey.shade700, height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
