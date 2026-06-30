import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_field_label_style.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_form_dropdown_constants.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
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
    final l10n = DashboardL10n.of(context);

    final isDisabled =
        field.disabled || (field.disabledWhen?.call(values) ?? false);

    dynamic stateValue = values[field.name];
    if (stateValue is DropdownOption) {
      stateValue = stateValue.value;
    }

    dynamic initial = field.initialValue;
    if (initial is DropdownOption) {
      initial = initial.value;
    }

    final effectiveValue = stateValue ?? initial;

    if (stateValue == null && initial != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.updateValue(field.name, initial);
      });
    }

    final options = field.optionsBuilder != null
        ? field.optionsBuilder!(ref)
        : (field.options ?? []);

    final safeValue = options.any((option) => option.value == effectiveValue)
        ? effectiveValue
        : null;

    void updateValue(dynamic value) {
      if (isDisabled) return;
      notifier.updateValue(field.name, value);
      field.onChanged?.call(value, ref);
    }

    if (dynamicFormDropdownNeedsSearch(options.length)) {
      return _SearchableSelectField(
        field: field,
        options: options.cast<DropdownOption>(),
        selectedValue: safeValue,
        isDisabled: isDisabled,
        errorText: state.errors[field.name],
        hintText: field.placeholder ?? field.label,
        l10n: l10n,
        onSelected: updateValue,
      );
    }

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

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1,
        child: KDropdownField<dynamic>(
          isExpanded: true,
          isRequired: field.required,
          fieldHeadingText: field.label,
          fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
          value: safeValue,
          items: items,
          hintText: field.placeholder ?? field.label,
          errorText: state.errors[field.name],
          onChanged: updateValue,
        ),
      ),
    );
  }
}

class _SearchableSelectField extends StatelessWidget {
  const _SearchableSelectField({
    required this.field,
    required this.options,
    required this.selectedValue,
    required this.isDisabled,
    required this.errorText,
    required this.hintText,
    required this.l10n,
    required this.onSelected,
  });

  final DynamicField field;
  final List<DropdownOption> options;
  final dynamic selectedValue;
  final bool isDisabled;
  final String? errorText;
  final String hintText;
  final DashboardL10n l10n;
  final ValueChanged<dynamic> onSelected;

  String? get _selectedLabel {
    for (final option in options) {
      if (option.value == selectedValue) {
        return option.label;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final selectedLabel = _selectedLabel;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (field.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: RichText(
                text: TextSpan(
                  text: field.label,
                  style: DynamicFieldLabelStyle.text,
                  children: field.required
                      ? [
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ]
                      : [],
                ),
              ),
            ),
          GestureDetector(
            onTap: isDisabled
                ? null
                : () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => _SingleSelectSheet(
                        fieldLabel: field.label,
                        options: options,
                        selectedValue: selectedValue,
                        l10n: l10n,
                        onSelected: (value) {
                          onSelected(value);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(
                  color: errorText != null
                      ? Colors.red
                      : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedLabel ?? hintText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedLabel == null
                            ? Colors.grey.shade600
                            : Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class _SingleSelectSheet extends StatefulWidget {
  const _SingleSelectSheet({
    required this.fieldLabel,
    required this.options,
    required this.selectedValue,
    required this.l10n,
    required this.onSelected,
  });

  final String fieldLabel;
  final List<DropdownOption> options;
  final dynamic selectedValue;
  final DashboardL10n l10n;
  final ValueChanged<dynamic> onSelected;

  @override
  State<_SingleSelectSheet> createState() => _SingleSelectSheetState();
}

class _SingleSelectSheetState extends State<_SingleSelectSheet> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.options.where((option) {
      return option.label.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .75,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fieldLabel,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: widget.l10n.dynamicFormSearchHint,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => search = value),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, index) {
                        final option = filtered[index];
                        final isSelected = option.value == widget.selectedValue;

                        return ListTile(
                          title: Text(option.label),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                          onTap: () => widget.onSelected(option.value),
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
