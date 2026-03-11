part of '../view.dart';

@RoutePage()
class NewTemporaryAssignmentDecisionRequestScreen
    extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const NewTemporaryAssignmentDecisionRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<NewTemporaryAssignmentDecisionRequestScreen> createState() =>
      _NewTemporaryAssignmentDecisionRequestScreenState();
}

class _NewTemporaryAssignmentDecisionRequestScreenState
    extends ConsumerState<NewTemporaryAssignmentDecisionRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ({Service service, SubService subService}) _providerArgs;

  @override
  void initState() {
    super.initState();
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
                      fieldHeadingText: "Reason For Request *",
                      controller: controller.reasonForRequestController,
                      // keyboardType: TextInputType.number,
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

                          /// ✅ Update UI state (FAST)
                          controller.updateStartDateSelected(true);

                          /// Clear end date safely
                          controller.endTimeController.clear();
                        }
                      },
                    ),

                    16.toVerticalSizedBox,

                    /// -------- END DATE --------
                    KTextField(
                      fieldHeadingText: "End Date *",
                      readOnly: true,
                      enabled: state.isStartDateSelected, // ✅ FAST
                      controller: controller.endTimeController,
                      validator: (_) =>
                          controller.endTimeController.text.isEmpty
                          ? "Required"
                          : null,
                      onTap: state.isStartDateSelected
                          ? () async {
                              final startDate = DateTime.parse(
                                controller.startTimeController.text,
                              );

                              /// Minimum end date = start + 6 days
                              final minEndDate = startDate.add(
                                const Duration(days: 6),
                              );

                              final date = await KAppX.extendedRouter
                                  .showKDatePicker(
                                    initialDate: minEndDate,
                                    firstDate: minEndDate,
                                    lastDate: DateTime(2100),
                                  );

                              if (date != null) {
                                controller.endTimeController.text = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(date);
                              }
                            }
                          : null,
                    ),

                    16.toVerticalSizedBox,

                    /// -------- REASON --------
                    KTextField(
                      fieldHeadingText: "From Entity *",
                      controller: controller.fromEntityController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                    KTextField(
                      fieldHeadingText: "To Entity *",
                      controller: controller.toEntityController,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                  ],
                ),
              ),
              KDropdownField<String>(
                fieldHeadingText: 'Salary Payment Source *',
                value: state.selectedPaymentSource.isEmpty
                    ? null
                    : state.selectedPaymentSource,
                decoration: const InputDecoration(
                  labelText: "Select *",
                  border: OutlineInputBorder(),
                ),
                // validator: (v) =>
                //     v == null ? "Please select role" : null,
                items: ['Authority', 'Other Entity']
                    .map((e) => KDropdownItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.onPaymentSourceChange(value);
                  }
                },
              ),
              16.toVerticalSizedBox,
              KTextField(
                fieldHeadingText: "Social Service Fund Contribution *",
                controller: controller.socialServiceFundContribution,
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),

              24.toVerticalSizedBox,
              FileUploadWidget(
                onUploadSuccess: (fileDetails) {
                  controller.onUploadFileSuccess(fileDetails);
                },
                onDelete: (index) {
                  controller.onRemoveFile(index);
                },
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

                    controller.submitSecondmentDecisionRequest(
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
