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

  bool isSubmitting = false;
  bool isClosed = false;

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

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    try {
      final controller = ref.read(_vsProvider(_providerArgs).notifier);
      final state = ref.read(_vsProvider(_providerArgs));

      final active = controller.getActiveApprovalLevel(
        state.requestDetails.approvalDetails ?? [],
      );

      final approverId = active?.id;

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
        "attachments": uploadedFiles.map((file) => file.toJson()).toList(),
        "actions": {
          "identificationMeasures": identificationMeasuresController.text
              .trim(),
          "evidenceCollected": evidenceCollectedController.text.trim(),
          "eradicationMitigationMeasures": eradicationMeasuresController.text
              .trim(),
          "recoveryMeasures": recoveryMeasuresController.text.trim(),
          "otherMitigationMeasures": otherMitigationMeasuresController.text
              .trim(),
        },
      };

      await controller.onApprove(payload);

      if (mounted) {
        setState(() {
          isSubmitting = false;
          isClosed = true;
        });

        widget.onSuccess?.call();

        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("APPROVE ERROR => $e");

      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  Widget buildMandatoryLabel(String title) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildNormalLabel(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    bool requiredField = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      enabled: !isClosed && !isSubmitting,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (requiredField && (value == null || value.trim().isEmpty)) {
          return 'This field is required';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= ACTION TEXT =================
              const Text(
                'Action Text',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 20),

              /// ================= COMMENTS =================
              buildNormalLabel('Comments (Optional)'),

              const SizedBox(height: 6),

              buildTextField(
                controller: commentsController,
                hint: 'Enter comments',
              ),

              const SizedBox(height: 20),

              /// ================= INCIDENT =================
              buildMandatoryLabel('Incident Notification in CAA'),

              const SizedBox(height: 10),

              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Head of Information Security'),
                value: headInformationSecurity,
                onChanged: (isClosed || isSubmitting)
                    ? null
                    : (value) {
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
                onChanged: (isClosed || isSubmitting)
                    ? null
                    : (value) {
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
                onChanged: (isClosed || isSubmitting)
                    ? null
                    : (value) {
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
                onChanged: (isClosed || isSubmitting)
                    ? null
                    : (value) {
                        setState(() {
                          headInfrastructure = value ?? false;
                        });
                      },
              ),

              const SizedBox(height: 20),

              /// ================= IDENTIFICATION =================
              buildMandatoryLabel('Identification Measures'),

              const SizedBox(height: 6),

              buildTextField(
                controller: identificationMeasuresController,
                hint: 'Enter identification measures',
                requiredField: true,
              ),

              const SizedBox(height: 20),

              /// ================= EVIDENCE =================
              buildMandatoryLabel('Evidence Collected'),

              const SizedBox(height: 6),

              buildTextField(
                controller: evidenceCollectedController,
                hint: 'Enter evidence collected',
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
              buildMandatoryLabel('Eradication / Mitigation Measures'),

              const SizedBox(height: 6),

              buildTextField(
                controller: eradicationMeasuresController,
                hint: 'Enter mitigation measures',
                requiredField: true,
              ),

              const SizedBox(height: 20),

              /// ================= RECOVERY =================
              buildMandatoryLabel('Recovery Measures'),

              const SizedBox(height: 6),

              buildTextField(
                controller: recoveryMeasuresController,
                hint: 'Enter recovery measures',
                requiredField: true,
              ),

              const SizedBox(height: 20),

              /// ================= OTHER =================
              buildNormalLabel('Other Mitigation Measures'),

              const SizedBox(height: 6),

              buildTextField(
                controller: otherMitigationMeasuresController,
                hint: 'Enter other mitigation measures',
              ),

              const SizedBox(height: 30),

              /// ================= BUTTONS =================
              if (!isClosed)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// CANCEL BUTTON
                    SizedBox(
                      height: 30,
                      child: OutlinedButton(
                        onPressed: isSubmitting
                            ? null
                            : () => Navigator.pop(context),

                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),

                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            color: Color(0xFF0D652D),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// SUBMIT BUTTON
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : onSubmit,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D652D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),

                        child: isSubmitting
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'SUBMIT',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
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
