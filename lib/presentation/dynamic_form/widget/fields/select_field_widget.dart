import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const SelectFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    // ✅ 1. Read current value FIRST
    final currentValue = state.values[field.name];

    // ✅ 2. Build dropdown items
    final items = (field.options ?? [])
        .map(
          (option) => KDropdownItem<dynamic>(
            value: option.value,
            child: Text(option.label),
          ),
        )
        .toList();

    // ✅ 3. Safe value check (VERY IMPORTANT)
    final safeValue = items.any((i) => i.value == currentValue)
        ? currentValue
        : null;

    return KDropdownField<dynamic>(
      isRequired: field.required,
      fieldHeadingText: field.label,
      value: safeValue, // ✅ FIXED
      items: items,
      hintText: field.label,
      errorText: state.errors[field.name],
      onChanged: field.disabled
          ? (_) {}
          : (val) {
              notifier.updateValue(field.name, val);
              field.onChanged?.call(val, ref);
            },
    );
  }
}
