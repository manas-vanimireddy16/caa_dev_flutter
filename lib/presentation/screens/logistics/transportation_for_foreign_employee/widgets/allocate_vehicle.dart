part of '../view.dart';

class AllocateVehicleDialogWidget extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;
  final Service service;
  final SubService subService;

  const AllocateVehicleDialogWidget({
    super.key,
    this.onSuccess,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AllocateVehicleDialogWidget> createState() =>
      _AllocateVehicleDialogWidgetState();
}

class _AllocateVehicleDialogWidgetState
    extends ConsumerState<AllocateVehicleDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController returnTimeController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  String? selectedVehicleNumber;
  String? fuelCard;

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
    driverNameController.dispose();
    returnDateController.dispose();
    returnTimeController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    final payload = {
      "driver_name": driverNameController.text.trim().isEmpty
          ? null
          : driverNameController.text.trim(),
      "vehicle_number": selectedVehicleNumber,
      "fuel_card": fuelCard,
      "expected_vehicle_return_time": convertTo24Hour(
        returnTimeController.text,
      ),
      "expected_return_date": convertDate(returnDateController.text),
    };

    controller.onVehicleAllocate(payload);
  }

  Widget _mandatoryLabel(String text, DashboardL10n l10n) {
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

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final state = ref.watch(_vsProvider(_providerArgs));

    final vehicleNumbers = state.vehicle
        .map((e) => e['vehicleNumber'] ?? '')
        .toList();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: driverNameController,
              decoration: InputDecoration(
                labelText: l10n.transportDriverName,
                hintText: l10n.transportDriverNameHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedVehicleNumber,
              decoration: InputDecoration(
                label: _mandatoryLabel(l10n.transportVehicleNumber, l10n),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: vehicleNumbers.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() => selectedVehicleNumber = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.transportSelectVehicleNumber;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _mandatoryLabel(l10n.transportFuelCard, l10n),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'Yes',
                      groupValue: fuelCard,
                      onChanged: (value) {
                        setState(() => fuelCard = value);
                      },
                    ),
                    Text(l10n.transportYes),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Radio<String>(
                      value: 'No',
                      groupValue: fuelCard,
                      onChanged: (value) {
                        setState(() => fuelCard = value);
                      },
                    ),
                    Text(l10n.transportNo),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: returnDateController,
              readOnly: true,
              onTap: pickDate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.transportSelectReturnDate;
                }
                return null;
              },
              decoration: InputDecoration(
                label: _mandatoryLabel(l10n.transportVehicleReturnDate, l10n),
                hintText: 'dd-mm-yyyy',
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: returnTimeController,
              readOnly: true,
              onTap: pickTime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.transportSelectReturnTime;
                }
                return null;
              },
              decoration: InputDecoration(
                label: _mandatoryLabel(l10n.transportVehicleReturnTime, l10n),
                hintText: 'hh:mm aa',
                suffixIcon: const Icon(Icons.access_time_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      l10n.transportFormCancel,
                      style: const TextStyle(
                        color: Color(0xFF0D652D),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 35,
                  child: ElevatedButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D652D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    label: Text(
                      l10n.transportFormSubmit,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

String convertDate(String date) {
  final parsed = DateFormat('dd-MM-yyyy').parse(date);
  return DateFormat('yyyy-MM-dd').format(parsed);
}

String convertTo24Hour(String time) {
  final parsed = DateFormat('hh:mm a').parse(time);
  return DateFormat('HH:mm:ss').format(parsed);
}
