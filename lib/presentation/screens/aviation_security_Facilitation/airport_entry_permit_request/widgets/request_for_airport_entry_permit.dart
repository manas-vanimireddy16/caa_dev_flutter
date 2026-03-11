part of '../view.dart';

@RoutePage()
class NewRequestForAirportEntryPermitScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  const NewRequestForAirportEntryPermitScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
  });

  @override
  ConsumerState<NewRequestForAirportEntryPermitScreen> createState() =>
      _NewRequestForAirportEntryPermitScreenState();
}

class _NewRequestForAirportEntryPermitScreenState
    extends ConsumerState<NewRequestForAirportEntryPermitScreen> {
  late final MultiSelectController<AreaPermission> areaController;
  List<DropdownItem<AreaPermission>> permissionItems = [];

  @override
  void initState() {
    super.initState();

    // Controller must exist BEFORE build
    areaController = MultiSelectController<AreaPermission>();

    // Delay items + preselect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initial = ref.read(_vsProvider);

      permissionItems = initial.permissionAreas
          .map((e) => DropdownItem(label: e.name, value: e))
          .toList();

      areaController.setItems(permissionItems);

      if (initial.selectedpermissionAreas.isNotEmpty) {
        areaController.selectWhere(
          (item) => initial.selectedpermissionAreas.contains(item.value),
        );
      }

      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider.select((s) => s));
    final controller = ref.read(_vsProvider.notifier);

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
              //-----------------------------------------
              // FORM (MultiDropdown is NOT inside this)
              //-----------------------------------------
              Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KTextField(
                      fieldHeadingText: "Full Name / Family Name *",
                      controller: controller.fullNameController,
                      hintText: "Enter",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    16.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Nationality *",
                      controller: controller.nationalityController,
                      hintText: "Select",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    16.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Date of Birth *",
                      hintText: controller.dobController.text.isEmpty
                          ? 'Date of Birth'
                          : controller.dobController.text,
                      controller: controller.dobController,
                      onTap: () async {
                        final date = await KAppX.extendedRouter.showKDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          controller.dobController.text = DateFormat(
                            'yyyy-MM-dd',
                          ).format(date);
                        }
                      },
                      validator: (_) => controller.dobController.text.isEmpty
                          ? "Please select Date of Birth"
                          : null,
                    ),
                    16.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Place *",
                      controller: controller.placeController,
                      hintText: "Enter",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    16.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Passport / ID Card No *",
                      controller: controller.passportController,
                      hintText: "Enter",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    16.toVerticalSizedBox,

                    KDropdownField<String>(
                      fieldHeading: const Text('Category of Permit *'),
                      value: state.permitCategory.isNotEmpty
                          ? state.permitCategory
                          : null,
                      decoration: const InputDecoration(
                        labelText: "Select *",
                        border: OutlineInputBorder(),
                      ),
                      items: state.categoryOfPermitList
                          .map((e) => KDropdownItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        controller.onPermitCategoryChange(value ?? '');
                      },
                    ),
                    12.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Phone Number *",
                      controller: controller.phoneController,
                      hintText: "Enter",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    16.toVerticalSizedBox,

                    KDropdownField<String>(
                      fieldHeading: const Text('Location *'),
                      value: state.location.isNotEmpty ? state.location : null,
                      decoration: const InputDecoration(
                        labelText: "Select *",
                        border: OutlineInputBorder(),
                      ),
                      items: state.locations
                          .map((e) => KDropdownItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        controller.onLocationChange(value ?? '');
                      },
                    ),
                    12.toVerticalSizedBox,

                    CustomRadioGroup(
                      label: "Type of Permit *",
                      options: ["Permanent", "Temporary"],
                      view: ["Permanent", "Temporary"],
                      selectedValue: state.permitType,
                      onChanged: controller.onPermitChange,
                    ),
                    16.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Start Time *",
                      readOnly: true,
                      hintText: controller.startTimeController.text.isEmpty
                          ? 'Start Time'
                          : controller.startTimeController.text,
                      controller: controller.startTimeController,
                      onTap: () async {
                        final date = DateTime.now();
                        if (date != null) {
                          controller.startTimeController.text = DateFormat(
                            'yyyy-MM-dd',
                          ).format(date);
                        }
                      },
                      validator: (_) =>
                          controller.startTimeController.text.isEmpty
                          ? "Please select Start Time"
                          : null,
                    ),
                    16.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Duration *",
                      hintText: "Enter duration",
                      controller: controller.durationController,
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    16.toVerticalSizedBox,
                    KTextField(
                      fieldHeadingText: "Details *",
                      hintText: "Write Here... (min 10 characters, max 500)",
                      controller: controller.detailsController,
                      minLines: 3,
                      maxLines: 6,
                      validator: (v) => (v == null || v.length < 10)
                          ? "Minimum 10 characters"
                          : null,
                    ),
                    20.toVerticalSizedBox,

                    KTextField(
                      fieldHeadingText: "Occupation / Staff *",
                      controller: controller.occupationController,
                      hintText: "Enter",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    20.toVerticalSizedBox,

                    CustomRadioGroup(
                      label: "For Visitor",
                      options: ["Visa Type", "Visa No", "Date Expiry Visa"],
                      view: ["Visa Type", "Visa No", "Date Expiry Visa"],
                      selectedValue: state.visitorChecks,
                      onChanged: controller.onVisitorCheckChange,
                    ),
                    20.toVerticalSizedBox,

                    FileUploadWidget(
                      onUploadSuccess: controller.onUploadFileSuccess,
                      onDelete: controller.onRemoveFile,
                    ),
                    8.toVerticalSizedBox,

                    Text(
                      "You can upload doc, docx, pdf, png, jpeg files. Max size 10MB",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    20.toVerticalSizedBox,
                  ],
                ),
              ),

              //-----------------------------------------
              // ⭐ MULTIDROPDOWN OUTSIDE THE FORM
              //-----------------------------------------
              20.toVerticalSizedBox,
              Text(
                "Permission to Required Areas *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),

              8.toVerticalSizedBox,
              if (permissionItems.isNotEmpty)
                RepaintBoundary(
                  child: MultiDropdown<AreaPermission>(
                    controller: areaController,
                    items: permissionItems,

                    onSelectionChange: (List<AreaPermission> values) {
                      controller.onAreaPermissionChange(values);
                    },

                    fieldDecoration: FieldDecoration(
                      hintText: "Permission to Required Areas *",
                      padding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

              CustomCheckboxGroup(
                label: "Acknowledgements *",
                options: [
                  "I agree to comply with CAA's security policies.",
                  "I understand misuse may result in disciplinary action.",
                ],
                view: [
                  "I agree to comply with CAA's security policies.",
                  "I understand misuse may result in disciplinary action.",
                ],
                selectedValues: state.acknowledgement,
                onChanged: controller.onSelectedAcknowledgements,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isFormValid
                      ? () {
                          controller.submitAwarenessRequest(
                            widget.serviceId,
                            widget.subServiceId,
                          );
                        }
                      : null, // disabled when invalid
                  child: const Text("Submit Request"),
                ),
              ),

              //-----------------------------------------
              // Continue with rest of form
              //-----------------------------------------
              20.toVerticalSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
