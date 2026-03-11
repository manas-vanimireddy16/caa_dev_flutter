import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const TimeFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dynamicFormProvider.notifier);
    final state = ref.watch(dynamicFormProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        controller: TextEditingController(
          text: state.values[field.name]?.toString() ?? '',
        ),
        isRequired: field.required,
        readOnly: true,
        enabled: !field.disabled,
        hintText: field.placeholder ?? 'Select Time',
        fieldHeadingText: field.label,
        errorText: state.errors[field.name],
        suffixIcon: const Icon(Icons.access_time),

        onTap: () async {
          if (field.type != FieldType.time) return;

          final initialTime = state.values[field.name] != null
              ? _parseTime(state.values[field.name])
              : TimeOfDay.now();

          final pickedTime = await showTimePicker(
            context: context,
            initialTime: initialTime,
          );

          if (pickedTime != null) {
            final formattedTime = _formatTimeForApi(pickedTime); // HH:mm:ss

            notifier.updateValue(field.name, formattedTime);
          }
        },
      ),
    );
  }

  /// Converts stored `HH:mm:ss` → TimeOfDay
  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  /// Converts TimeOfDay → `HH:mm:ss`
  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }
}
