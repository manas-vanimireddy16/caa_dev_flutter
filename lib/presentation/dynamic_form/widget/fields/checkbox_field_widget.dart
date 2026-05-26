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

    /// ✅ REQUIRED LOGIC
    final isRequired =
        field.required || (field.requiredWhen?.call(state.values) ?? false);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ LABEL WITH REQUIRED STAR
          RichText(
            text: TextSpan(
              text: field.label,
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

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
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
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

          /// ✅ ERROR TEXT
          if (state.errors[field.name] != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                state.errors[field.name]!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
