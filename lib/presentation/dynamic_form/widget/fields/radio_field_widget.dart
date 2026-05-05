import 'package:code_setup/presentation/common_widgets/radio_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/dynamic_field.dart';

// class RadioFieldWidget extends ConsumerWidget {
//   final DynamicField field;

//   const RadioFieldWidget({super.key, required this.field});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(dynamicFormProvider);
//     final notifier = ref.read(dynamicFormProvider.notifier);

//     final selectedValue = state.values[field.name];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         KRadioGroup<String>(
//           errorText: state.errors[field.name],
//           title: field.label,
//           isRequired: field.required,
//           options: field.options!
//               .map(
//                 (opt) =>
//                     KRadioOption(value: opt as String, label: opt.toString()),
//               )
//               .toList(),
//           selectedValue: selectedValue,
//           onChanged: field.disabled
//               ? (val) {}
//               : (dynamic val) {
//                   notifier.updateValue(field.name, val);
//                 },
//         ),
//       ],
//     );

//     // return Padding(
//     //   padding: const EdgeInsets.only(bottom: 16),
//     //   child: Column(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: [
//     //       Text(
//     //         field.label,
//     //         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//     //       ),
//     //       const SizedBox(height: 8),

//     //       ...field.options!.map((opt) {
//     //         return RadioListTile<dynamic>(
//     //           value: opt,
//     //           groupValue: selectedValue,
//     //           title: Text(opt.toString()),
//     //           dense: true,
//     //           contentPadding: EdgeInsets.zero,
//     //           onChanged: field.disabled
//     //               ? null
//     //               : (dynamic val) {
//     //                   notifier.updateValue(field.name, val);
//     //                 },
//     //         );
//     //       }).toList(),

//     //       if (state.errors[field.name] != null)
//     //         Padding(
//     //           padding: const EdgeInsets.only(left: 16, top: 4),
//     //           child: Text(
//     //             state.errors[field.name]!,
//     //             style: const TextStyle(color: Colors.red, fontSize: 12),
//     //           ),
//     //         ),
//     //     ],
//     //   ),
//     // );
//   }
// }

// class RadioFieldWidget extends ConsumerWidget {
//   final DynamicField field;

//   const RadioFieldWidget({super.key, required this.field});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(dynamicFormProvider);
//     final notifier = ref.read(dynamicFormProvider.notifier);

//     final selectedValue = state.values[field.name];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         KRadioGroup<String>(
//           errorText: state.errors[field.name],
//           title: field.label,
//           isRequired: field.required,
//           options: field.options!
//               .map(
//                 (opt) =>
//                     KRadioOption(value: opt as String, label: opt.toString()),
//               )
//               .toList(),
//           selectedValue: selectedValue,
//           onChanged: field.disabled
//               ? (val) {}
//               : (dynamic val) {
//                   /// ⭐ Update form value
//                   notifier.updateValue(field.name, val);

//                   /// ⭐ Trigger field callback if exists
//                   field.onChanged?.call(val, ref);
//                 },
//         ),
//       ],
//     );
//   }
// }
class RadioFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const RadioFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final disabledOptions = field.disabledOptions ?? [];
    final values = state.values;

    final isDisabled =
        field.disabled || (field.disabledWhen?.call(values) ?? false);

    final stateValue = values[field.name];

    final effectiveValue = stateValue != null
        ? stateValue.toString()
        : field.initialValue?.toString();

    /// 🔥 Sync initial value once
    if (stateValue == null && field.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.updateValue(field.name, field.initialValue);
      });
    }

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KRadioGroup<String>(
              errorText: state.errors[field.name],
              title: field.label,
              isRequired: field.required,

              options: field.options!
                  .map(
                    (opt) => KRadioOption<String>(
                      value: opt.toString(),
                      label: opt.toString(),
                      isDisabled: disabledOptions.contains(
                        opt.toString(),
                      ), // ✅ KEY
                    ),
                  )
                  .toList(),

              selectedValue: effectiveValue,

              onChanged: (val) {
                if (isDisabled) return;

                /// 🚫 prevent selecting disabled option
                if (disabledOptions.contains(val)) return;

                notifier.updateValue(field.name, val);

                field.onChanged?.call(val, ref);
              },
            ),
          ],
        ),
      ),
    );
  }
}
