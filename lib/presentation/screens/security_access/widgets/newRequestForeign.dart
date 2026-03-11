// part of '../foreign_request/view.dart';

// @RoutePage()
// class LogisticsPassengersVehicleRequestScreen extends ConsumerStatefulWidget {
//   // final List<KDropdownItem<String>> serviceTypeOptions;
//   const LogisticsPassengersVehicleRequestScreen({
//     super.key,
//     //required this.serviceTypeOptions,
//   });

//   @override
//   ConsumerState<LogisticsPassengersVehicleRequestScreen> createState() =>
//       _LogisticsPassengersVehicleRequestScreenState();
// }

// class _LogisticsPassengersVehicleRequestScreenState
//     extends ConsumerState<LogisticsPassengersVehicleRequestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(_vsProvider);
//     final stateController = ref.read(_vsProvider.notifier);

//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return KScaffold(
//       appBar: KAppBar(title: const Text('New Event Support Request')),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
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

//               KDropdownField<int>(
//                 hintText: 'select ',
//                 fieldHeadingText: 'No of Passengers *',
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),

//                 items: [
//                   KDropdownItem(value: 1, child: const Text("1")),
//                   KDropdownItem(value: 2, child: Text("2")),
//                   KDropdownItem(value: 3, child: Text("3")),
//                   KDropdownItem(value: 4, child: const Text("4")),
//                   KDropdownItem(value: 5, child: Text("5")),
//                   KDropdownItem(value: 6, child: Text("6")),
//                 ],
//                 onChanged: (value) {
//                   stateController.setPassengerNo(value ?? 0);
//                 },
//               ),
//               KTextField(
//                 fieldHeadingText: 'Contact Number *',
//                 controller: stateController.contactNumberController,
//                 hintText: "Enter Contact Number ",
//               ),

//               16.toVerticalSizedBox,
//               const PassengerComponent(),

//               16.toVerticalSizedBox,

//               // ElevatedButton(
//               //   onPressed: () {
//               //     if (stateController.validatePassengers(context)) {
//               //       final data = stateController.getPassengersAsModels();
//               //       debugPrint(
//               //         "Passengers: ${data.map((e) => e.toJson()).toList()}",
//               //       );
//               //       ScaffoldMessenger.of(context).showSnackBar(
//               //         const SnackBar(
//               //           content: Text("Passengers validated and ready!"),
//               //         ),
//               //       );
//               //     }
//               //   },
//               //   child: const Text("Submit Request"),
//               // ),
//               KDropdownField<String>(
//                 fieldHeading: Text('Purpose of Travel *'),
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(
//                     value: "Site Visit",
//                     child: const Text("Site Visit"),
//                   ),
//                   KDropdownItem(
//                     value: "Airport Duty",
//                     child: Text("Airport Duty"),
//                   ),
//                   KDropdownItem(
//                     value: "Official Meeting",
//                     child: Text("Official Meeting"),
//                   ),
//                   KDropdownItem(value: "Others", child: Text("Others")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.setPurposeOfTravel(value ?? '');
//                 },
//               ),
//               KDropdownField<String>(
//                 fieldHeading: Text('Request Type *'),
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(
//                     value: "Apartment",
//                     child: const Text("Apartment"),
//                   ),
//                   KDropdownItem(value: "Villa", child: Text("Villa")),
//                   KDropdownItem(
//                     value: "Shared Unit",
//                     child: Text("Shared Unit"),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.setRequestType(value ?? '');
//                 },
//               ),

//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Employee Id/ Passport Number(Optional)',
//                 controller: stateController.employeeIdPassportController,
//                 hintText: "Enter Employee Id ",
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Origin City (Optional)',
//                 controller: stateController.originCityController,
//                 hintText: "Enter Origin City ",
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Destination City/Location *',
//                 controller: stateController.destinationCityController,
//                 hintText: "Enter Destination City/Location ",
//               ),
//               12.toVerticalSizedBox,
//               KDropdownField<String>(
//                 fieldHeading: Text('Vehicle Required Location *'),
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(
//                     value: "Inside Muscat",
//                     child: const Text("Inside Muscat"),
//                   ),
//                   KDropdownItem(
//                     value: "Outside Muscat",
//                     child: Text("Outside Muscat"),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.setVehicleRequiredLocation(value ?? '');
//                 },
//               ),

//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: "Arrival/Departure Date *",
//                 hintText: state.arrivalDepartureDate,
//                 readOnly: true,
//                 onTap: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2100),
//                   );

//                   if (date != null) {
//                     final time = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                     );

//                     if (time != null) {
//                       final combinedDateTime = DateTime(
//                         date.year,
//                         date.month,
//                         date.day,
//                         time.hour,
//                         time.minute,
//                       );

//                       // 1️⃣ Display format: for UI
//                       final formattedForUI =
//                           "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

//                       // 2️⃣ ISO format: for API
//                       final formattedForAPI = combinedDateTime
//                           .toUtc()
//                           .toIso8601String(); // 👈 "2025-10-29T09:30:00Z"

//                       // Update both in state
//                       stateController.setArrivalDepartureDate(formattedForUI);
//                       stateController.setArrivalDepartureDateISO(
//                         formattedForAPI,
//                       );
//                     }
//                   }
//                 },
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: "Arrival/Departure Time ",
//                 hintText: state.arrivalDepartureTime,
//                 readOnly: true,
//                 onTap: () async {
//                   // First open the time picker
//                   final time = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.now(),
//                     builder: (context, child) {
//                       // Optional: Apply dark/light theme consistency
//                       return MediaQuery(
//                         data: MediaQuery.of(
//                           context,
//                         ).copyWith(alwaysUse24HourFormat: false),
//                         child: child!,
//                       );
//                     },
//                   );

//                   if (time != null) {
//                     // Format it to a readable string, e.g. 3:45 PM
//                     final formattedTime = time.format(context);

//                     // Call your controller method to save this time
//                     stateController.setArrivalDepartureTime(formattedTime);
//                   }
//                 },
//               ),

//               12.toVerticalSizedBox,

//               /// Problem
//               KTextField(
//                 fieldHeadingText: 'Special Instructions *',
//                 controller: stateController.specialInstructionsController,
//                 hintText: "Enter Intructions ",
//                 maxLines: 2,
//               ),
//               12.toVerticalSizedBox,
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: stateController.pickFile,
//                       icon: const Icon(Icons.upload_file),
//                       label: const Text("Upload Files"),
//                     ),
//                     const SizedBox(height: 8),
//                     ...state.attachments.map((file) {
//                       return ListTile(
//                         title: Text(file["file_name"] ?? ''),
//                         subtitle: Text(file["file_type"] ?? ''),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => stateController.removeFile(file),
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ),

//               /// Extension Number
//               ///
//               ///

//               /// Submit Button
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
//                     // final data = {
//                     //   "s": controllers.personNameController.text,
//                     //   "contactNumber": controllers.contactNumberController.text,
//                     //   "department": controllers.departmentController.text,
//                     //   "problem": controllers.problemController.text,
//                     //   "description": controllers.descriptionController.text,
//                     //   "extension": controllers.extensionNumberController.text,
//                     //   // add service type & requestFor from providers
//                     // };
//                     // debugPrint("Submitting: $data");
//                     stateController.vehicleRequest();
//                   },
//                   icon: const Icon(Icons.send),
//                   label: const Text("Submit"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
