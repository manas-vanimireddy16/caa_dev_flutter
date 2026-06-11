import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_field_label_style.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeFieldWidget extends ConsumerStatefulWidget {
  final DynamicField field;

  const TimeFieldWidget({super.key, required this.field});

  @override
  ConsumerState<TimeFieldWidget> createState() => _TimeFieldWidgetState();
}

class _TimeFieldWidgetState extends ConsumerState<TimeFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TimeOfDay _parseTime(dynamic value) {
    if (value == null) return TimeOfDay.now();
    final s = value.toString().trim();
    if (s.isEmpty) return TimeOfDay.now();
    try {
      final parts = s.split(':');
      if (parts.length >= 2) {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    } catch (_) {}
    return TimeOfDay.now();
  }

  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  Future<void> _pickTime() async {
    if (widget.field.type != FieldType.time) return;
    if (widget.field.disabled) return;

    final notifier = ref.read(dynamicFormProvider.notifier);
    final state = ref.read(dynamicFormProvider);

    final initialTime = _parseTime(state.values[widget.field.name]);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (!mounted || pickedTime == null) return;

    final selectedTime = _formatTimeForApi(pickedTime);

    notifier.updateValue(widget.field.name, selectedTime);
    widget.field.onChanged?.call(selectedTime, ref);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dynamicFormProvider);

    final valueStr = state.values[widget.field.name]?.toString() ?? '';
    if (_controller.text != valueStr) {
      _controller.value = TextEditingValue(
        text: valueStr,
        selection: TextSelection.collapsed(offset: valueStr.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        controller: _controller,
        isRequired: widget.field.required,
        readOnly: true,
        enabled: !widget.field.disabled,
        hintText: widget.field.placeholder ?? 'Select Time',
        fieldHeadingText: widget.field.label,
        fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
        errorText: state.errors[widget.field.name],
        suffixIcon: const Icon(Icons.access_time),
        onSuffixTap: _pickTime,
        enableInteractiveSelection: false,
        onTap: _pickTime,
      ),
    );
  }
}
