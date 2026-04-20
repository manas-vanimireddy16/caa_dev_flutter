// part of '../view.dart';

// class RequestTabs extends ConsumerWidget {
//   final int selectedTab;

//   RequestTabs({super.key, required this.selectedTab});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.read(_vsProvider.notifier);

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
//             selectedIndex: selectedTab,
//             onTap: () => controller.updateRequestTab(index),
//           );
//         }),
//       ),
//     );
//   }
// }
