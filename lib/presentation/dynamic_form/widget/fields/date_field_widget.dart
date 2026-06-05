import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateFieldWidget extends ConsumerStatefulWidget {
  final DynamicField field;

  const DateFieldWidget({super.key, required this.field});

  @override
  ConsumerState<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends ConsumerState<DateFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final formState = ref.read(dynamicFormProvider);
    final values = formState.values;

    /// ✅ INITIAL VALUE
    final stateValue = values[widget.field.name]?.toString();

    final initialValue = (stateValue != null && stateValue.isNotEmpty)
        ? stateValue
        : widget.field.initialValue?.toString() ?? '';

    _controller = TextEditingController(text: initialValue);

    /// ✅ SYNC INITIAL VALUE TO STATE
    if ((stateValue == null || stateValue.isEmpty) &&
        widget.field.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref
              .read(dynamicFormProvider.notifier)
              .updateValue(widget.field.name, widget.field.initialValue);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<int?> showYearPickerDialog(
    BuildContext context, {
    required int initialYear,
    int startYear = 1900,
    int endYear = 2100,
  }) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return showDialog<int>(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: currentTheme.colors.primary,
              onPrimary: currentTheme.colors.onPrimary,
            ),
          ),
          child: AlertDialog(
            title: const Text('Select Year'),
            content: SizedBox(
              height: 300,
              width: 300,
              child: YearPicker(
                firstDate: DateTime(startYear),
                lastDate: DateTime(endYear),
                selectedDate: DateTime(initialYear),
                onChanged: (date) {
                  Navigator.pop(context, date.year);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(dynamicFormProvider.notifier);

    final state = ref.watch(dynamicFormProvider);

    final values = state.values;

    /// ✅ DISABLE LOGIC
    final isDisabled =
        widget.field.disabled ||
        (widget.field.disabledWhen?.call(values) ?? false);

    final value = values[widget.field.name]?.toString() ?? '';

    /// ✅ PREVENT CONTROLLER RESET
    if (_controller.text != value) {
      _controller.text = value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        controller: _controller,
        readOnly: true,
        enabled: !isDisabled,
        isRequired: widget.field.required,
        hintText: widget.field.placeholder,
        fieldHeadingText: widget.field.label,
        errorText: state.errors[widget.field.name],
        suffixIcon: const Icon(Icons.calendar_today),

        onTap: isDisabled
            ? null
            : () async {
                /// YEAR PICKER
                if (widget.field.type == FieldType.year) {
                  final year = await showYearPickerDialog(
                    context,
                    initialYear: values[widget.field.name] != null
                        ? int.parse(values[widget.field.name].toString())
                        : DateTime.now().year,
                  );

                  if (year != null) {
                    final selectedYear = year.toString();

                    notifier.updateValue(widget.field.name, selectedYear);
                    widget.field.onChanged?.call(selectedYear, ref);
                  }
                }

                /// DATE PICKER
                if (widget.field.type == FieldType.date) {
                  DateTime initialDate = DateTime.now();

                  final existingValue = values[widget.field.name]?.toString();

                  if (existingValue != null && existingValue.isNotEmpty) {
                    try {
                      initialDate = DateTime.parse(existingValue);
                    } catch (_) {}
                  } else if (widget.field.initialValue != null) {
                    try {
                      initialDate = DateTime.parse(
                        widget.field.initialValue.toString(),
                      );
                    } catch (_) {}
                  }

                  final pickedDate = await KAppX.extendedRouter.showKDatePicker(
                    context: KAppX.currentContext,
                    initialDate: widget.field.initialDate ?? initialDate,
                    firstDate: widget.field.firstDate ?? DateTime(1900),
                    lastDate: widget.field.lastDate ?? DateTime(2100),
                  );

                  if (pickedDate != null) {
                    final selectedDate =
                        pickedDate.formattedDateAsYearMonthDate;

                    notifier.updateValue(widget.field.name, selectedDate);
                    widget.field.onChanged?.call(selectedDate, ref);
                  }
                }
              },
      ),
    );
  }
}
