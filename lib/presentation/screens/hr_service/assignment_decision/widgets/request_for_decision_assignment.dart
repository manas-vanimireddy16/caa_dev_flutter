part of '../view.dart';

@RoutePage()
class NewAssignmentDecisionScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const NewAssignmentDecisionScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<NewAssignmentDecisionScreen> createState() =>
      _NewAssignmentDecisionScreenState();
}

class _NewAssignmentDecisionScreenState
    extends ConsumerState<NewAssignmentDecisionScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ({Service service, SubService subService}) _providerArgs;
  @override
  void initState() {
    super.initState();

    // ✅ INITIALIZE HERE
    _providerArgs = (service: widget.service, subService: widget.subService);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    return KScaffold(
      appBar: KAppBar(
        title: const Text("New Request for Security Threat - RST"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= FORM =================
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -------- ROLE --------
                    KDropdownField<int>(
                      fieldHeadingText: 'Select User *',
                      value: state.selectedUserId,
                      decoration: const InputDecoration(
                        labelText: "Select *",
                        border: OutlineInputBorder(),
                      ),
                      // validator: (v) =>
                      //     v == null ? "Please select role" : null,
                      items: state.usersList
                          .map(
                            (e) => KDropdownItem<int>(
                              value: e.id!,
                              child: Text(e.employeeName ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.onUserChange(value);
                        }
                      },
                    ),

                    12.toVerticalSizedBox,

                    /// -------- ASSIGNED EMPLOYEE --------
                    KTextField(
                      fieldHeadingText: "Assigned Employee Name *",
                      readOnly: true,
                      controller: controller.assignedEmployeeController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- CIVIL ID --------
                    KTextField(
                      fieldHeadingText: "Civil ID Card Number *",
                      readOnly: true,
                      controller: controller.civilIdCardNumberController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- EMPLOYEE ID --------
                    KTextField(
                      fieldHeadingText: "Employee Id *",
                      readOnly: true,
                      controller: controller.empIdController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- CURRENT JOB --------
                    KTextField(
                      fieldHeadingText: "Current Job Position *",
                      readOnly: true,
                      controller: controller.currentJobPositionController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- ASSIGNED POSITION --------
                    KDropdownField<String>(
                      fieldHeadingText: 'Assigned Job Position *',
                      value: state.selectedPositionName.isEmpty
                          ? null
                          : state.selectedPositionName,
                      decoration: const InputDecoration(
                        labelText: "Select *",
                        border: OutlineInputBorder(),
                      ),
                      // validator: (v) =>
                      //     v == null || v.isEmpty ? "Required" : null,
                      items: state.positionsList
                          .map(
                            (e) => KDropdownItem<String>(
                              value: e.name ?? '',
                              child: Text(e.name ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.onPositionChange(value);
                        }
                      },
                    ),

                    16.toVerticalSizedBox,

                    /// -------- PHONE --------
                    KTextField(
                      fieldHeadingText: "Phone Number *",
                      readOnly: true,
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- ALLOWANCE --------
                    KTextField(
                      fieldHeadingText: "Assignment Allowance *",
                      controller: controller.assignmentAllowanceController,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- START DATE --------
                    KTextField(
                      fieldHeadingText: "Start Date *",
                      readOnly: true,
                      controller: controller.startTimeController,
                      validator: (_) =>
                          controller.startTimeController.text.isEmpty
                          ? "Required"
                          : null,
                      onTap: () async {
                        final date = await KAppX.extendedRouter.showKDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          controller.startTimeController.text = DateFormat(
                            'yyyy-MM-dd',
                          ).format(date);
                        }
                      },
                    ),

                    16.toVerticalSizedBox,

                    /// -------- END DATE --------
                    KTextField(
                      fieldHeadingText: "End Date *",
                      readOnly: true,
                      controller: controller.endTimeController,
                      validator: (_) =>
                          controller.endTimeController.text.isEmpty
                          ? "Required"
                          : null,
                      onTap: () async {
                        final date = await KAppX.extendedRouter.showKDatePicker(
                          initialDate:
                              controller.startTimeController.text.isNotEmpty
                              ? DateTime.parse(
                                  controller.startTimeController.text,
                                )
                              : DateTime.now(),
                          firstDate:
                              controller.startTimeController.text.isNotEmpty
                              ? DateTime.parse(
                                  controller.startTimeController.text,
                                )
                              : DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (date != null) {
                          controller.endTimeController.text = DateFormat(
                            'yyyy-MM-dd',
                          ).format(date);
                        }
                      },
                    ),

                    16.toVerticalSizedBox,

                    /// -------- REASON --------
                    KTextField(
                      fieldHeadingText: "Reason For Request *",
                      controller: controller.reasonForRequestController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                  ],
                ),
              ),

              24.toVerticalSizedBox,

              /// ================= SUBMIT =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isFormFilled
                        ? Colors.green
                        : Colors.grey,
                  ),
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) return;
                    if (!controller.isFormFilled) return;

                    controller.submitAssignmentDecisionRequest(
                      widget.serviceId,
                      widget.subServiceId,
                    );
                  },
                  child: const Text("Submit Request"),
                ),
              ),

              20.toVerticalSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
