import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/dynamic_field.dart';

class TextFieldWidget extends ConsumerStatefulWidget {
  final DynamicField field;

  const TextFieldWidget({super.key, required this.field});

  @override
  ConsumerState<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final value = state.values[widget.field.name]?.toString() ?? '';

    // 🔥 THIS LINE FIXES YOUR ISSUE
    if (_controller.text != value) {
      _controller.text = value;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        controller: _controller, // 👈 IMPORTANT
        enabled: !widget.field.disabled,
        hintText: widget.field.placeholder,
        fieldHeadingText: widget.field.label,
        errorText: state.errors[widget.field.name],
        isRequired: widget.field.required,
        onChanged: widget.field.disabled
            ? null
            : (val) => notifier.updateValue(widget.field.name, val),
      ),
    );
  }
}
