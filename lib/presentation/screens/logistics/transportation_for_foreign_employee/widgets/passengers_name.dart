part of '../view.dart';

class PassengerNamesWidget extends ConsumerStatefulWidget {
  final int passengerCount;
  final Service service;
  final SubService subService;

  const PassengerNamesWidget({
    super.key,
    required this.passengerCount,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<PassengerNamesWidget> createState() =>
      _PassengerNamesWidgetState();
}

class _PassengerNamesWidgetState extends ConsumerState<PassengerNamesWidget> {
  late _VSControllerParams _providerArgs;

  void _notifyDynamicFormPassengersChanged() {
    Future.microtask(() {
      if (!mounted) return;
      final s = ref.read(_vsProvider(_providerArgs));
      ref.read(dynamicFormProvider.notifier).autoPopulate({
        '_transport_passengers_sig': s.passengerNames.join('\x1e'),
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
  void didUpdateWidget(covariant PassengerNamesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.passengerCount != widget.passengerCount) {
      Future.microtask(() {
        final notifier = ref.read(_vsProvider(_providerArgs).notifier);
        final state = ref.read(_vsProvider(_providerArgs));
        final currentCount = state.passengerNames.length;

        if (widget.passengerCount < currentCount) {
          final diff = currentCount - widget.passengerCount;
          for (int i = 0; i < diff; i++) {
            notifier.removeLastPassenger();
          }
          _notifyDynamicFormPassengersChanged();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final state = ref.watch(_vsProvider(_providerArgs));
    final notifier = ref.read(_vsProvider(_providerArgs).notifier);
    final passengers = state.passengerNames;

    if (widget.passengerCount == 0) {
      return const SizedBox.shrink();
    }

    final canAddMore = passengers.length < widget.passengerCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.transportPassengerNameSection,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: passengers.length,
          itemBuilder: (context, index) {
            return Padding(
              key: ValueKey('passenger_row_$index'),
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _PassengerNameField(
                      key: ValueKey('passenger_field_$index'),
                      initialValue: passengers[index],
                      hintText: l10n.transportPassengerNameHint(index + 1),
                      minLengthMessage: l10n.transportPassengerNameMinLength,
                      onChanged: (value) {
                        notifier.updatePassenger(index, value);
                        _notifyDynamicFormPassengersChanged();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (passengers.length > 1)
                    IconButton(
                      onPressed: () {
                        notifier.removePassenger(index);
                        _notifyDynamicFormPassengersChanged();
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
              notifier.addPassenger();
              _notifyDynamicFormPassengersChanged();
            },
            icon: const Icon(Icons.person_add_outlined, size: 20),
            label: Text(l10n.transportAddPassenger),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0D652D),
              side: const BorderSide(color: Color(0xFF0D652D)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${passengers.length} / ${widget.passengerCount}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ],
    );
  }
}

class _PassengerNameField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final String minLengthMessage;
  final ValueChanged<String> onChanged;

  const _PassengerNameField({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.minLengthMessage,
    required this.onChanged,
  });

  @override
  State<_PassengerNameField> createState() => _PassengerNameFieldState();
}

class _PassengerNameFieldState extends State<_PassengerNameField> {
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
  void didUpdateWidget(covariant _PassengerNameField oldWidget) {
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
