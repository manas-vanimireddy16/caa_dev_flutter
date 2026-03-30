part of '../view.dart';

@RoutePage()
class SecurityThreatNewRequestScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const SecurityThreatNewRequestScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<SecurityThreatNewRequestScreen> createState() =>
      _SecurityThreatNewRequestScreenState();
}

class _SecurityThreatNewRequestScreenState
    extends ConsumerState<SecurityThreatNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final userData = KAppX.globalProvider.read(userInfoProvider);

    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;

    return KScaffold(
      appBar: KAppBar(
        title: const Text("New Request for Security Threat - RST"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  "Provide details about your New Request",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s14,
                    fontWeight: theme.fontWeights.wBold,
                  ),
                ),
                20.toVerticalSizedBox,

                /// Department
                KTextField(
                  fieldHeadingText: "Department *",

                  hintText: state.departmentName.isNotEmpty
                      ? state.departmentName
                      : "Enter Department",
                  readOnly: true,
                ),
                16.toVerticalSizedBox,

                /// Contact Number
                KTextField(
                  fieldHeadingText: "Contact Number *",
                  controller: controller.contactNumberController,
                  hintText: "Enter Contact Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    return null;
                  },
                ),
                16.toVerticalSizedBox,

                /// Type of Threat
                KDropdownField<String>(
                  fieldHeading: const Text("Type Of Threat *"),
                  value: state.threatOption.isNotEmpty
                      ? state.threatOption
                      : null,
                  // show text in dropdown
                  decoration: const InputDecoration(
                    hintText: "Select",
                    border: OutlineInputBorder(),
                  ),

                  // ITEMS
                  items: List.generate(
                    state.threatTypes.length,
                    (index) => KDropdownItem(
                      value: state.threatTypes[index], // UI shows TEXT
                      child: Text(state.threatTypes[index]),
                    ),
                  ),

                  // WHEN CHANGED → send index + 1
                  onChanged: (selectedText) {
                    final index = state.threatTypes.indexOf(selectedText ?? "");
                    final apiValue = index + 1; // THIS goes to API
                    controller.onThreatTypeChange(apiValue, selectedText ?? "");
                  },
                ),
                16.toVerticalSizedBox,

                /// Description
                KTextField(
                  fieldHeadingText: "Description / Additional Notes *",
                  controller: controller.descriptionController,
                  hintText: "Write here... (min 10 characters, max 500)",
                  maxLines: 5,
                ),
                20.toVerticalSizedBox,

                /// Priority
                Text(
                  "Priorities *",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s14,
                    fontWeight: theme.fontWeights.wBold,
                  ),
                ),
                8.toVerticalSizedBox,

                CustomRadioGroup(
                  label: "",
                  options: [
                    'P1-Very Low',
                    'P2-Low',
                    'P3-Moderate',
                    'P4-High',
                    'P5-Very High',
                  ],
                  view: const [
                    "P1 - Very Low",
                    "P2 - Low",
                    "P3 - Moderate",
                    "P4 - High",
                    "P5 - Very High",
                  ],
                  selectedValue: state.priority,
                  onChanged: (val) => controller.onPriorityChange(val),
                ),

                20.toVerticalSizedBox,

                /// DOWNLOAD BUTTON
                Text(
                  "Download Security Threat Form and Fill",
                  style: TextStyle(fontSize: theme.fontSizes.s13),
                ),
                8.toVerticalSizedBox,

                SizedBox(
                  width: 220,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text("Download Threat Form"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: controller.downloadThreatForm,
                  ),
                ),

                20.toVerticalSizedBox,

                Text(
                  "Attach Form Downloaded (Optional)",
                  style: TextStyle(fontSize: theme.fontSizes.s13),
                ),
                8.toVerticalSizedBox,

                FileUploadWidget(
                  onUploadSuccess: (fileDetails) {
                    controller.onUploadFileSuccess(fileDetails);
                  },
                  onDelete: (index) {
                    controller.onRemoveFile(index);
                  },
                ),
                8.toVerticalSizedBox,

                Text(
                  "You can upload doc, docx, pdf, png, jpeg files\nFile can't be larger than 10MB",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s12,
                    color: Colors.grey,
                  ),
                ),

                30.toVerticalSizedBox,

                /// Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: state.isLoading
                        ? Text("Submiting Request...")
                        : const Text("Submit Request"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.green.shade600,
                    ),
                    onPressed: () {
                      if (state.formKey.currentState!.validate()) {
                        controller.sendSecurityThreatRequest();
                      }
                    },
                  ),
                ),
                16.toVerticalSizedBox,

                /// Cancel
                Center(
                  child: TextButton(
                    onPressed: () => context.router.pop(),
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
