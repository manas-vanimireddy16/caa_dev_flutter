part of '../view.dart';

@RoutePage()
class HotelReservationNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  const HotelReservationNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<HotelReservationNewRequestScreen> createState() =>
      _HotelReservationNewRequestScreenState();
}

class _HotelReservationNewRequestScreenState
    extends ConsumerState<HotelReservationNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Watch state only if needed
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    return KScaffold(
      backgroundColor: Colors.white,
      // appBar: KAppBar(title: Text('Mission Transfer Request')),

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: 'Mission Transfer Request',
          stepTitles: const [''],
          steps: [controller.hotelReservationFields],

          onSubmit: (values) async {
            await controller.sendHotelReservationRequest(
              widget.serviceId,
              widget.subServiceId,
              values,
            );

            if (context.mounted) {
              context.router.pop();
            }
          },
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final state = ref.watch(_vsProvider);
  //   final stateController = ref.read(_vsProvider.notifier);

  //   final currentTheme = KAppX.globalProvider
  //       .read(KAppX.theme.current)
  //       .themeBox;

  //   return KScaffold(
  //     appBar: KAppBar(title: const Text('New Event Support Request')),
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.all(16),
  //         child: Form(
  //           key: state.formKey, // ✅ ADDED FORM KEY
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Provide details about your New Request",
  //                 style: TextStyle(
  //                   fontSize: currentTheme.fontSizes.s14,
  //                   fontWeight: currentTheme.fontWeights.wBold,
  //                 ),
  //               ),
  //               16.toVerticalSizedBox,

  //               /// ACCOMMODATION
  //               KDropdownField<String>(
  //                 fieldHeading: const Text('Accomodation Type *'),
  //                 value: state.accommodationType.isNotEmpty
  //                     ? state.accommodationType
  //                     : null,
  //                 decoration: const InputDecoration(
  //                   labelText: "Select *",
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 // validator: (value) {
  //                 //   if (value == null || value.isEmpty) {
  //                 //     return "Please select accommodation";
  //                 //   }
  //                 //   return null;
  //                 // },
  //                 items: [
  //                   KDropdownItem(
  //                     value: "Single Room",
  //                     child: Text("Single Room"),
  //                   ),
  //                   KDropdownItem(
  //                     value: "Double Room",
  //                     child: Text("Double Room"),
  //                   ),
  //                   KDropdownItem(value: "Suite", child: Text("Suite")),
  //                 ],
  //                 onChanged: (value) {
  //                   stateController.onSelectedAccomidationType(value ?? '');
  //                 },
  //               ),
  //               12.toVerticalSizedBox,

  //               /// HOTEL NAME
  //               KTextField(
  //                 fieldHeadingText: 'Hotel Name *',
  //                 controller: stateController.hotelNameController,
  //                 hintText: "Enter Hotel Name",
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return "Hotel name is required";
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               12.toVerticalSizedBox,

  //               /// HOTEL PRICE
  //               KTextField(
  //                 fieldHeadingText: 'Hotel Price *',
  //                 controller: stateController.hotelPriceController,
  //                 hintText: "Enter Hotel Price",
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return "Hotel price is required";
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               12.toVerticalSizedBox,

  //               Text(
  //                 "Services and Facilities",
  //                 style: TextStyle(
  //                   fontSize: currentTheme.fontSizes.s14,
  //                   fontWeight: currentTheme.fontWeights.wRegular,
  //                 ),
  //               ),

  //               /// MEALS
  //               CustomCheckboxGroup(
  //                 label: 'Meals',
  //                 options: const ['Breakfast', 'Lunch', 'Dinner'],
  //                 view: const ['Breakfast', 'Lunch', 'Dinner'],
  //                 selectedValues: state.mealPreference,
  //                 onChanged: (value) {
  //                   stateController.onSelectedMealPreference(value);
  //                 },
  //               ),

  //               /// SERVICES
  //               CustomCheckboxGroup(
  //                 label: 'Services',
  //                 options: const ['Laundry', 'Telephone service'],
  //                 view: const ['Laundry', 'Telephone service'],
  //                 selectedValues: state.servicePreference,
  //                 onChanged: (value) {
  //                   stateController.onSelectedServicePreference(value);
  //                 },
  //               ),

  //               /// DATE FIELD
  //               KTextField(
  //                 fieldHeadingText: 'Date *',
  //                 hintText: DateTime.now().toString(),
  //                 readOnly: true,
  //                 // validator: (value) {
  //                 //   if ((value ?? "").isEmpty) {
  //                 //     return "Date is required";
  //                 //   }
  //                 //   return null;
  //                 // },
  //               ),
  //               12.toVerticalSizedBox,

  //               /// NO OF GUESTS
  //               KTextField(
  //                 fieldHeadingText: 'No of Guests *',
  //                 controller: stateController.noOfGuestsController,
  //                 hintText: "Enter no of Guests",
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter number of guests';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               12.toVerticalSizedBox,

  //               /// CHECK-IN DATE
  //               KTextField(
  //                 fieldHeadingText: "Check In Date *",
  //                 hintText: '',
  //                 controller: stateController.checkInController,
  //                 onTap: () async {
  //                   final date = await KAppX.extendedRouter.showKDatePicker(
  //                     initialDate: DateTime.now(),
  //                     firstDate: DateTime.now(),
  //                     lastDate: DateTime(2100),
  //                   );
  //                   if (date != null) {
  //                     stateController.checkInController.text = DateFormat(
  //                       'yyyy-MM-dd',
  //                     ).format(date);
  //                   }
  //                 },
  //                 validator: (value) {
  //                   if (stateController.checkInController.text.isEmpty) {
  //                     return "Please select check-in date";
  //                   }
  //                   return null;
  //                 },
  //               ),

  //               KTextField(
  //                 fieldHeadingText: "Check In Time *",
  //                 hintText: '',
  //                 controller: stateController.checkInTimeController,
  //                 readOnly: true,
  //                 onTap: () async {
  //                   final picked = await KAppX.extendedRouter.showKTimePicker(
  //                     initialTime: TimeOfDay.now(),
  //                   );

  //                   if (picked != null) {
  //                     // Convert TimeOfDay → HH:mm:ss
  //                     final now = DateTime.now();
  //                     final formatted = DateFormat("HH:mm:ss").format(
  //                       DateTime(
  //                         now.year,
  //                         now.month,
  //                         now.day,
  //                         picked.hour,
  //                         picked.minute,
  //                       ),
  //                     );

  //                     stateController.checkInTimeController.text = formatted;
  //                   }
  //                 },
  //                 validator: (value) {
  //                   if (stateController.checkInTimeController.text.isEmpty) {
  //                     return "Please select check-in time";
  //                   }
  //                   return null;
  //                 },
  //               ),

  //               /// CHECK-OUT DATE
  //               KTextField(
  //                 fieldHeadingText: "Check Out Date *",
  //                 hintText: '',
  //                 controller: stateController.checkOutController,
  //                 onTap: () async {
  //                   final date = await KAppX.extendedRouter.showKDatePicker(
  //                     initialDate: DateTime.now(),
  //                     firstDate: DateTime.now(),
  //                     lastDate: DateTime(2100),
  //                   );
  //                   if (date != null) {
  //                     stateController.checkOutController.text = DateFormat(
  //                       'yyyy-MM-dd',
  //                     ).format(date);
  //                   }
  //                 },

  //                 validator: (value) {
  //                   if (stateController.checkOutController.text.isEmpty) {
  //                     return "Please select check-out date";
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               12.toVerticalSizedBox,
  //               KTextField(
  //                 fieldHeadingText: "Check Out Time *",
  //                 hintText: '',
  //                 controller: stateController.checkOutTimeController,
  //                 readOnly: true,
  //                 onTap: () async {
  //                   final picked = await KAppX.extendedRouter.showKTimePicker(
  //                     initialTime: TimeOfDay.now(),
  //                   );

  //                   if (picked != null) {
  //                     // Convert TimeOfDay → HH:mm:ss
  //                     final now = DateTime.now();
  //                     final formatted = DateFormat("HH:mm:ss").format(
  //                       DateTime(
  //                         now.year,
  //                         now.month,
  //                         now.day,
  //                         picked.hour,
  //                         picked.minute,
  //                       ),
  //                     );

  //                     stateController.checkOutTimeController.text = formatted;
  //                   }
  //                 },
  //                 validator: (value) {
  //                   if (stateController.checkOutTimeController.text.isEmpty) {
  //                     return "Please select check-in time";
  //                   }
  //                   return null;
  //                 },
  //               ),

  //               /// DESCRIPTION
  //               KTextField(
  //                 fieldHeadingText: 'Description *',
  //                 controller: stateController.descriptionController,
  //                 hintText: "Enter the Description",
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return "Description is required";
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               12.toVerticalSizedBox,

  //               /// FILE UPLOAD
  //               FileUploadWidget(
  //                 onUploadSuccess: (fileDetails) {
  //                   stateController.onUploadFileSuccess(fileDetails);
  //                 },
  //                 onDelete: (index) {
  //                   stateController.onRemoveFile(index);
  //                 },
  //               ),

  //               /// SUBMIT BUTTON
  //               SizedBox(
  //                 width: double.infinity,
  //                 child: ElevatedButton.icon(
  //                   style: ElevatedButton.styleFrom(
  //                     padding: const EdgeInsets.symmetric(vertical: 14),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     if (state.formKey.currentState!.validate()) {
  //                       stateController.sendHotelReservationRequest();
  //                     }
  //                   },
  //                   icon: const Icon(Icons.send),
  //                   label: const Text("Submit"),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
