import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_field_label_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/dynamic_field.dart';

class NumberFieldWidget extends ConsumerStatefulWidget {
  final DynamicField field;

  const NumberFieldWidget({super.key, required this.field});

  @override
  ConsumerState<NumberFieldWidget> createState() => _NumberFieldWidgetState();
}

class _NumberFieldWidgetState extends ConsumerState<NumberFieldWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// ✅ WATCH ONLY THIS FIELD VALUE
    final value = ref.watch(
      dynamicFormProvider.select(
        (state) => state.values[widget.field.name]?.toString() ?? '',
      ),
    );

    /// ✅ WATCH ONLY THIS FIELD ERROR
    final error = ref.watch(
      dynamicFormProvider.select((state) => state.errors[widget.field.name]),
    );

    final notifier = ref.read(dynamicFormProvider.notifier);

    /// ✅ DYNAMIC DISABLE LOGIC
    final isDisabled =
        widget.field.disabled ||
        (widget.field.disabledWhen?.call(
              ref.read(dynamicFormProvider).values,
            ) ??
            false);

    /// ✅ PREVENT CURSOR JUMP
    if (_controller.text != value && !_focusNode.hasFocus) {
      _controller.text = value;

      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: !isDisabled,

        hintText: widget.field.placeholder,
        fieldHeadingText: widget.field.label,
        fieldHeadingTextStyle: DynamicFieldLabelStyle.text,

        /// ✅ LIVE ERROR
        errorText: error,

        isRequired: widget.field.required,

        /// ✅ NUMBER KEYBOARD
        keyboardType: TextInputType.number,

        /// ✅ ONLY NUMBERS
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

        onChanged: isDisabled
            ? null
            : (val) {
                notifier.updateValue(widget.field.name, val);
              },
      ),
    );
  }
}
