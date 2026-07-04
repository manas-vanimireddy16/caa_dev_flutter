part of '../view.dart';

class AttendeeNamesWidget extends ConsumerStatefulWidget {
  final int attendeeCount;
  final Service service;
  final SubService subService;

  const AttendeeNamesWidget({
    super.key,
    required this.attendeeCount,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AttendeeNamesWidget> createState() =>
      _AttendeeNamesWidgetState();
}

class _AttendeeNamesWidgetState extends ConsumerState<AttendeeNamesWidget> {
  late _VSControllerParams _providerArgs;

  void _notifyDynamicFormAttendeesChanged() {
    Future.microtask(() {
      if (!mounted) return;
      final names = ref.read(_vsProvider(_providerArgs)).attendeeNames;
      ref.read(dynamicFormProvider.notifier).autoPopulate({
        '_training_attendees_sig': names.join('\x1e'),
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  void didUpdateWidget(covariant AttendeeNamesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.attendeeCount != widget.attendeeCount) {
      Future.microtask(() {
        final notifier = ref.read(_vsProvider(_providerArgs).notifier);
        final state = ref.read(_vsProvider(_providerArgs));
        final currentCount = state.attendeeNames.length;

        if (widget.attendeeCount < currentCount) {
          final diff = currentCount - widget.attendeeCount;
          for (int i = 0; i < diff; i++) {
            notifier.removeLastAttendee();
          }
          _notifyDynamicFormAttendeesChanged();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final state = ref.watch(_vsProvider(_providerArgs));
    final notifier = ref.read(_vsProvider(_providerArgs).notifier);
    final attendees = state.attendeeNames;

    if (widget.attendeeCount == 0) {
      return const SizedBox.shrink();
    }

    final canAddMore = attendees.length < widget.attendeeCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.nameOfAttendeesLabel,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: attendees.length,
          itemBuilder: (context, index) {
            return Padding(
              key: ValueKey('attendee_row_$index'),
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _AttendeeNameField(
                      key: ValueKey('attendee_field_$index'),
                      initialValue: attendees[index],
                      hintText: l10n.attendeeNameHint(index + 1),
                      minLengthMessage: l10n.transportPassengerNameMinLength,
                      onChanged: (value) {
                        notifier.updateAttendee(index, value);
                        _notifyDynamicFormAttendeesChanged();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (attendees.length > 1)
                    IconButton(
                      onPressed: () {
                        notifier.removeAttendee(index);
                        _notifyDynamicFormAttendeesChanged();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                ],
              ),
            );
          },
        ),
        if (canAddMore) ...[
          const SizedBox(height: 4),
          OutlinedButton.icon(
            onPressed: () {
              notifier.addAttendee();
              _notifyDynamicFormAttendeesChanged();
            },
            icon: const Icon(Icons.person_add_outlined, size: 20),
            label: Text(l10n.addAttendeeName),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0D652D),
              side: const BorderSide(color: Color(0xFF0D652D)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${attendees.length} / ${widget.attendeeCount}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ],
    );
  }
}

class _AttendeeNameField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final String minLengthMessage;
  final ValueChanged<String> onChanged;

  const _AttendeeNameField({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.minLengthMessage,
    required this.onChanged,
  });

  @override
  State<_AttendeeNameField> createState() => _AttendeeNameFieldState();
}

class _AttendeeNameFieldState extends State<_AttendeeNameField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _AttendeeNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text &&
        !_focusNode.hasFocus) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validate(String value) {
    final trimmed = value.trim();
    String? error;
    if (trimmed.isNotEmpty && trimmed.length <= 2) {
      error = widget.minLengthMessage;
    }
    if (_errorText != error) {
      setState(() => _errorText = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorText: _errorText,
      ),
      onChanged: (value) {
        _validate(value);
        widget.onChanged(value);
      },
      onTapOutside: (_) => _validate(_controller.text),
    );
  }
}
