part of '../view.dart';

class TravelDetailsForm extends StatefulWidget {
  final Map<String, dynamic> initialValues;
  final void Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onCancel;

  const TravelDetailsForm({
    super.key,
    required this.initialValues,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<TravelDetailsForm> createState() => _TravelDetailsFormState();
}

class _TravelDetailsFormState extends State<TravelDetailsForm> {
  late TextEditingController passportNoCtrl;
  late TextEditingController passportIssueDateCtrl;
  late TextEditingController passportExpiryDateCtrl;
  late TextEditingController ticketTypeCtrl;
  late TextEditingController decisionNoCtrl;
  late TextEditingController decisionDateCtrl;

  @override
  void initState() {
    super.initState();

    passportNoCtrl = TextEditingController(
      text: widget.initialValues['passportNo']?.toString() ?? '',
    );

    passportIssueDateCtrl = TextEditingController(
      text: widget.initialValues['passportIssueDate']?.toString() ?? '',
    );

    passportExpiryDateCtrl = TextEditingController(
      text: widget.initialValues['passportExpiryDate']?.toString() ?? '',
    );

    ticketTypeCtrl = TextEditingController(
      text: widget.initialValues['ticketType']?.toString() ?? '',
    );

    decisionNoCtrl = TextEditingController(
      text: widget.initialValues['decisionNumber']?.toString() ?? '',
    );
    decisionDateCtrl = TextEditingController(
      text: widget.initialValues['decisionDate']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    passportNoCtrl.dispose();
    passportIssueDateCtrl.dispose();
    passportExpiryDateCtrl.dispose();
    ticketTypeCtrl.dispose();
    decisionNoCtrl.dispose();
    decisionDateCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final v = widget.initialValues;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== READ ONLY INFO =====
            _infoRow('Employee Name', v['employeeName']),
            _infoRow('Department', v['department']),
            _infoRow('Mission Number', v['missionNumber']),
            _infoRow('Departure Date', v['departureDate']),
            _infoRow('Return Date', v['returnDate']),

            const Divider(height: 32),

            /// ===== EDITABLE FIELDS =====
            KTextField(
              fieldHeadingText: 'Passport No *',
              controller: passportNoCtrl,
            ),

            const SizedBox(height: 16),

            /// ===== PASSPORT ISSUE DATE =====
            KTextField(
              fieldHeadingText: 'Passport Issue Date *',
              controller: passportIssueDateCtrl,
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                final pickedDate = await KAppX.extendedRouter.showKDatePicker(
                  context: context,
                  initialDate: passportIssueDateCtrl.text.isNotEmpty
                      ? DateTime.parse(passportIssueDateCtrl.text)
                      : DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  passportIssueDateCtrl.text = formatDateYYYYMMDD(pickedDate);
                }
              },
            ),

            const SizedBox(height: 16),

            /// ===== PASSPORT EXPIRY DATE =====
            KTextField(
              fieldHeadingText: 'Passport Expiry Date *',
              controller: passportExpiryDateCtrl,
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                final pickedDate = await KAppX.extendedRouter.showKDatePicker(
                  context: context,
                  initialDate: passportExpiryDateCtrl.text.isNotEmpty
                      ? DateTime.parse(passportExpiryDateCtrl.text)
                      : DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  passportExpiryDateCtrl.text = formatDateYYYYMMDD(pickedDate);
                }
              },
            ),

            const SizedBox(height: 16),

            /// ===== DECISION DATE =====
            KTextField(
              fieldHeadingText: 'Decision Date *',
              controller: decisionDateCtrl,
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                final pickedDate = await KAppX.extendedRouter.showKDatePicker(
                  context: context,
                  initialDate: decisionDateCtrl.text.isNotEmpty
                      ? DateTime.parse(decisionDateCtrl.text)
                      : DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  decisionDateCtrl.text = formatDateYYYYMMDD(pickedDate);
                }
              },
            ),

            KTextField(
              fieldHeadingText: 'Ticket Type (Optional)',
              controller: ticketTypeCtrl,
            ),

            const SizedBox(height: 16),

            KTextField(
              fieldHeadingText: 'Decision Number (Optional)',
              controller: decisionNoCtrl,
            ),

            const SizedBox(height: 20),

            /// ===== ACTIONS =====
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _onSave, child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ===== READ ONLY ROW =====
  Widget _infoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label: ${value ?? '-'}',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  /// ===== SAVE =====
  void _onSave() {
    if (passportNoCtrl.text.isEmpty) return;
    if (passportIssueDateCtrl.text.isEmpty) return;
    if (passportExpiryDateCtrl.text.isEmpty) return;
    if (decisionDateCtrl.text.isEmpty) return; // 🔴 REQUIRED

    widget.onSubmit({
      'passportNo': passportNoCtrl.text,
      'passportIssueDate': passportIssueDateCtrl.text,
      'passportExpiryDate': passportExpiryDateCtrl.text,
      'ticketType': ticketTypeCtrl.text,
      'decisionNumber': decisionNoCtrl.text,
      'decisionDate': decisionDateCtrl.text, // ✅ ADDED
    });
  }
}

String formatDateYYYYMMDD(DateTime date) {
  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}
