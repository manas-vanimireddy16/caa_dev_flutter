part of '../view.dart';

@RoutePage()
class OrganizeSecurityAwarenessNewRequestScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  final String source;
  const OrganizeSecurityAwarenessNewRequestScreen({
    this.source = '',
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<OrganizeSecurityAwarenessNewRequestScreen> createState() =>
      _OrganizeSecurityAwarenessNewRequestScreenState();
}

class _OrganizeSecurityAwarenessNewRequestScreenState
    extends ConsumerState<OrganizeSecurityAwarenessNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool isAssign = widget.source == 'securityawarenessassign';

      if (isAssign) {
        final controller = ref.read(_vsProvider(_providerArgs).notifier);
        controller.fillAssignModeData(); // SAFE now
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final isFormValid = ref.watch(
      _vsProvider(_providerArgs).select((s) => s.isFormValid),
    );
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;
    final List<ApprovalDetailModel> approvals =
        state.requestDetails.approvalDetails ?? [];
    final active = controller.getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
    );

    final approverRoleId = active?.id;

    // 🔵 Assign mode when coming from approval/assign flow
    final bool isAssign = widget.source == 'securityawarenessassign';

    return KScaffold(
      appBar: KAppBar(
        title: const Text(
          "New Request to Organize Security Awareness (CAA008)",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// SUBTITLE
                Text(
                  "Provide details about your New Request",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s14,
                    fontWeight: theme.fontWeights.wBold,
                  ),
                ),
                20.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Title of Awareness *
                // ───────────────────────────────────────
                KTextField(
                  fieldHeadingText: "Title of Awareness *",
                  controller: controller.titleController,
                  hintText: "Enter title of awareness",
                  // 🔒 In assign mode, this must be read-only
                  readOnly: isAssign,
                  enabled: !isAssign,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? "Required" : null,
                ),
                16.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Date of submission *
                // ───────────────────────────────────────
                KTextField(
                  fieldHeadingText: "Date of Submission *",
                  hintText: controller.dateOfSubmissionController.text.isEmpty
                      ? 'Enter the Submission Date'
                      : controller.dateOfSubmissionController.text,
                  controller: controller.dateOfSubmissionController,
                  readOnly: true,
                  // 🔒 In assign mode, approver must NOT change submission date
                  onTap: isAssign
                      ? null
                      : () async {
                          final date = await KAppX.extendedRouter
                              .showKDatePicker(
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                          if (date != null) {
                            controller.dateOfSubmissionController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                          }
                        },
                  validator: (value) {
                    if (controller.dateOfSubmissionController.text.isEmpty) {
                      return "Please select submission date";
                    }
                    return null;
                  },
                  // enabled: !isAssign,
                ),
                16.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Phone number *
                // ───────────────────────────────────────
                KTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  fieldHeadingText: "Phone Number *",
                  controller: controller.contactNumberController,
                  hintText: "Enter phone number",
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  // 🔒 Lock in assign mode
                  readOnly: isAssign,

                  // enabled: !isAssign,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "Please enter phone number";
                    }

                    final phone = v.trim();

                    if (phone.length < 8 || phone.length > 11) {
                      return "Please enter atleast 8-digit number";
                    }

                    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                      return "Phone number must contain only digits";
                    }

                    return null;
                  },
                ),
                16.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Event Date *
                // ───────────────────────────────────────
                // NOTE: This must be editable for approver (AND requester)
                KTextField(
                  fieldHeadingText: "Event Date *",
                  hintText: controller.eventDateController.text.isEmpty
                      ? 'Enter the Event Date'
                      : controller.eventDateController.text,
                  controller: controller.eventDateController,
                  readOnly: true,
                  onTap: () async {
                    final date = await KAppX.extendedRouter.showKDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (date != null) {
                      controller.eventDateController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(date);
                    }
                  },
                  validator: (value) {
                    if (controller.eventDateController.text.isEmpty) {
                      return "Please select event date";
                    }
                    return null;
                  },
                  // ✅ Event date is allowed in both modes
                  enabled: true,
                ),
                16.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Event Time *
                // ───────────────────────────────────────
                // NOTE: This must be editable for approver (AND requester)
                KTextField(
                  fieldHeadingText: "Event Time *",
                  hintText: controller.eventTimeController.text.isEmpty
                      ? 'Enter the Event Time'
                      : controller.eventTimeController.text,
                  controller: controller.eventTimeController,
                  readOnly: true,
                  onTap: () async {
                    final picked = await KAppX.extendedRouter.showKTimePicker(
                      initialTime: TimeOfDay.now(),
                    );

                    if (picked != null) {
                      // Convert TimeOfDay → HH:mm:ss
                      final now = DateTime.now();
                      final formatted = DateFormat("HH:mm:ss").format(
                        DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                          picked.minute,
                        ),
                      );

                      controller.eventTimeController.text = formatted;
                    }
                  },
                  validator: (value) {
                    if (controller.eventTimeController.text.isEmpty) {
                      return "Please select event time";
                    }
                    return null;
                  },
                  // ✅ Event time is allowed in both modes
                  enabled: true,
                ),
                16.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Place (Optional)
                // ───────────────────────────────────────
                KTextField(
                  fieldHeadingText: "Place (Optional)",
                  controller: controller.placeController,
                  hintText: "Enter the place (optional)",
                  // 🔒 Lock in assign mode
                  readOnly: isAssign,
                  // enabled: !isAssign,
                ),
                20.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Media Coverage Required (Yes / No)
                // ───────────────────────────────────────
                Text(
                  "Media Coverage Required",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s14,
                    fontWeight: theme.fontWeights.wBold,
                  ),
                ),
                8.toVerticalSizedBox,

                CustomRadioGroup(
                  label: "",
                  options: const ["Yes", "No"],
                  view: const ["Yes", "No"],
                  selectedValue: state.mediaCoverageRequired,
                  // 🔒 Disable change in assign mode
                  onChanged: isAssign
                      ? (null)
                      : (v) {
                          controller.onMediaCoverageChange(v);
                        },
                ),
                6.toVerticalSizedBox,

                Text(
                  "If yes, the request should be automatically created to the media for coverage",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s12,
                    color: Colors.grey.shade600,
                  ),
                ),
                20.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Description / Approval Comments
                // ───────────────────────────────────────
                //
                // A (your choice):
                //  - Normal mode: requester description (editable)
                //  - Assign mode: approver comments (editable)
                isAssign
                    ? KTextField(
                        fieldHeadingText:
                            "Approval Comments / Additional Notes (Optional)",
                        controller: controller.approvalComments,
                        maxLines: 5,
                        hintText: "Write your approval comments here...",
                        readOnly: false,
                        // enabled: true, // ✅ approver can always edit this
                      )
                    : KTextField(
                        fieldHeadingText:
                            "Description / Additional Notes (Optional)",
                        controller: controller.descriptionController,
                        maxLines: 5,
                        hintText: "Write here...",
                        // requester can edit
                      ),
                20.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Attachments
                // ───────────────────────────────────────
                Text(
                  "Attachments",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s14,
                    fontWeight: theme.fontWeights.wBold,
                  ),
                ),
                8.toVerticalSizedBox,

                // ───────────────────────────────
                // ASSIGN MODE → SHOW API ATTACHMENTS ONLY
                // ───────────────────────────────
                if (isAssign)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.attachmentsFromApi.isNotEmpty)
                        ...state.attachmentsFromApi.map((file) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    file.fileName ??
                                        '', // ← since data is NOT FileUploadItem
                                    style: TextStyle(
                                      fontSize: theme.fontSizes.s13,
                                      fontWeight: theme.fontWeights.wBold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      if (state.attachmentsFromApi.isEmpty)
                        Text(
                          "No attachments available",
                          style: TextStyle(
                            fontSize: theme.fontSizes.s12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  )
                // ───────────────────────────────
                // NORMAL MODE → SHOW FILE UPLOAD WIDGET
                // ───────────────────────────────
                else
                  FileUploadWidget(
                    onUploadSuccess: controller.onUploadFileSuccess,
                    onDelete: controller.onRemoveFile,
                  ),

                6.toVerticalSizedBox,

                Text(
                  "You can upload doc, docx, pdf, png, jpeg files; files can't be larger than 10MB",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s12,
                    color: Colors.grey,
                  ),
                ),

                30.toVerticalSizedBox,

                // ───────────────────────────────────────
                // Submit / Assign Button
                // ───────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: state.isLoading
                        ? Text(!isAssign ? "Submitting..." : "Assigning...")
                        : Text(!isAssign ? "Submit" : "Assign"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: isFormValid
                          ? Colors.green.shade700
                          : Colors.grey,
                    ),

                    // ✔ Correct disable logic
                    onPressed: (!state.isLoading && isFormValid)
                        ? () {
                            if (!isAssign) {
                              if (controller.submitSecurityAwarenessRequest()) {
                                controller.submitAwarenessRequest();
                              }
                            } else {
                              controller.onEventChange();
                              controller.onClose(
                                approverRoleId ?? 0,
                                state.requestDetails.request?.id ?? 0,
                                'Approved',
                              );
                              KAppX.router.pop();
                            }
                          }
                        : null,
                  ),
                ),

                12.toVerticalSizedBox,
                if (!isAssign)
                  Center(
                    child: TextButton(
                      onPressed: () => KAppX.router.pop(),
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
