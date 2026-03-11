part of '../view.dart';

@RoutePage()
class VpnNewRequestScreen extends ConsumerWidget {
  // final List<KDropdownItem<String>> serviceTypeOptions;
  const VpnNewRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);

    return KScaffold(
      appBar: KAppBar(title: const Text('New VPN Ticket')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provide details about your New Ticket",
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: FontWeight.w400,
                ),
              ),

              16.toVerticalSizedBox,

              KTextField(
                fieldHeadingText: "Job Title *",
                controller: controller.jobTitleController,
                hintText: "Enter Job Title",
              ),
              16.toVerticalSizedBox,

              KTextField(
                fieldHeadingText: "Department Name *",
                controller: controller.departmentController,
                hintText: "Enter Department Name",
              ),
              16.toVerticalSizedBox,

              CustomRadioGroup(
                label: 'Request for',
                options: ['CAA_STAFF', 'CONTRACTOR'],
                view: ['CAA staff', 'Contractor'],

                selectedValue: state.requestFor,
                onChanged: (value) {
                  controller.onSelectedRequestFor(value);
                },
              ),
              16.toVerticalSizedBox,

              /// Person Name
              KTextField(
                fieldHeadingText: "Person Name *",
                controller: controller.personNameController,
                hintText: "Hussan",
              ),

              12.toVerticalSizedBox,

              /// Contact Number
              KTextField(
                fieldHeadingText: "Contact Number *",
                controller: controller.contactNumberController,
                hintText: "XXXXXXXXXX",
                keyboardType: TextInputType.phone,
              ),
              12.toVerticalSizedBox,

              /// Department
              KTextField(
                fieldHeadingText: "Employee Id *",
                controller: controller.employeeIdController,
                hintText: "XXX *",
              ),
              12.toVerticalSizedBox,

              KTextField(
                fieldHeading: const Text("Employee Email Id *"),
                controller: controller.emailController,
                hintText: "XXX@gmail.com",
              ),
              12.toVerticalSizedBox,
              KTextField(
                fieldHeading: const Text("Enter Country Name *"),
                controller: controller.countryController,
                hintText: "XXX@gmail.com",
              ),
              12.toVerticalSizedBox,
              CustomCheckboxGroup(
                label: "System / Applications to Access",
                options: [
                  "Internal Databases",
                  "File Servers",
                  "Shared Servers",
                  "UFUQ",
                  "ERP",
                  "Other",
                ],
                view: [
                  "Internal DataBases",
                  "File Servers",
                  "Shared Servers",
                  "UFUQ",
                  "ERP",
                  "Other",
                ],
                selectedValues: state.systemsToAccess,
                onChanged: (value) {
                  controller.onSelectedSystem(value);
                },
              ),
              12.toVerticalSizedBox,

              CustomCheckboxGroup(
                label: "Reasons for Request",
                options: [
                  "Remote Work",
                  "Third Party / Vendor Access",
                  "Access to Internal System/Applications",
                  "Project-specific Requirement",
                ],
                view: [
                  "Remote Work",
                  "Third Party / Vendor Access",
                  "Access to Internal System / Applications",
                  "Project-Specific Requirement",
                ],
                selectedValues: state.reasonForRequest,
                onChanged: (value) {
                  controller.onSelectedReasonForRequest(value);
                },
              ),
              12.toVerticalSizedBox,

              KTextField(
                fieldHeadingText: "Start Date *",
                hintText: "MM/DD/YYYY",
                controller: controller.startDate,
                readOnly: false, // allow typing
                keyboardType: TextInputType.datetime,
                onChanged: (value) => controller.handleManualDateInput(
                  input: value,
                  isStartDate: true,
                ),
                onTap: () async {
                  await controller.pickDate(isStartDate: true);
                },
              ),

              KTextField(
                fieldHeadingText: "End Date *",
                hintText: "MM/DD/YYYY",
                controller: controller.endDate,
                readOnly: false,
                keyboardType: TextInputType.datetime,
                onChanged: (value) => controller.handleManualDateInput(
                  input: value,
                  isStartDate: false,
                ),
                onTap: () async {
                  await controller.pickDate(isStartDate: false);
                },
              ),

              12.toVerticalSizedBox,

              CustomRadioGroup(
                label: 'Request for Time-Period',
                options: ['ONE_TIME', 'PERMANENT'],
                view: ['One-Time', 'Permanent'],
                selectedValue: state.timePeriod,
                onChanged: (value) {
                  controller.onSelectedTimePeriod(value);
                },
              ),
              12.toVerticalSizedBox,
              CustomCheckboxGroup(
                label: "Device Type",
                options: [
                  "CAA_LAPTOP",
                  "PERSONAL_DEVICE_COMPLIES_WITH_SECURITY_POLICIES ",
                  "MOBILE_DEVICE",
                ], // Stored in state
                view: [
                  "CAA Laptop",
                  "Personal Device",
                  "Mobile Device",
                ], // Displayed in UI
                selectedValues: state.devices,
                onChanged: (value) {
                  controller.onSelectedDevice(value);
                },
              ),

              12.toVerticalSizedBox,

              /// Description
              KTextField(
                controller: controller.descriptionController,
                hintText: "Description (Optional)",
                maxLines: 3,
              ),
              12.toVerticalSizedBox,
              CustomCheckboxGroup(
                label: "Acknowledgements *",
                options: [
                  "I agree to comply with CAA's security policies.",
                  "I understand misuse may result in displinary action.",
                ],
                view: [
                  "I agree to comply with CAA's security policies.",
                  "I understand misuse may result in displinary action.",
                ],
                selectedValues: state.acknowledgement,
                onChanged: (value) {
                  controller.onSelectedAcknowledgements(value);
                },
              ),
              12.toVerticalSizedBox,

              /// Submit Button
              SizedBox(
                width: double.infinity.toAutoScaledWidth,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    controller.sendVPNRequest();
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
