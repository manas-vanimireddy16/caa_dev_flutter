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

  final TextEditingController returnDateController = TextEditingController();

  final TextEditingController returnTimeController = TextEditingController();

  final TextEditingController commentsController = TextEditingController();

  final TextEditingController reasonController = TextEditingController();

  String? vehicleCondition;

  bool isSubmitting = false;

  final List<String> conditions = ['Yes', 'No'];

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  void dispose() {
    returnDateController.dispose();
    returnTimeController.dispose();
    commentsController.dispose();
    reasonController.dispose();
    super.dispose();
  }

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

  String convertDate(String date) {
    final parsed = DateFormat('dd-MM-yyyy').parse(date);
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  String convertTo24Hour(String time) {
    final parsed = DateFormat('hh:mm a').parse(time);
    return DateFormat('HH:mm:ss').format(parsed);
  }

  Widget mandatoryLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (isSubmitting) return;

    setState(() {
      isSubmitting = true;
    });

    try {
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
        "request_type": "foreign",
        "actual_vehicle_return_time": convertTo24Hour(
          returnTimeController.text,
        ),
        "actual_return_date": convertDate(returnDateController.text),
        "vehicle_condition": vehicleCondition?.toLowerCase(),
        "reason": vehicleCondition == "No"
            ? reasonController.text.trim()
            : null,
      };

      debugPrint("PAYLOAD => $payload");

      /// API CALL
      await controller.onApprove(payload);

      /// CLOSE FAST AFTER SUCCESS
      if (mounted) {
        Navigator.pop(context);

        widget.onSuccess?.call();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));

    final status = state.requestDetails.request?.status?.toLowerCase();

    final isClosed = status == 'closed';

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
              onTap: isSubmitting ? null : pickDate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select return date';
                }
                return null;
              },
              decoration: InputDecoration(
                label: mandatoryLabel('Vehicle Return Date'),
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
            ),

            const SizedBox(height: 20),

            /// RETURN TIME
            TextFormField(
              controller: returnTimeController,
              readOnly: true,
              onTap: isSubmitting ? null : pickTime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select return time';
                }
                return null;
              },
              decoration: InputDecoration(
                label: mandatoryLabel('Vehicle Return Time'),
                suffixIcon: const Icon(Icons.access_time_outlined),
              ),
            ),

            const SizedBox(height: 20),

            /// VEHICLE CONDITION
            DropdownButtonFormField<String>(
              value: vehicleCondition,
              decoration: InputDecoration(
                label: mandatoryLabel('Vehicle Condition'),
              ),
              items: conditions.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: isSubmitting
                  ? null
                  : (value) {
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
                enabled: !isSubmitting,
                validator: (value) {
                  if (vehicleCondition == "No" &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter reason';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: mandatoryLabel('Reason'),
                  hintText: 'Enter reason',
                ),
              ),
            ],

            const SizedBox(height: 20),

            /// COMMENTS
            TextFormField(
              controller: commentsController,
              maxLines: 5,
              enabled: !isSubmitting,
              decoration: const InputDecoration(
                labelText: 'Comments (Optional)',
                hintText: 'Add your comments',
              ),
            ),

            const SizedBox(height: 30),

            /// BUTTONS
            if (!isClosed)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// CANCEL
                  OutlinedButton.icon(
                    onPressed: isSubmitting
                        ? null
                        : () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('CANCEL'),
                  ),

                  const SizedBox(width: 12),

                  /// SUBMIT
                  ElevatedButton(
                    onPressed: isSubmitting ? null : onSubmit,
                    child: isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_outline, size: 18),
                              SizedBox(width: 8),
                              Text('SUBMIT'),
                            ],
                          ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
