import 'package:code_setup/presentation/screens/hr_service/models/allowance_entry.dart';
import 'package:flutter/material.dart';

class TravelDetailsCard extends StatelessWidget {
  final AllowanceEntry entry;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const TravelDetailsCard({
    super.key,
    required this.entry,
    required this.isExpanded,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final v = entry.values;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: Text(v['employeeName']),
            subtitle: Text(
              v['passportNo'] == null
                  ? 'Pending travel details'
                  : 'Passport: ${v['passportNo']}',
              style: TextStyle(
                color: v['passportNo'] == null ? Colors.red : Colors.green,
              ),
            ),
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
                  _row('Passport Issue Date', v['passportIssueDate']),
                  _row('Passport Expiry Date', v['passportExpiryDate']),
                  _row('Ticket Type', v['ticketType']),
                  _row('Decision Date', v['decisionDate']),
                  _row('Decision Number', v['decisionNumber']),
                  _row('Mission Number', v['missionNumber']),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onEdit,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(String label, String? value) {
    return Text('$label: ${value ?? '-'}');
  }
}
