import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
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

    /// ✅ INITIAL VALUE (STATE FIRST → FIELD FALLBACK)
    final stateValue = values[widget.field.name]?.toString();

    final initialValue = (stateValue != null && stateValue.isNotEmpty)
        ? stateValue
        : widget.field.initialValue?.toString() ?? '';

    _controller = TextEditingController(text: initialValue);

    /// ✅ SYNC INITIAL VALUE TO STATE (ONLY IF EMPTY)
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
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final values = state.values;

    /// ✅ DYNAMIC DISABLE LOGIC
    final isDisabled =
        widget.field.disabled ||
        (widget.field.disabledWhen?.call(values) ?? false);

    final value = values[widget.field.name]?.toString() ?? '';

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
        errorText: state.errors[widget.field.name],
        isRequired: widget.field.required,

        /// ✅ NUMBER KEYBOARD
        keyboardType: TextInputType.number,

        /// ✅ ONLY NUMBERS ALLOWED
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

        onChanged: isDisabled
            ? null
            : (val) => notifier.updateValue(widget.field.name, val),
      ),
    );
  }
}
