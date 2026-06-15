import 'package:code_setup/presentation/screens/hc_service/performance_management/widgets/expandable_weight_card.dart';
import 'package:flutter/material.dart';

class WeightList<T> extends StatefulWidget {
  final List<T> items;

  final String Function(T item) title;
  final String Function(T item) description;

  final int Function(T item) weight;
  final void Function(T item, int weight) onWeightChanged;

  const WeightList({
    super.key,
    required this.items,
    required this.title,
    required this.description,
    required this.weight,
    required this.onWeightChanged,
  });

  @override
  State<WeightList<T>> createState() => _DynamicWeightListState<T>();
}

class _DynamicWeightListState<T> extends State<WeightList<T>> {
  int get totalWeight =>
      widget.items.fold(0, (sum, e) => sum + widget.weight(e));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.items.map((item) {
          return ExpandableWeightCard(
            title: widget.title(item),
            description: widget.description(item),
            weight: widget.weight(item),

            onChanged: (value) {
              setState(() {});

              widget.onWeightChanged(item, value);
            },
          );
        }),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Total: $totalWeight %",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
