part of '../view.dart';

@RoutePage()
class RequestforDutyMissionRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const RequestforDutyMissionRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestforDutyMissionRequestScreen> createState() =>
      _RequestforDutyMissionRequestScreenState();
}

class _RequestforDutyMissionRequestScreenState
    extends ConsumerState<RequestforDutyMissionRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Watch state only if needed
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.read(_vsProvider(_providerArgs));
    return KScaffold(
      backgroundColor: Colors.white,
      // appBar: KAppBar(title: Text('Mission Transfer Request')),

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: 'Mission Transfer Request',
          stepTitles: const ['1', '2', '3', '4'],
          steps: [
            controller.plannedForm1,
            controller.step2Fields(_providerArgs),
            controller.travelDetailsForm,
            controller.step4Fields(_providerArgs),
          ],

          onSubmit: (values) async {
            // await controller.onPressSubmit(values);

            if (context.mounted) {
              // context.router.pop();
            }
          },
        ),
      ),
    );
  }
}
// return KScaffold(
    //   appBar: KAppBar(
    //     title: Text(
    //       "${widget.subService.subServiceName} - ${widget.subService.code}",
    //     ),
    //   ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       padding: const EdgeInsets.all(16),
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             /// ================= FORM =================

    //             /// this field
    //             KTextField(
    //               fieldHeadingText: "Task Title *",
    //               controller: controller.taskTitleController,
    //               autovalidateMode: AutovalidateMode.onUserInteraction,
    //               validator: (v) {
    //                 if (v == null || v.isEmpty) {
    //                   return "Please enter task title";
    //                 }
    //                 if (v.length < 5) {
    //                   return "Task title should be at least 5 characters long";
    //                 }
    //                 return null;
    //               },
    //             ),

    //             16.toVerticalSizedBox,

    //             /// this field
    //             /// -------- ASSIGNED TO --------
    //             KDropdownField<int>(
    //               fieldHeadingText: 'Assigned To (Employee Name / ID) *',
    //               value: state.selectedUserId,
    //               decoration: const InputDecoration(
    //                 labelText: "Select *",
    //                 border: OutlineInputBorder(),
    //               ),
    //               // validator: (v) =>
    //               //     v == null ? "Please select employee" : null,
    //               items: state.usersList
    //                   .map(
    //                     (e) => KDropdownItem<int>(
    //                       value: e.id,
    //                       child: Text(e.employeeName),
    //                     ),
    //                   )
    //                   .toList(),
    //               onChanged: (value) {
    //                 if (value != null) {
    //                   controller.onUserChange(value);
    //                 }
    //               },
    //             ),

    //             16.toVerticalSizedBox,

    //             /// this field
    //             /// -------- PRIORITY --------
    //             KDropdownField<String>(
    //               fieldHeadingText: 'Priority *',
    //               value: state.selectedPriority.isEmpty
    //                   ? null
    //                   : state.selectedPriority,
    //               decoration: const InputDecoration(
    //                 labelText: "Select *",
    //                 border: OutlineInputBorder(),
    //               ),
    //               // validator: (v) =>
    //               //     v == null ? "Please select priority" : null,
    //               items: [
    //                 KDropdownItem(value: 'High', child: const Text('High')),
    //                 KDropdownItem(value: 'Medium', child: const Text('Medium')),
    //                 KDropdownItem(value: 'Low', child: const Text('Low')),
    //               ],
    //               onChanged: (value) {
    //                 if (value != null) {
    //                   controller.onPriorityChange(value);
    //                 }
    //               },
    //             ),

    //             16.toVerticalSizedBox,

    //             /// this field
    //             /// -------- COMPLETION DATE --------
    //             KTextField(
    //               fieldHeadingText: "Completion Date (Optional)",
    //               readOnly: true,
    //               controller: controller.completionController,
    //               onTap: () async {
    //                 final date = await KAppX.extendedRouter.showKDatePicker(
    //                   initialDate: DateTime.now(),
    //                   firstDate: DateTime.now(),
    //                   lastDate: DateTime(2100),
    //                 );

    //                 if (date != null) {
    //                   controller.completionController.text = DateFormat(
    //                     'yyyy-MM-dd',
    //                   ).format(date);

    //                   controller.updateStartDateSelected(true);
    //                 }
    //               },
    //             ),

    //             16.toVerticalSizedBox,

    //             /// this field
    //             /// -------- TASK DESCRIPTION --------
    //             KTextField(
    //               fieldHeadingText: "Task Description *",
    //               controller: controller.taskDescriptionController,
    //               maxLines: 4,
    //               validator: (v) => v == null || v.isEmpty ? "Required" : null,
    //             ),

    //             24.toVerticalSizedBox,

    //             /// this field
    //             /// -------- ATTACHMENTS --------
    //             FileUploadWidget(
    //               onUploadSuccess: controller.onUploadFileSuccess,
    //               onDelete: controller.onRemoveFile,
    //             ),

    //             24.toVerticalSizedBox,

    //             /// ================= SUBMIT =================
    //             SizedBox(
    //               width: double.infinity,
    //               child: ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: controller.isFormFilled
    //                       ? Colors.green
    //                       : Colors.grey,
    //                 ),
    //                 onPressed: () {
    //                   final isValid =
    //                       _formKey.currentState?.validate() ?? false;
    //                   if (!isValid) return;

    //                   controller.submitAssignaTasktoEmployeeRequest(
    //                     widget.serviceId,
    //                     widget.subServiceId,
    //                   );
    //                 },
    //                 child: const Text("Submit Request"),
    //               ),
    //             ),

    //             20.toVerticalSizedBox,
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );