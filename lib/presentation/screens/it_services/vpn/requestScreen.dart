// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
// import 'package:code_setup/presentation/screens/muscat/widgets/newRequest.dart';
// import 'package:code_setup/presentation/screens/vpn/view.dart';
// import 'package:flutter/material.dart';

// @RoutePage()
// class NewRequestPage extends StatelessWidget {
//   final String fromPage;
//   const NewRequestPage({super.key, required this.fromPage});

//   @override
//   Widget build(BuildContext context) {
//     if (fromPage == "vpn") {
//       return VpnNewRequest(
//         serviceTypeOptions: [
//           KDropdownItem(value: "IT", child: const Text("IT")),
//           KDropdownItem(value: "HR", child: const Text("HR")),
//           KDropdownItem(value: "Facilities", child: const Text("Facilities")),
//         ],
//       );
//     } else if (fromPage == "salalah") {
//       return NewRequest(
//         serviceTypeOptions: [
//           KDropdownItem(value: "IT", child: const Text("IT")),
//           KDropdownItem(value: "HR", child: const Text("HR")),
//           KDropdownItem(value: "Facilities", child: const Text("Facilities")),
//         ],
//       );
//     } else if (fromPage == "muscat") {
//       return MuscatNewRequest(
//         serviceTypeOptions: [
//           KDropdownItem(value: "IT", child: const Text("IT")),
//           KDropdownItem(value: "HR", child: const Text("HR")),
//           KDropdownItem(value: "Facilities", child: const Text("Facilities")),
//         ],
//       );
//     } else {
//       return const Center(child: Text("Unknown request type"));
//     }
//   }
// }
