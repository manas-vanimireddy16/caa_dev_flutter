// part of '../view.dart';

// class RequestTabs extends ConsumerStatefulWidget {
//   final int selectedTab;
//   final Service service;
//   final SubService subService;
//   RequestTabs({
//     super.key,
//     required this.selectedTab,
//     required this.service,
//     required this.subService,
//   });
//   @override
//   ConsumerState createState() => _RequestTabsState();
// }

// class _RequestTabsState extends ConsumerState<RequestTabs> {
//   late _VSControllerParams _providerArgs;
//   void initState() {
//     super.initState();
//     _providerArgs = _VSControllerParams(
//       service: widget.service,
//       subService: widget.subService,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = ref.read(_vsProvider(_providerArgs).notifier);

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(4, (index) {
//           final labels = [
//             "Request Details",
//             "Request History",
//             "Attachments",
//             "Work Flow",
//           ];
//           return TabItem(
//             text: labels[index],
//             index: index,
//             selectedIndex: widget.selectedTab,
//             onTap: () => controller.updateRequestTab(index),
//           );
//         }),
//       ),
//     );
//   }
// }
