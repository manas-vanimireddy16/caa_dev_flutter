import 'package:code_setup/presentation/screens/hc_service/models/allowance_entry.dart';
import 'package:flutter/material.dart';

class AllowanceCard extends StatelessWidget {
  final AllowanceEntry entry;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AllowanceCard({
    super.key,
    required this.entry,
    required this.isExpanded,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final values = entry.values;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(values['employeeName'] ?? 'Employee'),
            subtitle: Text(values['department'] ?? ''),
            trailing: IconButton(
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              onPressed: onTap,
            ),
          ),

          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mission Days: ${values['missionDays'] ?? '-'}'),
                  Text('Allowance %: ${values['allowancePercentage'] ?? '-'}%'),
                  Text('Allowance / Day: ${values['allowancePerDay'] ?? '-'}'),
                  Text('Total Amount: ${_calculateTotal(values)}'),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: onEdit,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _calculateTotal(Map<String, dynamic> values) {
    final days = int.tryParse('${values['missionDays']}') ?? 0;
    final perDay = double.tryParse('${values['allowancePerDay']}') ?? 0;
    final percent = int.tryParse('${values['allowancePercentage']}') ?? 0;

    if (percent <= 0) {
      return '0.00';
    }

    return (days * perDay * (percent / 100)).toStringAsFixed(2);
  }
}
