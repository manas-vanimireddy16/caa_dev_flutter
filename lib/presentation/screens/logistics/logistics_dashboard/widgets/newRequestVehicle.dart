// part of '../view.dart';

// @RoutePage()
// class LogisticsVehicleRequestScreen extends ConsumerStatefulWidget {
//   // final List<KDropdownItem<String>> serviceTypeOptions;
//   const LogisticsVehicleRequestScreen({
//     super.key,
//     //required this.serviceTypeOptions,
//   });

//   @override
//   ConsumerState<LogisticsVehicleRequestScreen> createState() =>
//       _LogisticsVehicleRequestScreenState();
// }

// class _LogisticsVehicleRequestScreenState
//     extends ConsumerState<LogisticsVehicleRequestScreen> {
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

//               CustomRadioGroup(
//                 label: 'Request for',
//                 options: ['Daily', 'Emergency'],
//                 selectedValue: state.selectedRequest,
//                 onChanged: (value) {
//                   stateController.onSelectedRequest(value);
//                 },
//               ),

//               16.toVerticalSizedBox,

//               KDropdownField<String>(
//                 fieldHeading: Text('Vehicle Required for *'),
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(
//                     value: "Conferences",
//                     child: Text("Conferences"),
//                   ),
//                   KDropdownItem(
//                     value: "Celebrations and Official Meetings",
//                     child: Text("Celebrations and Official Meetings"),
//                   ),

//                   KDropdownItem(value: "Others", child: Text("Others")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.onSelectedVehicleRequiredFor(value ?? '');
//                 },
//               ),
//               KDropdownField<String>(
//                 fieldHeading: Text('Vehicle Required Locaion *'),
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
//                   // KDropdownItem(value: "Facilities", child: Text("Facilities")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.onSelectedVehicleRequiredLocation(
//                     value ?? '',
//                   );
//                 },
//               ),

//               KTextField(
//                 fieldHeadingText: 'Request Title *',
//                 controller: stateController.eventTypeController,
//                 hintText: "Enter Request Title ",
//               ),
//               12.toVerticalSizedBox,
//               KDropdownField<String>(
//                 fieldHeading: Text('Type of Request *'),
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(
//                     value: "New Request",
//                     child: const Text("New Request"),
//                   ),
//                   KDropdownItem(
//                     value: "Extension of Previous Request",
//                     child: Text("Extension of Previous Request"),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.onSelectedPurposeOfTravel(value ?? '');
//                 },
//               ),
//               12.toVerticalSizedBox,
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
//                   stateController.onSelectedPurposeOfTravel(value ?? '');
//                 },
//               ),
//               12.toVerticalSizedBox,

//               /// Service Type (Dropdown instead of textfield)
//               KDropdownField<String>(
//                 fieldHeading: Text('Type of Vehicle Required *'),
//                 decoration: const InputDecoration(
//                   labelText: "Service Type *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(value: "Sedan", child: Text("Sedan")),
//                   KDropdownItem(value: "SUV", child: Text("SUV")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.onSelectedVehicleType(value ?? '');
//                 },
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: "Travel Date *",
//                 hintText: state.fromDate,
//                 readOnly: true,
//                 onTap: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2100),
//                   );
//                   if (date != null) {
//                     stateController.onSelectFromDate(
//                       "${date.year}-${date.month}-${date.day}",
//                     );
//                   }
//                 },
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: "Travel Time (Optional)",
//                 hintText: state.travelTime.isEmpty
//                     ? 'Select Time'
//                     : state.travelTimeForUI, // <--- UI format
//                 readOnly: true,
//                 onTap: () async {
//                   // Step 1: User picks time
//                   final time = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.now(),
//                     builder: (context, child) {
//                       return MediaQuery(
//                         data: MediaQuery.of(
//                           context,
//                         ).copyWith(alwaysUse24HourFormat: false),
//                         child: child!,
//                       );
//                     },
//                   );

//                   if (time != null) {
//                     // Step 2: Convert TimeOfDay → DateTime
//                     final now = DateTime.now();
//                     final dateTime = DateTime(
//                       now.year,
//                       now.month,
//                       now.day,
//                       time.hour,
//                       time.minute,
//                     );

//                     // Step 3: Convert to backend format "HH:mm:ss"
//                     final backendFormat = DateFormat(
//                       'HH:mm:ss',
//                     ).format(dateTime);

//                     // Step 4: Convert to UI format "h:mm a"
//                     final uiFormat = DateFormat('h:mm a').format(dateTime);

//                     // Step 5: Save backend format for API
//                     stateController.onSelectTravelTime(backendFormat);

//                     // Step 6: Save UI format for display
//                     stateController.onSelectTravelTimeUI(uiFormat);
//                   }
//                 },
//               ),
//               // 12.toVerticalSizedBox,
//               12.toVerticalSizedBox,
//               KDropdownField<int>(
//                 fieldHeading: Text('Expected Duration of use/Days *'),
//                 decoration: const InputDecoration(
//                   labelText: "Service Type *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(value: 1, child: Text("1 Day")),
//                   KDropdownItem(value: 2, child: Text("2 Days")),
//                   KDropdownItem(value: 3, child: Text("3 Days")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.onSelectedExpectedDaysInTravel(value ?? 0);
//                 },
//               ),

//               12.toVerticalSizedBox,
//               KDropdownField<int>(
//                 fieldHeading: Text('Expected Duration of use/Hours *'),
//                 decoration: const InputDecoration(
//                   labelText: "Service Type *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(value: 1, child: const Text("1 Hour")),
//                   KDropdownItem(value: 2, child: Text("2 Hours")),
//                   KDropdownItem(value: 3, child: Text("3 Hours")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   stateController.onSelectedExpectedHoursInTravel(value ?? 0);
//                 },
//               ),

//               /// Problem
//               // KTextField(
//               //   fieldHeadingText: 'Description *',
//               //   controller: stateController.contactNumberController,
//               //   hintText: "Enter Description ",
//               //   maxLines: 2,
//               // ),
//               12.toVerticalSizedBox,

//               /// Description
//               KTextField(
//                 fieldHeadingText: 'Description *',
//                 controller: stateController.descriptionController,
//                 hintText: "",
//                 maxLines: 3,
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
//                     stateController.vehicleRequest();
//                     // if (stateController.validatePassengers(context)) {
//                     //   final payload = {
//                     //     "req_user_department_id": "",
//                     //     "req_user_section_id": "",
//                     //     "service_id": "",
//                     //     "sub_service_id": "",
//                     //     "user_id": "",
//                     //     "request_type": state.selectedRole,
//                     //     "vehicle_required_for": state.vehicleRequiredfor,
//                     //     "vehicle_required_location":
//                     //         state.vehicleRequiredLocation,
//                     //     "title": stateController.eventTypeController.text,
//                     //     "purpose_of_travel": state.purposeofTravelDaily,
//                     //     "type_of_vehicle_required": state.vehicleTypeDaily,
//                     //     "date_of_travel": state.fromDate ?? "",
//                     //     "time_of_travel": state.travelTime ?? "",
//                     //     "exp_duration_of_use_hrs": state.expectedHoursinTravel,
//                     //     "exp_duration_of_use_days": state.expectedDaysinTravel,
//                     //     "description":
//                     //         stateController.contactNumberController.text,
//                     //     "reason_for_request":
//                     //         stateController.reasonController.text,
//                     //     "passengers": stateController
//                     //         .getPassengersAsModels()
//                     //         .map((e) => e.toJson())
//                     //         .toList(),
//                     //     "attachments": [
//                     //       {"file_name": "", "url": ""},
//                     //     ],
//                     //   };

//                     //   // debugPrint("🚀 Final Payload: ${jsonEncode(payload)}");

//                     //   // TODO: Send payload to API here
//                     // }
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
