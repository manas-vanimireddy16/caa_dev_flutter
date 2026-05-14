part of '../view.dart';

class ApproveRequestDialogWidget extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;
  final Service service;
  final SubService subService;

  const ApproveRequestDialogWidget({
    super.key,
    this.onSuccess,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<ApproveRequestDialogWidget> createState() =>
      _ApproveRequestDialogWidgetState();
}

class _ApproveRequestDialogWidgetState
    extends ConsumerState<ApproveRequestDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  /// ================= CONTROLLERS =================

  final commentsController = TextEditingController();

  final identificationMeasuresController = TextEditingController();

  final evidenceCollectedController = TextEditingController();

  final eradicationMeasuresController = TextEditingController();

  final recoveryMeasuresController = TextEditingController();

  final otherMitigationMeasuresController = TextEditingController();

  /// ================= CHECKBOXES =================

  bool headInformationSecurity = false;
  bool directorIT = false;
  bool legalDepartment = false;
  bool headInfrastructure = false;

  /// ================= FILES =================

  List<FileUploadItem> uploadedFiles = [];

  @override
  void dispose() {
    commentsController.dispose();

    identificationMeasuresController.dispose();

    evidenceCollectedController.dispose();

    eradicationMeasuresController.dispose();

    recoveryMeasuresController.dispose();

    otherMitigationMeasuresController.dispose();

    super.dispose();
  }

  /// ================= SUBMIT =================

  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    final state = ref.read(_vsProvider(_providerArgs));

    final active = controller.getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
    );

    final approverId = active?.id;

    /// ================= INCIDENT LIST =================

    List<String> incidentNotificationList = [];

    if (headInformationSecurity) {
      incidentNotificationList.add("Head of Information Security");
    }

    if (directorIT) {
      incidentNotificationList.add("Director of Information Technology");
    }

    if (legalDepartment) {
      incidentNotificationList.add("Legal Department");
    }

    if (headInfrastructure) {
      incidentNotificationList.add("Head of Infrastructure");
    }

    /// ================= PAYLOAD =================

    final payload = {
      "request_id": state.requestDetails.request?.id,
      "approval_id": approverId,
      "status": "Closed",
      "comment": commentsController.text.trim(),
      "incident_notification_in_caa": incidentNotificationList,
      "identification_measures": identificationMeasuresController.text.trim(),
      "evidence_collected": evidenceCollectedController.text.trim(),
      "eradication_mitigation_measures": eradicationMeasuresController.text
          .trim(),
      "recovery_measures": recoveryMeasuresController.text.trim(),
      "other_mitigation_measures": otherMitigationMeasuresController.text
          .trim(),

      /// ================= ATTACHMENTS =================
      "attachments": uploadedFiles.map((file) => file.toJson()).toList(),

      /// ================= ACTIONS =================
      "actions": {
        "identificationMeasures": identificationMeasuresController.text.trim(),
        "evidenceCollected": evidenceCollectedController.text.trim(),
        "eradicationMitigationMeasures": eradicationMeasuresController.text
            .trim(),
        "recoveryMeasures": recoveryMeasuresController.text.trim(),
        "otherMitigationMeasures": otherMitigationMeasuresController.text
            .trim(),
      },
    };

    debugPrint("PAYLOAD => $payload");

    controller.onApprove(payload);

    // widget.onSuccess?.call();
  }

  /// ================= COMMON TEXTAREA =================

  Widget buildTextArea({
    required TextEditingController controller,
    required String label,
    bool requiredField = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Enter details',
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (requiredField && (value == null || value.trim().isEmpty)) {
          return 'This field is required';
        }

        if (requiredField && value!.trim().length < 5) {
          return 'Minimum 5 characters required';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(_vsProvider(_providerArgs).notifier);

    return Container(
      width: 750,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= HEADER =================
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // const Text(
              //     //   "Approve Request",
              //     //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //     // ),
              //     // IconButton(
              //     //   onPressed: () => Navigator.pop(context),
              //     //   icon: const Icon(Icons.close),
              //     // ),
              //   ],
              // ),

              // const SizedBox(height: 20),

              /// ================= COMMENTS =================
              buildTextArea(
                controller: commentsController,
                label: 'Comments (Optional)',
              ),

              const SizedBox(height: 25),

              /// ================= INCIDENT NOTIFICATION =================
              const Text(
                'Incident Notification in CAA *',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Head of Information Security'),
                value: headInformationSecurity,
                onChanged: (value) {
                  setState(() {
                    headInformationSecurity = value ?? false;
                  });
                },
              ),

              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Director of Information Technology'),
                value: directorIT,
                onChanged: (value) {
                  setState(() {
                    directorIT = value ?? false;
                  });
                },
              ),

              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Legal Department'),
                value: legalDepartment,
                onChanged: (value) {
                  setState(() {
                    legalDepartment = value ?? false;
                  });
                },
              ),

              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Head of Infrastructure'),
                value: headInfrastructure,
                onChanged: (value) {
                  setState(() {
                    headInfrastructure = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 20),

              /// ================= IDENTIFICATION =================
              buildTextArea(
                controller: identificationMeasuresController,
                label:
                    'Identification Measures (Incident Verified, Assessed, Options Evaluated, Containment Measures) *',
                requiredField: true,
              ),

              const SizedBox(height: 20),

              /// ================= EVIDENCE =================
              buildTextArea(
                controller: evidenceCollectedController,
                label:
                    'Evidence Collected (System logs, audit logs, Ping, etc.) *',
                requiredField: true,
              ),

              const SizedBox(height: 12),

              /// ================= FILE UPLOAD =================
              FileUploadWidget(
                maxFiles: 5,
                maxFileSizeInMB: 10,
                existingFiles: uploadedFiles,
                allowedExtensions: const [
                  'doc',
                  'docx',
                  'pdf',
                  'png',
                  'jpeg',
                  'jpg',
                ],
                onUploadSuccess: (file) {
                  setState(() {
                    uploadedFiles.add(file);
                  });
                },
                onDelete: (index) {
                  setState(() {
                    uploadedFiles.removeAt(index);
                  });
                },
              ),

              const SizedBox(height: 20),

              /// ================= ERADICATION =================
              buildTextArea(
                controller: eradicationMeasuresController,
                label: 'Eradication / Mitigation Measures *',
                requiredField: true,
              ),

              const SizedBox(height: 20),

              /// ================= RECOVERY =================
              buildTextArea(
                controller: recoveryMeasuresController,
                label: 'Recovery Measures *',
              ),

              const SizedBox(height: 20),

              /// ================= OTHER MITIGATION =================
              buildTextArea(
                controller: otherMitigationMeasuresController,
                label: 'Other Mitigation Measures',
              ),

              const SizedBox(height: 30),

              /// ================= BUTTONS =================
              Wrap(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('CANCEL'),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: const Text('SUBMIT'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
