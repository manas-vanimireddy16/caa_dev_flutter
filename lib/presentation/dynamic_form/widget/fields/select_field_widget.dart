// import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
// import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
// import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SelectFieldWidget extends ConsumerWidget {
//   final DynamicField field;

//   const SelectFieldWidget({super.key, required this.field});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(dynamicFormProvider);
//     final notifier = ref.read(dynamicFormProvider.notifier);

//     // ✅ 1. Read current value FIRST
//     final currentValue = state.values[field.name];

//     // ✅ 2. Build dropdown items
//     final items = (field.options ?? [])
//         .map(
//           (option) => KDropdownItem<dynamic>(
//             value: option.value,
//             child: Text(option.label),
//           ),
//         )
//         .toList();

//     // ✅ 3. Safe value check (VERY IMPORTANT)
//     final safeValue = items.any((i) => i.value == currentValue)
//         ? currentValue
//         : null;

//     return KDropdownField<dynamic>(
//       isRequired: field.required,
//       fieldHeadingText: field.label,
//       value: safeValue, // ✅ FIXED
//       items: items,
//       hintText: field.label,
//       errorText: state.errors[field.name],
//       onChanged: field.disabled
//           ? (_) {}
//           : (val) {
//               /// 1️⃣ update form state
//               notifier.updateValue(field.name, val);

//               /// 2️⃣ trigger field-level onChanged (IMPORTANT FIX)
//               if (field.onChanged != null) {
//                 field.onChanged!(val, ref);
//               }
//             },
//     );
//   }
// }

// import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
// import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
// import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SelectFieldWidget extends ConsumerWidget {
//   final DynamicField field;

//   const SelectFieldWidget({super.key, required this.field});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(dynamicFormProvider);
//     final notifier = ref.read(dynamicFormProvider.notifier);

//     final values = state.values;

//     /// ✅ 🔥 DYNAMIC DISABLE SUPPORT
//     final isDisabled =
//         field.disabled || (field.disabledWhen?.call(values) ?? false);

//     /// ✅ 1. GET VALUE (STATE FIRST → INITIAL VALUE FALLBACK)
//     final stateValue = values[field.name];
//     final effectiveValue = stateValue ?? field.initialValue;

//     /// ✅ 2. BUILD ITEMS
//     final items = (field.options ?? [])
//         .map(
//           (option) => KDropdownItem<dynamic>(
//             value: option.value,
//             child: Text(option.label),
//           ),
//         )
//         .toList();

//     /// ✅ 3. SAFE VALUE CHECK (IMPORTANT)
//     final safeValue = items.any((i) => i.value == effectiveValue)
//         ? effectiveValue
//         : null;

//     /// ✅ 4. SYNC INITIAL VALUE INTO STATE (ONCE)
//     if (stateValue == null && field.initialValue != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         notifier.updateValue(field.name, field.initialValue);
//       });
//     }

//     return KDropdownField<dynamic>(
//       isRequired: field.required,
//       fieldHeadingText: field.label,
//       value: safeValue,
//       items: items,
//       hintText: field.placeholder ?? field.label,
//       errorText: state.errors[field.name],

//       /// 🔥 UPDATED
//       onChanged: (val) {
//         if (isDisabled) return;

//         notifier.updateValue(field.name, val);

//         if (field.onChanged != null) {
//           field.onChanged!(val, ref);
//         }
//       },
//     );
//   }
// }

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

    final values = state.values;

    /// ✅ DYNAMIC DISABLE
    final isDisabled =
        field.disabled || (field.disabledWhen?.call(values) ?? false);

    /// ✅ VALUE FROM STATE
    dynamic stateValue = values[field.name];

    if (stateValue is DropdownOption) {
      stateValue = stateValue.value;
    }

    /// ✅ INITIAL VALUE
    dynamic initial = field.initialValue;

    if (initial is DropdownOption) {
      initial = initial.value;
    }

    /// ✅ FINAL VALUE FOR UI
    final effectiveValue = stateValue ?? initial;

    /// 🔥 FIX: SYNC INITIAL VALUE INTO STATE (ONLY ONCE)
    if (stateValue == null && initial != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.updateValue(field.name, initial);
      });
    }

    /// ✅ DYNAMIC OPTIONS SUPPORT
    final options = field.optionsBuilder != null
        ? field.optionsBuilder!(ref)
        : (field.options ?? []);

    /// ✅ BUILD ITEMS
    final items = options
        .map(
          (option) => KDropdownItem<dynamic>(
            value: option.value,
            child: Text(
              option.label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        )
        .toList();

    /// ✅ SAFE VALUE
    final safeValue = items.any((i) => i.value == effectiveValue)
        ? effectiveValue
        : null;

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1,
        child: KDropdownField<dynamic>(
          isExpanded: true,
          isRequired: field.required,
          fieldHeadingText: field.label,
          value: safeValue,
          items: items,
          hintText: field.placeholder ?? field.label,
          errorText: state.errors[field.name],
          onChanged: (val) {
            if (isDisabled) return;

            notifier.updateValue(field.name, val);

            field.onChanged?.call(val, ref);
          },
        ),
      ),
    );
  }
}
