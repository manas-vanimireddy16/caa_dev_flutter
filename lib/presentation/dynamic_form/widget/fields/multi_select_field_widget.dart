import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_field_label_style.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiSelectDropdownFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const MultiSelectDropdownFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);
    final l10n = DashboardL10n.of(context);

    final List<dynamic> selectedValues =
        (state.values[field.name] as List?) ?? [];

    final options = field.options ?? [];

    final selectedOptions = options
        .where((o) => selectedValues.contains(o.value))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // 🔥 FIX
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LABEL
          if (field.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                field.label,
                style: DynamicFieldLabelStyle.text,
              ),
            ),

          /// FIELD UI
          GestureDetector(
            onTap: field.disabled
                ? null
                : () {
                    _openMultiSelectSheet(
                      context,
                      ref,
                      field,
                      selectedValues,
                      l10n,
                    );
                  },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: state.errors[field.name] != null
                      ? Colors.red
                      : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: selectedOptions.isEmpty
                  ? Text(
                      l10n.dynamicFormMultiSelectHint(field.label),
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// SELECTED COUNT
                        Text(
                          l10n.dynamicFormMultiSelectCount(
                            selectedOptions.length,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// CHIPS
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: selectedOptions
                              .map((o) => Chip(label: Text(o.label)))
                              .toList(),
                        ),
                      ],
                    ),
            ),
          ),

          /// ERROR
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

  /// ================= BOTTOM SHEET =================

  void _openMultiSelectSheet(
    BuildContext context,
    WidgetRef ref,
    DynamicField field,
    List<dynamic> selectedValues,
    DashboardL10n l10n,
  ) {
    final notifier = ref.read(dynamicFormProvider.notifier);
    final options = field.options ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return _MultiSelectSheet(
          field: field,
          options: options,
          selectedValues: selectedValues,
          l10n: l10n,
          onChanged: (newList) {
            notifier.updateValue(field.name, newList);

            field.onChanged?.call(newList, ref);
          },
        );
      },
    );
  }
}

/// ================= SHEET =================

class _MultiSelectSheet extends StatefulWidget {
  final DynamicField field;
  final List options;
  final List<dynamic> selectedValues;
  final Function(List<dynamic>) onChanged;
  final DashboardL10n l10n;

  const _MultiSelectSheet({
    required this.field,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.l10n,
  });

  @override
  State<_MultiSelectSheet> createState() => _MultiSelectSheetState();
}

class _MultiSelectSheetState extends State<_MultiSelectSheet> {
  late List<dynamic> tempSelected;
  String search = "";

  @override
  void initState() {
    tempSelected = List.from(widget.selectedValues);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.options.where((o) {
      return o.label.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .75,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// TITLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.l10n.dynamicFormMultiSelectHint(widget.field.label),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onChanged(tempSelected);
                    Navigator.pop(context);
                  },
                  child: Text(widget.l10n.dynamicFormMultiSelectDone),
                ),
              ],
            ),

            /// SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: widget.l10n.dynamicFormSearchHint,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (v) {
                setState(() {
                  search = v;
                });
              },
            ),

            const SizedBox(height: 10),

            /// LIST
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final option = filtered[i];
                  final selected = tempSelected.contains(option.value);

                  return CheckboxListTile(
                    value: selected,
                    title: Text(option.label),
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          tempSelected.add(option.value);
                        } else {
                          tempSelected.remove(option.value);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
