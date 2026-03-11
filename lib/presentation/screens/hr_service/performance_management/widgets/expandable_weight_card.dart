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
  State<ExpandableWeightCard> createState() =>
      _DynamicExpandableWeightCardState();
}

class _DynamicExpandableWeightCardState extends State<ExpandableWeightCard> {
  bool expanded = false;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.weight == 0 ? "" : widget.weight.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: Column(
        children: [
          ListTile(
            title: Text(widget.title),

            trailing: SizedBox(
              width: 80,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(suffixText: "%"),
                onChanged: (v) {
                  widget.onChanged(int.tryParse(v) ?? 0);
                },
              ),
            ),

            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
          ),

          if (expanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(widget.description),
            ),
        ],
      ),
    );
  }
}
