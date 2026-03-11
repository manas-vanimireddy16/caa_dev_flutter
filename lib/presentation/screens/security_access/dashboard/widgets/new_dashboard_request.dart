// part of '../view.dart';

// @RoutePage()
// class AccessCardDashboardRequestScreen extends ConsumerStatefulWidget {
//   // final List<KDropdownItem<String>> serviceTypeOptions;
//   const AccessCardDashboardRequestScreen({
//     super.key,
//     //required this.serviceTypeOptions,
//   });

//   @override
//   ConsumerState<AccessCardDashboardRequestScreen> createState() =>
//       _AccessCardDashboardRequestScreenState();
// }

// class _AccessCardDashboardRequestScreenState
//     extends ConsumerState<AccessCardDashboardRequestScreen> {
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
//                 options: ['Self', 'Behalf of'],
//                 selectedValue: state.selectedRole,
//                 onChanged: (value) {
//                   stateController.onSelectedRole(value);
//                 },
//               ),

//               if (state.selectedRole == 'Behalf of') ...[
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: SizedBox(
//                     width: 300, // 🔹 adjust as needed
//                     child: CustomRadioGroup(
//                       label: 'Requested By',
//                       options: ['Omanis & Residents', 'Foreigners & Outsiders'],
//                       selectedValue: state.selectedRole,
//                       onChanged: (value) {
//                         stateController.setRequestedBy(value);
//                       },
//                     ),
//                   ),
//                 ),
//               ],

//               16.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Person Name *',
//                 controller: stateController.personNameController,
//                 hintText: "Enter Request Title ",
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Contact Number *',
//                 controller: stateController.contactNumberController,
//                 hintText: "Enter Request Title ",
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Department *',
//                 controller: stateController.departmentController,
//                 hintText: "Enter Request Title ",
//               ),
//               12.toVerticalSizedBox,

//               KDropdownField<String>(
//                 fieldHeading: Text('Request Type *'),
//                 decoration: const InputDecoration(
//                   labelText: "Select *",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: [
//                   KDropdownItem(
//                     value: "new request",
//                     child: Text("New Request"),
//                   ),
//                   KDropdownItem(
//                     value: "existing request",
//                     child: Text("Existing Request"),
//                   ),

//                   KDropdownItem(value: "Others", child: Text("Others")),
//                 ],
//                 onChanged: (value) {
//                   // store service type in state provider if needed
//                   //    stateController.onSelectedVehicleRequiredFor(value ?? '');
//                 },
//               ),

//               KTextField(
//                 fieldHeadingText: 'Email *',
//                 controller: stateController.emailController,
//                 hintText: "Enter Request Title ",
//               ),
//               12.toVerticalSizedBox,
//               KDropdownField<String>(
//                 fieldHeading: Text('Category *'),
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
//                   // stateController.onSelectedVehicleRequiredLocation(
//                   //   value ?? '',
//                   // );
//                 },
//               ),
//               12.toVerticalSizedBox,
//               ...(state.selectedRole == 'Self'
//                   ? [
//                       KTextField(
//                         fieldHeadingText: 'ID Number *',
//                         controller: stateController.employeeIdController,
//                         hintText: "Enter Civil ID/Cards Number",
//                       ),
//                     ]
//                   : [
//                       KTextField(
//                         fieldHeadingText: 'Passport Number *',
//                         controller: stateController.employeeIdController,
//                         hintText: "Enter Civil ID/Cards Number",
//                       ),
//                     ]),

//               12.toVerticalSizedBox,

//               KTextField(
//                 fieldHeadingText: "Date(optional)",
//                 hintText: state.date,
//                 readOnly: true,
//                 onTap: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2100),
//                   );
//                   if (date != null) {
//                     // stateController.onSelectFromDate(
//                     //   "${date.year}-${date.month}-${date.day}",
//                     // );
//                   }
//                 },
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'University/Organisation *',
//                 controller: stateController.uniorOrgcontroller,
//                 hintText: "Enter",
//               ),
//               12.toVerticalSizedBox,
//               KTextField(
//                 fieldHeadingText: 'Reason *',
//                 controller: stateController.reasonController,
//                 hintText: "Enter Reason ",
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
//                       onPressed: () => {}, //stateController.pickFile,
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
//                           onPressed: () =>
//                               {}, //stateController.removeFile(file),
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
//                     // stateController.vehicleRequest();
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
