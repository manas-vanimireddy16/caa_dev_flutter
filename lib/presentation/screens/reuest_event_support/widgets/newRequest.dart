part of '../view.dart';

@RoutePage()
class NewRequestRequestSupportScreen extends ConsumerStatefulWidget {
  // final List<KDropdownItem<String>> serviceTypeOptions;
  const NewRequestRequestSupportScreen({
    super.key,
    //required this.serviceTypeOptions,
  });

  @override
  ConsumerState<NewRequestRequestSupportScreen> createState() =>
      _NewRequestRequestSupportState();
}

class _NewRequestRequestSupportState
    extends ConsumerState<NewRequestRequestSupportScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider);
    final stateController = ref.read(_vsProvider.notifier);

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(title: const Text('New Event Support Request')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provide details about your New Request",
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: currentTheme.fontWeights.wBold,
                ),
              ),
              16.toVerticalSizedBox,

              KTextField(
                fieldHeadingText: 'Event Type *',
                controller: stateController.eventTypeController,
                hintText: "Event Title ",
              ),
              12.toVerticalSizedBox,

              KTextField(
                fieldHeadingText: 'Department *',
                controller: stateController.departmentController,
                hintText: "Department Auto Filled ",
              ),
              12.toVerticalSizedBox,

              /// Service Type (Dropdown instead of textfield)
              KDropdownField<String>(
                fieldHeading: Text('Service Types *'),
                decoration: const InputDecoration(
                  labelText: "Service Type *",
                  border: OutlineInputBorder(),
                ),
                items: [
                  KDropdownItem(value: "IT", child: const Text("IT")),
                  KDropdownItem(value: "HR", child: Text("HR")),
                  KDropdownItem(value: "Facilities", child: Text("Facilities")),
                ],
                onChanged: (value) {
                  // store service type in state provider if needed
                },
              ),
              12.toVerticalSizedBox,
              KTextField(
                fieldHeadingText: "Preferred Date *",
                hintText: state.fromDate ?? "DD/MM/YYYY",
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    stateController.onSelectFromDate(
                      "${date.day}/${date.month}/${date.year}",
                    );
                  }
                },
              ),
              12.toVerticalSizedBox,
              KDropdownField<String>(
                fieldHeading: Text('Location of Event *'),
                decoration: const InputDecoration(
                  labelText: "Service Type *",
                  border: OutlineInputBorder(),
                ),
                items: [],
                onChanged: (value) {},
              ),
              12.toVerticalSizedBox,
              KDropdownField<String>(
                fieldHeading: Text('Type of Event (optional)'),
                decoration: const InputDecoration(
                  labelText: "Service Type *",
                  border: OutlineInputBorder(),
                ),
                items: [
                  KDropdownItem(value: "IT", child: const Text("IT")),
                  KDropdownItem(value: "HR", child: Text("HR")),
                  KDropdownItem(value: "Facilities", child: Text("Facilities")),
                ],
                onChanged: (value) {
                  // store service type in state provider if needed
                },
              ),

              /// Problem
              KTextField(
                fieldHeadingText: 'Contact Number *',
                controller: stateController.contactNumberController,
                hintText: "My Laptop not working ",
                maxLines: 2,
              ),
              12.toVerticalSizedBox,

              /// Description
              KTextField(
                fieldHeadingText: 'Reason For Request *)',
                controller: stateController.reasonController,
                hintText: "",
                maxLines: 3,
              ),
              12.toVerticalSizedBox,

              /// Extension Number
              ///
              ///

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // final data = {
                    //   "s": controllers.personNameController.text,
                    //   "contactNumber": controllers.contactNumberController.text,
                    //   "department": controllers.departmentController.text,
                    //   "problem": controllers.problemController.text,
                    //   "description": controllers.descriptionController.text,
                    //   "extension": controllers.extensionNumberController.text,
                    //   // add service type & requestFor from providers
                    // };
                    // debugPrint("Submitting: $data");
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
