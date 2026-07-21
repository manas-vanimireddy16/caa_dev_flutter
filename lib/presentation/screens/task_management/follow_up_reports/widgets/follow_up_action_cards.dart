part of '../view.dart';

/// Key used to store the list of follow-up action cards inside the
/// [dynamicFormProvider] values map so it is submitted with the form.
const String kFollowUpActionsKey = 'follow_up_actions';

/// Repeatable "Action" cards rendered as the second step of the follow-up
/// report request form. Each card mirrors the fields from the design:
/// Sent By, Letter Date, Subject, Subject Classification, General Manager's
/// Comment, Response Date, Action Status, Action Taken, Delay Period and an
/// optional Attachment. New cards can be appended with the "Add" button.
class FollowUpActionCards extends ConsumerStatefulWidget {
  const FollowUpActionCards({super.key});

  @override
  ConsumerState<FollowUpActionCards> createState() =>
      _FollowUpActionCardsState();
}

class _FollowUpActionCardsState extends ConsumerState<FollowUpActionCards> {
  final List<_FollowUpActionCardData> _cards = [];

  @override
  void initState() {
    super.initState();

    /// ✅ Re-hydrate cards from the form values (e.g. returning to this step).
    final existing = ref.read(dynamicFormProvider).values[kFollowUpActionsKey];

    if (existing is List && existing.isNotEmpty) {
      for (final raw in existing) {
        if (raw is Map) {
          _cards.add(_FollowUpActionCardData.fromMap(raw));
        }
      }
    }

    if (_cards.isEmpty) {
      _cards.add(_FollowUpActionCardData());
    }

    /// Push the initial serialized list into the form after first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void dispose() {
    for (final card in _cards) {
      card.dispose();
    }
    super.dispose();
  }

  void _sync() {
    if (!mounted) return;
    ref.read(dynamicFormProvider.notifier).autoPopulate({
      kFollowUpActionsKey: _cards.map((c) => c.toMap()).toList(),
    });
  }

  void _addCard() {
    setState(() => _cards.add(_FollowUpActionCardData()));
    _sync();
  }

  void _removeCard(int index) {
    setState(() {
      _cards[index].dispose();
      _cards.removeAt(index);
    });
    _sync();
  }

  Future<void> _pickAttachment(_FollowUpActionCardData card) async {
    const int maxFileSizeInBytes = 10 * 1024 * 1024;

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    if (file.size > maxFileSizeInBytes) {
      Fluttertoast.showToast(msg: 'File size must be less than 10 MB');
      return;
    }

    setState(() {
      card.attachmentName = file.name;
      card.attachmentType = file.extension;
      card.attachmentSize = file.size;
      card.attachmentPath = file.path;
    });
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < _cards.length; i++)
          _FollowUpActionCard(
            key: ValueKey(_cards[i].id),
            index: i,
            card: _cards[i],
            l10n: l10n,
            showRemove: _cards.length > 1,
            onRemove: () => _removeCard(i),
            onChanged: _sync,
            onPickAttachment: () => _pickAttachment(_cards[i]),
          ),
        const SizedBox(height: 4),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: OutlinedButton.icon(
            onPressed: _addCard,
            icon: const Icon(Icons.add, size: 20),
            label: Text(l10n.followUpAddAction),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0D652D),
              side: const BorderSide(color: Color(0xFF0D652D)),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// A single action card containing all the fields.
class _FollowUpActionCard extends StatefulWidget {
  final int index;
  final _FollowUpActionCardData card;
  final DashboardL10n l10n;
  final bool showRemove;
  final VoidCallback onRemove;
  final VoidCallback onChanged;
  final VoidCallback onPickAttachment;

  const _FollowUpActionCard({
    super.key,
    required this.index,
    required this.card,
    required this.l10n,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
    required this.onPickAttachment,
  });

  @override
  State<_FollowUpActionCard> createState() => _FollowUpActionCardState();
}

class _FollowUpActionCardState extends State<_FollowUpActionCard> {
  DashboardL10n get l10n => widget.l10n;
  _FollowUpActionCardData get card => widget.card;

  List<DropdownOption<String>> get _sentByOptions => [
    DropdownOption(label: l10n.followUpSentByLetter, value: 'Letter'),
    DropdownOption(label: l10n.followUpSentByEmail, value: 'Email'),
    DropdownOption(label: l10n.followUpSentByInstruction, value: 'Instruction'),
    DropdownOption(label: l10n.followUpSentByMinutes, value: 'Minutes (Meeting)'),
    DropdownOption(label: l10n.followUpSentByOther, value: 'Other'),
  ];

  List<DropdownOption<String>> get _subjectClassificationOptions => [
    DropdownOption(label: l10n.followUpNormal, value: 'Normal'),
    DropdownOption(label: l10n.followUpImportant, value: 'Important'),
    DropdownOption(label: l10n.followUpUrgent, value: 'Urgent'),
    DropdownOption(label: l10n.followUpVeryUrgent, value: 'Very Urgent'),
    DropdownOption(label: l10n.followUpConfidential, value: 'Confidential'),
    DropdownOption(
      label: l10n.followUpHighlyConfidential,
      value: 'Highly Confidential',
    ),
    DropdownOption(label: l10n.followUpRestricted, value: 'Restricted'),
    DropdownOption(label: l10n.followUpLimited, value: 'Limited'),
  ];

  List<DropdownOption<String>> get _generalManagerCommentOptions => [
    DropdownOption(
      label: l10n.followUpGmReviewAction,
      value: 'For Review and Necessary Action',
    ),
    DropdownOption(label: l10n.followUpGmInformation, value: 'For Information'),
    DropdownOption(label: l10n.followUpGmFollowUp, value: 'Follow-up'),
    DropdownOption(
      label: l10n.followUpGmNecessaryAction,
      value: 'For necessary action as applicable',
    ),
  ];

  List<DropdownOption<String>> get _responseDateOptions => [
    DropdownOption(label: l10n.followUpResponse10Days, value: '10 days'),
    DropdownOption(label: l10n.followUpResponse7Days, value: '7 Days'),
    DropdownOption(label: l10n.followUpResponse2Weeks, value: '2 Weeks'),
    DropdownOption(
      label: l10n.followUpResponse1WeekTo1Month,
      value: '1 Week - 1 Month',
    ),
  ];

  /// Action Status options carry a color to match the design.
  List<_StatusOption> get _actionStatusOptions => [
    _StatusOption(
      label: l10n.followUpStatusNoResponse,
      value: 'No Response',
      color: const Color(0xFFE53935),
    ),
    _StatusOption(
      label: l10n.followUpStatusCompleted,
      value: 'Completed',
      color: const Color(0xFF43A047),
    ),
    _StatusOption(
      label: l10n.followUpStatusInProgress,
      value: 'In Progress',
      color: const Color(0xFFF9A825),
    ),
    _StatusOption(
      label: l10n.followUpStatusOverdue,
      value: 'Overdue',
      color: const Color(0xFF757575),
    ),
  ];

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();
    if ((card.letterDate ?? '').isNotEmpty) {
      try {
        initialDate = DateTime.parse(card.letterDate!);
      } catch (_) {}
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final y = picked.year.toString().padLeft(4, '0');
      final m = picked.month.toString().padLeft(2, '0');
      final d = picked.day.toString().padLeft(2, '0');
      setState(() => card.letterDate = '$y-$m-$d');
      widget.onChanged();
    }
  }

  String get _letterDateDisplay {
    final value = card.letterDate;
    if (value == null || value.isEmpty) return '';
    final parts = value.split('-');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[1]}-${parts[0]}';
    }
    return value;
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<DropdownOption<String>> options,
    required ValueChanged<String?> onChanged,
    bool required = true,
  }) {
    return KDropdownField<String>(
      isExpanded: true,
      isRequired: required,
      fieldHeadingText: label,
      fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
      value: value,
      hintText: l10n.followUpSelect,
      items: options
          .map(
            (o) => KDropdownItem<String>(
              value: o.value,
              child: Text(o.label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE6E6EA)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => card.expanded = !card.expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    card.expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.followUpActionCardTitle(widget.index + 1),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (!card.expanded &&
                            card.subjectController.text.trim().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              card.subjectController.text.trim(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.showRemove)
                    IconButton(
                      onPressed: widget.onRemove,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFE53935),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (card.expanded) ...[
            const SizedBox(height: 8),

            /// 1. Sent By
            _dropdown(
            label: l10n.followUpSentByFieldLabel,
            value: card.sentBy,
            options: _sentByOptions,
            onChanged: (v) {
              setState(() => card.sentBy = v);
              widget.onChanged();
            },
          ),

          /// 2. Letter Date
          KTextField(
            controller: card.letterDateController..text = _letterDateDisplay,
            readOnly: true,
            isRequired: true,
            fieldHeadingText: l10n.letterDate,
            fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
            hintText: 'dd-mm-yyyy',
            suffixIcon: const Icon(Icons.calendar_today, size: 18),
            onTap: _pickDate,
            onSuffixTap: _pickDate,
          ),
          const SizedBox(height: 15),

          /// 3. Subject
          KTextField(
            controller: card.subjectController,
            isRequired: true,
            fieldHeadingText: l10n.subject,
            fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
            hintText: l10n.followUpEnterSubject,
            onChanged: (_) => widget.onChanged(),
          ),
          const SizedBox(height: 15),

          /// 4. Subject Classification
          _dropdown(
            label: l10n.subjectClassification,
            value: card.subjectClassification,
            options: _subjectClassificationOptions,
            onChanged: (v) {
              setState(() => card.subjectClassification = v);
              widget.onChanged();
            },
          ),

          /// 5. General Manager's Comment
          _dropdown(
            label: l10n.followUpGeneralManagerCommentLabel,
            value: card.generalManagerComment,
            options: _generalManagerCommentOptions,
            onChanged: (v) {
              setState(() => card.generalManagerComment = v);
              widget.onChanged();
            },
          ),

          /// 6. Response Date (Target Date)
          _dropdown(
            label: l10n.followUpResponseDateLabel,
            value: card.responseDate,
            options: _responseDateOptions,
            onChanged: (v) {
              setState(() => card.responseDate = v);
              widget.onChanged();
            },
          ),

          /// 7. Action Status (color coded)
          KDropdownField<String>(
            isExpanded: true,
            isRequired: true,
            fieldHeadingText: l10n.followUpActionStatusLabel,
            fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
            value: card.actionStatus,
            hintText: l10n.followUpSelect,
            items: _actionStatusOptions
                .map(
                  (o) => KDropdownItem<String>(
                    value: o.value,
                    child: Text(
                      o.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: o.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() => card.actionStatus = v);
              widget.onChanged();
            },
          ),

          /// 8. Action Taken
          KTextField(
            controller: card.actionTakenController,
            isRequired: true,
            fieldHeadingText: l10n.followUpActionTakenLabel,
            fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
            hintText: l10n.followUpEnterActionTaken,
            onChanged: (_) => widget.onChanged(),
          ),
          const SizedBox(height: 15),

          /// 9. Delay Period (auto, read-only)
          KTextField(
            controller: card.delayPeriodController,
            readOnly: true,
            enabled: false,
            fieldHeadingText: l10n.followUpDelayPeriodLabel,
            fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
          ),
          const SizedBox(height: 15),

            /// 10. Attachment (optional)
            _AttachmentField(
              label: l10n.followUpAttachmentOptionalLabel,
              uploadLabel: l10n.followUpUpload,
              fileName: card.attachmentName,
              onUpload: widget.onPickAttachment,
              onRemove: () {
                setState(() {
                  card.attachmentName = null;
                  card.attachmentType = null;
                  card.attachmentSize = null;
                  card.attachmentPath = null;
                });
                widget.onChanged();
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _AttachmentField extends StatelessWidget {
  final String label;
  final String uploadLabel;
  final String? fileName;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  const _AttachmentField({
    required this.label,
    required this.uploadLabel,
    required this.fileName,
    required this.onUpload,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: DynamicFieldLabelStyle.text),
        const SizedBox(height: 8),
        if (fileName == null)
          OutlinedButton.icon(
            onPressed: onUpload,
            icon: const Icon(Icons.upload_file, size: 18),
            label: Text(uploadLabel),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0D652D),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fileName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: onRemove,
                  child: const Icon(Icons.close, size: 18),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _StatusOption {
  final String label;
  final String value;
  final Color color;

  const _StatusOption({
    required this.label,
    required this.value,
    required this.color,
  });
}

/// Holds the mutable state (controllers + selections) for one action card.
class _FollowUpActionCardData {
  final String id;
  final TextEditingController subjectController;
  final TextEditingController actionTakenController;
  final TextEditingController letterDateController;
  final TextEditingController delayPeriodController;

  String? sentBy;
  String? letterDate;
  String? subjectClassification;
  String? generalManagerComment;
  String? responseDate;
  String? actionStatus;
  String delayPeriod;

  String? attachmentName;
  String? attachmentType;
  int? attachmentSize;
  String? attachmentPath;

  /// UI-only: whether this card is expanded (fields visible).
  bool expanded = true;

  _FollowUpActionCardData({
    String? id,
    this.sentBy,
    this.letterDate,
    String? subject,
    this.subjectClassification,
    this.generalManagerComment,
    this.responseDate,
    this.actionStatus,
    String? actionTaken,
    this.delayPeriod = '0',
    this.attachmentName,
    this.attachmentType,
    this.attachmentSize,
    this.attachmentPath,
  }) : id = id ?? UniqueKey().toString(),
       subjectController = TextEditingController(text: subject ?? ''),
       actionTakenController = TextEditingController(text: actionTaken ?? ''),
       letterDateController = TextEditingController(),
       delayPeriodController = TextEditingController(
         text: delayPeriod,
       );

  factory _FollowUpActionCardData.fromMap(Map<dynamic, dynamic> map) {
    return _FollowUpActionCardData(
      sentBy: map['sent_by'] as String?,
      letterDate: map['letter_date'] as String?,
      subject: map['subject'] as String?,
      subjectClassification: map['subject_classification'] as String?,
      generalManagerComment: map['general_manager_comment'] as String?,
      responseDate: map['response_date'] as String?,
      actionStatus: map['action_status'] as String?,
      actionTaken: map['action_taken'] as String?,
      delayPeriod: (map['delay_period'] ?? '0').toString(),
      attachmentName: (map['attachment'] as Map?)?['file_name'] as String?,
      attachmentType: (map['attachment'] as Map?)?['file_type'] as String?,
      attachmentSize: (map['attachment'] as Map?)?['file_size'] as int?,
      attachmentPath: (map['attachment'] as Map?)?['file_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sent_by': sentBy ?? '',
      'letter_date': letterDate ?? '',
      'subject': subjectController.text.trim(),
      'subject_classification': subjectClassification ?? '',
      'general_manager_comment': generalManagerComment ?? '',
      'response_date': responseDate ?? '',
      'action_status': actionStatus ?? '',
      'action_taken': actionTakenController.text.trim(),
      'delay_period': delayPeriod,
      'attachment': attachmentPath == null
          ? null
          : {
              'file_name': attachmentName,
              'file_type': attachmentType,
              'file_size': attachmentSize,
              'file_url': attachmentPath,
              'path': attachmentPath,
            },
    };
  }

  /// Every required field (attachment + delay period excluded) must be set.
  bool get isComplete {
    return (sentBy ?? '').isNotEmpty &&
        (letterDate ?? '').isNotEmpty &&
        subjectController.text.trim().isNotEmpty &&
        (subjectClassification ?? '').isNotEmpty &&
        (generalManagerComment ?? '').isNotEmpty &&
        (responseDate ?? '').isNotEmpty &&
        (actionStatus ?? '').isNotEmpty &&
        actionTakenController.text.trim().isNotEmpty;
  }

  void dispose() {
    subjectController.dispose();
    actionTakenController.dispose();
    letterDateController.dispose();
    delayPeriodController.dispose();
  }
}
