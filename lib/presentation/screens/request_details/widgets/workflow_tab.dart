import 'package:code_setup/presentation/screens/logistics/view.dart';
import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/workProgess.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:flutter/material.dart';

class WorkflowTabContent extends StatelessWidget {
  final List<SalalahWorkflowDetail> workflows;

  const WorkflowTabContent({super.key, required this.workflows});

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
              return TimelineItem(
                task: workflows[index],
                isLast: index == 10, //tasksData1.length - 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
