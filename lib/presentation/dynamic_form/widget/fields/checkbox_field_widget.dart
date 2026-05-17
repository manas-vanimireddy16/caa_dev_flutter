import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const CheckboxFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final List values = state.values[field.name] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.label),
        ...field.options!.map((opt) {
          final String value;
          final String label;
          if (opt is DropdownOption) {
            value = opt.value.toString();
            label = opt.label;
          } else {
            value = opt.toString();
            label = opt.toString();
          }

          final checked = values.contains(value);
          return CheckboxListTile(
            value: checked,
            title: Text(label),
            onChanged: (val) {
              final updated = [...values];
              if (val == true) {
                updated.add(value);
              } else {
                updated.remove(value);
              }
              notifier.updateValue(field.name, updated);
            },
          );
        }),
      ],
    );
  }
}
