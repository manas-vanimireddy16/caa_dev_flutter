// // import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
// // import 'package:code_setup/presentation/screens/logistics/view.dart';
// // import 'package:code_setup/presentation/screens/logistics/widgets/workProgess.dart';
// // import 'package:flutter/material.dart';
// part of '../view.dart';

// class WorkflowTabContent extends StatelessWidget {
//   final List<Workflow> workflows;
//   final Map<String, dynamic> details;

//   const WorkflowTabContent({
//     super.key,
//     required this.workflows,
//     required this.details,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 8.0,
//           right: 8.0,
//           top: 24.0,
//           bottom: 16.0,
//         ),
//         child: SizedBox(
//           height: 400,
//           child: ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: workflows.length,
//             itemBuilder: (context, index) {
//               return TimelineItem(
//                 task: workflows[index],
//                 isLast: index == workflows.length - 1,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// ...existing code...

part of '../view.dart';

class WorkflowTabContent extends StatelessWidget {
  final List<Workflow> workflows;
  final Map<String, dynamic> details;

  const WorkflowTabContent({
    super.key,
    required this.workflows,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 24.0,
          bottom: 16.0,
        ),
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workflows.length,
            itemBuilder: (context, index) {
              final bool isUser = index == 0;

              // For index 0 use the creator info (task.createdBy or details fallback)
              final actorName = isUser
                  ? (details['user name']?.toString() ??
                        details['userName']?.toString() ??
                        'N/A')
                  : (details['approver name']?.toString() ?? 'N/A');

              final actorId = isUser
                  ? (details['user id'] ??
                        details['userId'] ??
                        workflows[index].createdBy)
                  : (details['approver id'] ?? details['approverId']);
              final roleName = isUser ? '' : details['approverRole'];

              return TimelineItem(
                task: workflows[index],
                isLast: index == workflows.length - 1,
                actorName: actorName,
                actorId: actorId,
                roleName: roleName,

                isCreatedBy: isUser, // NEW: mark created-by row
              );
            },
          ),
        ),
      ),
    );
  }
}
