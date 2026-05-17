// part of '../view.dart';

// class AllocateVehicleDialogWidget extends ConsumerStatefulWidget {
//   final VoidCallback? onSuccess;
//   final Service service;
//   final SubService subService;

//   const AllocateVehicleDialogWidget({
//     super.key,
//     this.onSuccess,
//     required this.service,
//     required this.subService,
//   });

//   @override
//   ConsumerState<AllocateVehicleDialogWidget> createState() =>
//       _AllocateVehicleDialogWidgetState();
// }

// class _AllocateVehicleDialogWidgetState
//     extends ConsumerState<AllocateVehicleDialogWidget> {
//   final _formKey = GlobalKey<FormState>();
//   late _VSControllerParams _providerArgs;

//   @override
//   void initState() {
//     super.initState();

//     /// ✅ Create proper provider params object
//     _providerArgs = _VSControllerParams(
//       service: widget.service,
//       subService: widget.subService,
//     );
//   }

//   final TextEditingController driverNameController = TextEditingController();

//   final TextEditingController returnDateController = TextEditingController();

//   final TextEditingController returnTimeController = TextEditingController();

//   final TextEditingController commentsController = TextEditingController();

//   String? selectedVehicleNumber;
//   String? fuelCard;

//   Future<void> pickDate() async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//       initialDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       returnDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
//     }
//   }

//   Future<void> pickTime() async {
//     final pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (pickedTime != null) {
//       final now = DateTime.now();

//       final dateTime = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );

//       returnTimeController.text = DateFormat('hh:mm a').format(dateTime);
//     }
//   }

//   @override
//   void dispose() {
//     driverNameController.dispose();
//     returnDateController.dispose();
//     returnTimeController.dispose();
//     commentsController.dispose();
//     super.dispose();
//   }

//   void onSubmit() {
//     if (!_formKey.currentState!.validate()) return;
//     final controller = ref.read(_vsProvider(_providerArgs).notifier);

//     final payload = {
//       "driver_name": driverNameController.text.trim().isEmpty
//           ? null
//           : driverNameController.text.trim(),

//       "vehicle_number": selectedVehicleNumber,

//       "fuel_card": fuelCard,

//       "expected_vehicle_return_time": convertTo24Hour(
//         returnTimeController.text,
//       ),

//       "expected_return_date": convertDate(returnDateController.text),
//     };

//     controller.onVehicleAllocate(payload);

//     // widget.onSuccess?.call();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(_vsProvider(_providerArgs));

//     List<String> vehicleNumbers = state.vehicle
//         .map((e) => e['vehicleNumber'] ?? '')
//         .toList();
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             /// DRIVER NAME
//             TextFormField(
//               controller: driverNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Driver Name',
//                 hintText: 'Enter Driver Name',
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// VEHICLE NUMBER
//             DropdownButtonFormField<String>(
//               value: selectedVehicleNumber,
//               decoration: const InputDecoration(labelText: 'Vehicle Number *'),
//               items: vehicleNumbers.map((e) {
//                 return DropdownMenuItem(value: e, child: Text(e));
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedVehicleNumber = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select vehicle number';
//                 }
//                 return null;
//               },
//             ),

//             const SizedBox(height: 20),

//             /// FUEL CARD
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Fuel Card *',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Row(
//                   children: [
//                     Row(
//                       children: [
//                         Radio<String>(
//                           value: 'Yes',
//                           groupValue: fuelCard,
//                           onChanged: (value) {
//                             setState(() {
//                               fuelCard = value;
//                             });
//                           },
//                         ),
//                         const Text('Yes'),
//                       ],
//                     ),

//                     const SizedBox(width: 20),

//                     Row(
//                       children: [
//                         Radio<String>(
//                           value: 'No',
//                           groupValue: fuelCard,
//                           onChanged: (value) {
//                             setState(() {
//                               fuelCard = value;
//                             });
//                           },
//                         ),
//                         const Text('No'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             /// RETURN DATE
//             TextFormField(
//               controller: returnDateController,
//               readOnly: true,
//               onTap: pickDate,
//               decoration: const InputDecoration(
//                 labelText: 'Vehicle Return Date *',
//                 hintText: 'dd-mm-yyyy',
//                 suffixIcon: Icon(Icons.calendar_today_outlined),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select return date';
//                 }
//                 return null;
//               },
//             ),

//             const SizedBox(height: 20),

//             /// RETURN TIME
//             TextFormField(
//               controller: returnTimeController,
//               readOnly: true,
//               onTap: pickTime,
//               decoration: const InputDecoration(
//                 labelText: 'Vehicle Return Time *',
//                 hintText: 'hh:mm aa',
//                 suffixIcon: Icon(Icons.access_time_outlined),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select return time';
//                 }
//                 return null;
//               },
//             ),

//             const SizedBox(height: 30),

//             /// BUTTONS
//             Wrap(
//               children: [
//                 OutlinedButton.icon(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.close, size: 18),
//                   label: const Text('CANCEL'),
//                 ),

//                 const SizedBox(width: 12),

//                 ElevatedButton.icon(
//                   onPressed: onSubmit,
//                   icon: const Icon(Icons.check_circle_outline, size: 18),
//                   label: const Text('SUBMIT'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// String convertDate(String date) {
//   final parsed = DateFormat('dd-MM-yyyy').parse(date);
//   return DateFormat('yyyy-MM-dd').format(parsed);
// }

// String convertTo24Hour(String time) {
//   final parsed = DateFormat('hh:mm a').parse(time);
//   return DateFormat('HH:mm:ss').format(parsed);
// }

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

  final TextEditingController driverNameController = TextEditingController();

  final TextEditingController returnDateController = TextEditingController();

  final TextEditingController returnTimeController = TextEditingController();

  final TextEditingController commentsController = TextEditingController();

  String? selectedVehicleNumber;
  String? fuelCard;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
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

    if (fuelCard == null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       DashboardL10n.of(context).transportSelectFuelCard,
      //     ),
      //   ),
      // );
      return;
    }

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

  Widget _labelText(String text, {bool isMandatory = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF4B5563),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        children: [
          if (isMandatory)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF0D652D)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Driver Name
              _labelText(l10n.transportDriverName),

              const SizedBox(height: 8),

              TextFormField(
                controller: driverNameController,
                decoration: _inputDecoration(
                  hintText: l10n.transportDriverNameHint,
                ),
              ),

              const SizedBox(height: 20),

              /// Vehicle Number
              _labelText(l10n.transportVehicleNumber, isMandatory: true),

              const SizedBox(height: 8),

              FormField<String>(
                validator: (value) {
                  if (selectedVehicleNumber == null ||
                      selectedVehicleNumber!.isEmpty) {
                    return l10n.transportSelectVehicleNumber;
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
                          color: Colors.white,
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
                            value: selectedVehicleNumber,
                            hint: Text(
                              l10n.transportSelectVehicleNumber,
                              style: const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
                              ),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            items: vehicleNumbers.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(e, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedVehicleNumber = value;
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

              const SizedBox(height: 20),

              /// Fuel Card
              _labelText(l10n.transportFuelCard, isMandatory: true),

              const SizedBox(height: 12),

              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: fuelCard,
                        activeColor: const Color(0xFF0D652D),
                        onChanged: (value) {
                          setState(() {
                            fuelCard = value;
                          });
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
                        activeColor: const Color(0xFF0D652D),
                        onChanged: (value) {
                          setState(() {
                            fuelCard = value;
                          });
                        },
                      ),
                      Text(l10n.transportNo),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Return Date
              _labelText(l10n.transportVehicleReturnDate, isMandatory: true),

              const SizedBox(height: 8),

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
                decoration: _inputDecoration(
                  hintText: 'dd-mm-yyyy',
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Return Time
              _labelText(l10n.transportVehicleReturnTime, isMandatory: true),

              const SizedBox(height: 8),

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
                decoration: _inputDecoration(
                  hintText: 'hh:mm aa',
                  suffixIcon: const Icon(Icons.access_time_outlined, size: 22),
                ),
              ),

              const SizedBox(height: 30),

              /// Buttons
              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                          textAlign: TextAlign.center,
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
                      height: 36,
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D652D),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          l10n.transportFormSubmit,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
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

String convertDate(String date) {
  final parsed = DateFormat('dd-MM-yyyy').parse(date);

  return DateFormat('yyyy-MM-dd').format(parsed);
}

String convertTo24Hour(String time) {
  final parsed = DateFormat('hh:mm a').parse(time);

  return DateFormat('HH:mm:ss').format(parsed);
}
