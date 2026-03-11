// import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
// import 'package:code_setup/presentation/screens/logistics/view.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/workProgess.dart';
// import 'package:flutter/material.dart';

part of '../view.dart';

class WorkflowTabContent extends StatelessWidget {
  final List<WorkflowDetail> workflows;

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
                isLast: index == workflows.length - 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
