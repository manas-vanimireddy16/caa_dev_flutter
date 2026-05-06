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

    /// ✅ Create proper provider params object
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

  final List<String> vehicleNumbers = ['1./88', '10./88', '108/88', '109/88'];

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

    // widget.onSuccess?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// DRIVER NAME
            TextFormField(
              controller: driverNameController,
              decoration: const InputDecoration(
                labelText: 'Driver Name',
                hintText: 'Enter Driver Name',
              ),
            ),

            const SizedBox(height: 20),

            /// VEHICLE NUMBER
            DropdownButtonFormField<String>(
              value: selectedVehicleNumber,
              decoration: const InputDecoration(labelText: 'Vehicle Number *'),
              items: vehicleNumbers.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedVehicleNumber = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select vehicle number';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            /// FUEL CARD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fuel Card *',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Yes',
                          groupValue: fuelCard,
                          onChanged: (value) {
                            setState(() {
                              fuelCard = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                      ],
                    ),

                    const SizedBox(width: 20),

                    Row(
                      children: [
                        Radio<String>(
                          value: 'No',
                          groupValue: fuelCard,
                          onChanged: (value) {
                            setState(() {
                              fuelCard = value;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// RETURN DATE
            TextFormField(
              controller: returnDateController,
              readOnly: true,
              onTap: pickDate,
              decoration: const InputDecoration(
                labelText: 'Vehicle Return Date *',
                hintText: 'dd-mm-yyyy',
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select return date';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            /// RETURN TIME
            TextFormField(
              controller: returnTimeController,
              readOnly: true,
              onTap: pickTime,
              decoration: const InputDecoration(
                labelText: 'Vehicle Return Time *',
                hintText: 'hh:mm aa',
                suffixIcon: Icon(Icons.access_time_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select return time';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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

String convertDate(String date) {
  final parsed = DateFormat('dd-MM-yyyy').parse(date);
  return DateFormat('yyyy-MM-dd').format(parsed);
}

String convertTo24Hour(String time) {
  final parsed = DateFormat('hh:mm a').parse(time);
  return DateFormat('HH:mm:ss').format(parsed);
}
