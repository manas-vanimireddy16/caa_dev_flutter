import 'package:code_setup/presentation/dynamic_form/models/acknowledgement_item.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_field_label_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcknowledgementFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const AcknowledgementFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final items =
        (state.values[field.name] as List<AcknowledgementItem>?) ??
        field.acknowledgements ??
        [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.label ?? '', style: DynamicFieldLabelStyle.text),

        ...items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ KEY CHANGE
            children: [
              Checkbox(
                value: item.isChecked,
                onChanged: (val) async {
                  if (item.hasAction && item.isChecked == false) {
                    final accepted = await item.onTap?.call(context);

                    if (accepted == true) {
                      final updatedItems = items.map((e) {
                        if (e.id == item.id) {
                          return AcknowledgementItem(
                            id: e.id,
                            text: e.text,
                            isRequired: e.isRequired,
                            hasAction: e.hasAction,
                            onTap: e.onTap,
                            isChecked: true,
                          );
                        }
                        return e;
                      }).toList();

                      notifier.updateValue(field.name, updatedItems);
                    }

                    return;
                  }

                  final updatedItems = items.map((e) {
                    if (e.id == item.id) {
                      return AcknowledgementItem(
                        id: e.id,
                        text: e.text,
                        isRequired: e.isRequired,
                        hasAction: e.hasAction,
                        onTap: e.onTap,
                        isChecked: val ?? false,
                      );
                    }
                    return e;
                  }).toList();

                  notifier.updateValue(field.name, updatedItems);
                },
              ),

              /// 🔥 IMPORTANT: Expanded + Align
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: item.hasAction
                        ? () async {
                            final accepted = await item.onTap?.call(context);

                            if (accepted == true) {
                              final updatedItems = items.map((e) {
                                if (e.id == item.id) {
                                  return AcknowledgementItem(
                                    id: e.id,
                                    text: e.text,
                                    isRequired: e.isRequired,
                                    hasAction: e.hasAction,
                                    onTap: e.onTap,
                                    isChecked: true,
                                  );
                                }
                                return e;
                              }).toList();

                              notifier.updateValue(field.name, updatedItems);
                            }
                          }
                        : null,
                    child: Text(
                      item.text,
                      style: TextStyle(
                        color: item.hasAction ? Colors.blue : Colors.black,
                        decoration: item.hasAction
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),

        /// ✅ ERROR TEXT
        if (state.errors[field.name] != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              state.errors[field.name]!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
