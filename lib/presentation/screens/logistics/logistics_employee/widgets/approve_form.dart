part of '../view.dart';

class ApproveRequestDialogWidget extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;
  final Service service;
  final SubService subService;

  const ApproveRequestDialogWidget({
    super.key,
    this.onSuccess,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<ApproveRequestDialogWidget> createState() =>
      _ApproveRequestDialogWidgetState();
}

class _ApproveRequestDialogWidgetState
    extends ConsumerState<ApproveRequestDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create proper provider params object
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  final TextEditingController returnDateController = TextEditingController();

  final TextEditingController returnTimeController = TextEditingController();

  final TextEditingController commentsController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  String? vehicleCondition;

  final List<String> conditions = ['Yes', 'No'];

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      returnDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  Future<void> pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();

      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      returnTimeController.text = DateFormat('hh:mm a').format(dateTime);
    }
  }

  @override
  void dispose() {
    returnDateController.dispose();
    returnTimeController.dispose();
    commentsController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.read(_vsProvider(_providerArgs));
    final active = controller.getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
    );
    final approverId = active?.id;

    final payload = {
      "request_id": state.requestDetails.request?.id,
      "approval_id": approverId,
      "status": "Approved",

      "comment": commentsController.text.trim(),

      "request_type": "domestic",

      "actual_vehicle_return_time": convertTo24Hour(returnTimeController.text),

      "actual_return_date": convertDate(returnDateController.text),

      "vehicle_condition": vehicleCondition?.toLowerCase(),

      "reason": vehicleCondition == "No" ? reasonController.text.trim() : null,
    };

    debugPrint("PAYLOAD => $payload");

    controller.onApprove(payload);

    // widget.onSuccess?.call();
  }

  String convertDate(String date) {
    final parsed = DateFormat('dd-MM-yyyy').parse(date);
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  String convertTo24Hour(String time) {
    final parsed = DateFormat('hh:mm a').parse(time);
    return DateFormat('HH:mm:ss').format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// RETURN DATE
            TextFormField(
              controller: returnDateController,
              readOnly: true,
              onTap: pickDate,
              decoration: const InputDecoration(
                labelText: 'Vehicle Return Date',
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),

            const SizedBox(height: 20),

            /// RETURN TIME
            TextFormField(
              controller: returnTimeController,
              readOnly: true,
              onTap: pickTime,
              decoration: const InputDecoration(
                labelText: 'Vehicle Return Time',
                suffixIcon: Icon(Icons.access_time_outlined),
              ),
            ),

            const SizedBox(height: 20),

            /// VEHICLE CONDITION
            /// VEHICLE CONDITION
            DropdownButtonFormField<String>(
              value: vehicleCondition,
              decoration: const InputDecoration(
                labelText: 'Vehicle Condition *',
              ),
              items: conditions.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  vehicleCondition = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select vehicle condition';
                }
                return null;
              },
            ),

            if (vehicleCondition == "No") ...[
              const SizedBox(height: 20),

              TextFormField(
                controller: reasonController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Reason *',
                  hintText: 'Enter reason',
                ),
                validator: (value) {
                  if (vehicleCondition == "No" &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter reason';
                  }
                  return null;
                },
              ),
            ],

            const SizedBox(height: 20),

            /// COMMENTS
            TextFormField(
              controller: commentsController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Comments (Optional)',
                hintText: 'Add your comments',
              ),
            ),

            const SizedBox(height: 30),

            /// BUTTONS
            Wrap(
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('CANCEL'),
                ),

                const SizedBox(width: 12),

                ElevatedButton.icon(
                  onPressed: onSubmit,
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                  label: const Text('SUBMIT'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
