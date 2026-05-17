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
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w600,
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

    setState(() => isSubmitting = true);

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

      await controller.onApprove(payload);

      if (mounted) {
        Navigator.pop(context);
        widget.onSuccess?.call();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final state = ref.watch(_vsProvider(_providerArgs));

    final status = state.requestDetails.request?.status?.toLowerCase();
    final isClosed = status == 'closed';

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Return Date
              mandatoryLabel(l10n.transportVehicleReturnDate),

              const SizedBox(height: 8),

              TextFormField(
                controller: returnDateController,
                readOnly: true,
                onTap: isSubmitting ? null : pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.transportSelectReturnDate;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'dd-mm-yyyy',
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Return Time
              mandatoryLabel(l10n.transportVehicleReturnTime),

              const SizedBox(height: 8),

              TextFormField(
                controller: returnTimeController,
                readOnly: true,
                onTap: isSubmitting ? null : pickTime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.transportSelectReturnTime;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'hh:mm aa',
                  suffixIcon: const Icon(Icons.access_time_outlined, size: 20),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Vehicle Condition
              mandatoryLabel(l10n.transportVehicleCondition),

              const SizedBox(height: 8),

              FormField<String>(
                validator: (value) {
                  if (vehicleCondition == null || vehicleCondition!.isEmpty) {
                    return l10n.transportSelectVehicleCondition;
                  }
                  return null;
                },
                builder: (FormFieldState<String> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: field.hasError
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: vehicleCondition,
                            hint: Text(
                              l10n.transportSelectVehicleCondition,
                              style: const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
                              ),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            items: [
                              DropdownMenuItem(
                                value: 'Yes',
                                child: Text(l10n.transportYes),
                              ),
                              DropdownMenuItem(
                                value: 'No',
                                child: Text(l10n.transportNo),
                              ),
                            ],
                            onChanged: isSubmitting
                                ? null
                                : (value) {
                                    setState(() {
                                      vehicleCondition = value;
                                    });

                                    field.didChange(value);
                                  },
                          ),
                        ),
                      ),

                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 12),
                          child: Text(
                            field.errorText ?? '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              if (vehicleCondition == 'No') ...[
                const SizedBox(height: 20),

                mandatoryLabel(l10n.transportReason),

                const SizedBox(height: 8),

                TextFormField(
                  controller: reasonController,
                  maxLines: 4,
                  enabled: !isSubmitting,
                  validator: (value) {
                    if (vehicleCondition == 'No' &&
                        (value == null || value.trim().isEmpty)) {
                      return l10n.transportReasonRequired;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: l10n.transportEnterReason,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              /// Comments
              Text(
                l10n.transportCommentsOptional,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: commentsController,
                maxLines: 5,
                enabled: !isSubmitting,
                decoration: InputDecoration(
                  hintText: l10n.transportAddComments,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Buttons
              if (!isClosed)
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: OutlinedButton(
                          onPressed: isSubmitting
                              ? null
                              : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey.shade300),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            l10n.transportFormCancel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: ElevatedButton(
                          onPressed: isSubmitting ? null : onSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D652D),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  l10n.transportFormSubmit,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
