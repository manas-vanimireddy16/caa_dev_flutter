// part of '../view.dart';

// class HrTaskPlannerWidget extends ConsumerStatefulWidget {
//   final _VSControllerParams params;

//   const HrTaskPlannerWidget({super.key, required this.params});

//   @override
//   ConsumerState<HrTaskPlannerWidget> createState() =>
//       _HrTaskPlannerWidgetState();
// }

// class _HrTaskPlannerWidgetState extends ConsumerState<HrTaskPlannerWidget> {
//   late TextEditingController taskController;
//   late TextEditingController responsibilityController;

//   static const List<String> _freqList = [
//     'Daily',
//     'Weekly',
//     'Monthly',
//     'Quarterly',
//   ];

//   static const List<String> _durationList = ['Minutes', 'Hours', 'Quarter'];

//   @override
//   void initState() {
//     super.initState();

//     final vsState = ref.read(_vsProvider(widget.params));

//     taskController = TextEditingController(text: vsState.hrTaskInput);

//     responsibilityController = TextEditingController(
//       text: vsState.hrResponsibilityInput,
//     );
//   }

//   @override
//   void dispose() {
//     taskController.dispose();
//     responsibilityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final vsState = ref.watch(_vsProvider(widget.params));
//     final controller = ref.read(_vsProvider(widget.params).notifier);

//     /// ⭐ Sync text when state changes (clear / edit)
//     taskController.value = taskController.value.copyWith(
//       text: vsState.hrTaskInput,
//       selection: TextSelection.collapsed(offset: vsState.hrTaskInput.length),
//     );

//     responsibilityController.value = responsibilityController.value.copyWith(
//       text: vsState.hrResponsibilityInput,
//       selection: TextSelection.collapsed(
//         offset: vsState.hrResponsibilityInput.length,
//       ),
//     );

//     final isEditing =
//         vsState.hrEditingIndex != null &&
//         vsState.hrEditingIndex! < vsState.hrTasks.length;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// ⭐ TASK
//         TextField(
//           controller: taskController,
//           decoration: const InputDecoration(
//             labelText: "Task Related to Projects *",
//             border: OutlineInputBorder(),
//           ),
//           onChanged: controller.setHrTask,
//         ),

//         const SizedBox(height: 12),

//         /// ⭐ RESPONSIBILITY
//         TextField(
//           controller: responsibilityController,
//           decoration: const InputDecoration(
//             labelText: "Daily Responsibilities *",
//             border: OutlineInputBorder(),
//           ),
//           onChanged: controller.setHrResponsibility,
//         ),

//         const SizedBox(height: 12),

//         /// ⭐ FREQUENCY
//         KDropdownField<String>(
//           fieldHeading: const Text('Repeat Frequency *'),
//           value: _freqList.contains(vsState.hrFrequencyInput)
//               ? vsState.hrFrequencyInput
//               : null,
//           items: _freqList
//               .map((e) => KDropdownItem(value: e, child: Text(e)))
//               .toList(),
//           onChanged: (value) {
//             if (value != null) {
//               controller.setHrFrequency(value);
//             }
//           },
//         ),

//         const SizedBox(height: 12),

//         /// ⭐ DURATION
//         KDropdownField<String>(
//           fieldHeading: const Text('Duration *'),
//           value: _durationList.contains(vsState.hrDurationInput)
//               ? vsState.hrDurationInput
//               : null,
//           items: _durationList
//               .map((e) => KDropdownItem(value: e, child: Text(e)))
//               .toList(),
//           onChanged: (value) {
//             if (value != null) {
//               controller.setHrDuration(value);
//             }
//           },
//         ),

//         const SizedBox(height: 20),

//         /// ⭐ ADD TABLE BUTTON
//         InkWell(
//           onTap: () {
//             controller.addOrUpdateHrTask(context);
//           },
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade300),
//               color: Colors.grey.shade100,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   vsState.hrEditingIndex != null
//                       ? Icons.edit
//                       : Icons.add_circle_outline,
//                   color: Colors.green,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(isEditing ? "Update Table Row" : "Add Table"),
//               ],
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),

//         /// ⭐ IMPORT EXCEL
//         OutlinedButton.icon(
//           onPressed: () async {
//             final err = await controller.uploadHrExcel();

//             if (err != null && context.mounted) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(err)));
//             }
//           },
//           icon: const Icon(Icons.upload_file),
//           label: const Text("Import Excel"),
//         ),

//         const SizedBox(height: 20),

//         /// ⭐ EMPTY STATE
//         if (vsState.hrTasks.isEmpty)
//           const Text("No rows added yet", style: TextStyle(color: Colors.grey)),

//         /// ⭐ CARD LIST
//         ...vsState.hrTasks.asMap().entries.map((entry) {
//           final index = entry.key;
//           final item = entry.value;

//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             child: ListTile(
//               leading: CircleAvatar(child: Text("${index + 1}")),
//               title: Text(item.task),
//               subtitle: Text(
//                 "${item.responsibility} • ${item.frequency} • ${item.duration}",
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () => controller.editHrTask(index),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () => controller.deleteHrTask(index),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }

part of '../view.dart';

class HrTaskPlannerWidget extends ConsumerStatefulWidget {
  final _VSControllerParams params;

  const HrTaskPlannerWidget({super.key, required this.params});

  @override
  ConsumerState<HrTaskPlannerWidget> createState() =>
      _HrTaskPlannerWidgetState();
}

class _HrTaskPlannerWidgetState extends ConsumerState<HrTaskPlannerWidget> {
  late TextEditingController taskController;
  late TextEditingController responsibilityController;

  static const List<String> _freqList = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
  ];

  static const List<String> _durationList = ['Minutes', 'Hours', 'Quarter'];

  @override
  void initState() {
    super.initState();

    final vsState = ref.read(_vsProvider(widget.params));

    taskController = TextEditingController(text: vsState.hrTaskInput);
    responsibilityController = TextEditingController(
      text: vsState.hrResponsibilityInput,
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    responsibilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vsState = ref.watch(_vsProvider(widget.params));
    final controller = ref.read(_vsProvider(widget.params).notifier);

    taskController.value = taskController.value.copyWith(
      text: vsState.hrTaskInput,
      selection: TextSelection.collapsed(offset: vsState.hrTaskInput.length),
    );

    responsibilityController.value = responsibilityController.value.copyWith(
      text: vsState.hrResponsibilityInput,
      selection: TextSelection.collapsed(
        offset: vsState.hrResponsibilityInput.length,
      ),
    );

    final isEditing =
        vsState.hrEditingIndex != null &&
        vsState.hrEditingIndex! < vsState.hrTasks.length;

    return Column(
      children: [
        /// ⭐ CARD 1 — FORM
        Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "HR Annual Planning",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    labelText: "Task Related to Projects *",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: controller.setHrTask,
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: responsibilityController,
                  decoration: const InputDecoration(
                    labelText: "Daily Responsibilities *",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: controller.setHrResponsibility,
                ),

                const SizedBox(height: 12),

                KDropdownField<String>(
                  fieldHeading: const Text('Repeat Frequency *'),
                  value: _freqList.contains(vsState.hrFrequencyInput)
                      ? vsState.hrFrequencyInput
                      : null,
                  items: _freqList
                      .map((e) => KDropdownItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setHrFrequency(value);
                    }
                  },
                ),

                const SizedBox(height: 12),

                KDropdownField<String>(
                  fieldHeading: const Text('Duration *'),
                  value: _durationList.contains(vsState.hrDurationInput)
                      ? vsState.hrDurationInput
                      : null,
                  items: _durationList
                      .map((e) => KDropdownItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setHrDuration(value);
                    }
                  },
                ),

                const SizedBox(height: 20),

                InkWell(
                  onTap: () {
                    controller.addOrUpdateHrTask(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isEditing ? Icons.edit : Icons.add_circle_outline,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(isEditing ? "Update Table Row" : "Add Table"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton.icon(
                  onPressed: () async {
                    final err = await controller.uploadHrExcel();

                    if (err != null && context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(err)));
                    }
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Import Excel"),
                ),
              ],
            ),
          ),
        ),

        /// ⭐ CARD 2 — TABLE
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (vsState.hrTasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "No rows added yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                ...vsState.hrTasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      title: Text(item.task),
                      subtitle: Text(
                        "${item.responsibility} • ${item.frequency} • ${item.duration}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => controller.editHrTask(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.deleteHrTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
