// // import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
// // import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../../models/dynamic_field.dart';

// // class TextFieldWidget extends ConsumerStatefulWidget {
// //   final DynamicField field;

// //   const TextFieldWidget({super.key, required this.field});

// //   @override
// //   ConsumerState<TextFieldWidget> createState() => _TextFieldWidgetState();
// // }

// // class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {
// //   late final TextEditingController _controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = TextEditingController();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final state = ref.watch(dynamicFormProvider);
// //     final notifier = ref.read(dynamicFormProvider.notifier);

// //     final value = state.values[widget.field.name]?.toString() ?? '';

// //     // 🔥 THIS LINE FIXES YOUR ISSUE
// //     if (_controller.text != value) {
// //       _controller.text = value;
// //     }

// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 16),
// //       child: KTextField(
// //         controller: _controller, // 👈 IMPORTANT
// //         enabled: !widget.field.disabled,
// //         hintText: widget.field.placeholder,
// //         fieldHeadingText: widget.field.label,
// //         errorText: state.errors[widget.field.name],
// //         isRequired: widget.field.required,
// //         onChanged: widget.field.disabled
// //             ? null
// //             : (val) => notifier.updateValue(widget.field.name, val),
// //       ),
// //     );
// //   }
// // }

// import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
// import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../models/dynamic_field.dart';

// class TextFieldWidget extends ConsumerStatefulWidget {
//   final DynamicField field;

//   const TextFieldWidget({super.key, required this.field});

//   @override
//   ConsumerState<TextFieldWidget> createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {
//   late final TextEditingController _controller;
//   late final FocusNode _focusNode;

//   @override
//   void initState() {
//     super.initState();

//     _focusNode = FocusNode();

//     // ✅ ROBUST FALLBACK CHAIN:
//     // 1️⃣ First try: value already in form state (set via initialize() or apiValues)
//     // 2️⃣ Second try: field.initialValue directly from DynamicField definition
//     // 3️⃣ Last resort: empty string
//     final stateValue = ref
//         .read(dynamicFormProvider)
//         .values[widget.field.name]
//         ?.toString();

//     final initialValue = (stateValue != null && stateValue.isNotEmpty)
//         ? stateValue
//         : widget.field.initialValue?.toString() ?? '';

//     _controller = TextEditingController(text: initialValue);

//     // ✅ If we used field.initialValue as fallback, sync it into form state
//     // so validation and submission see the correct value too.
//     if ((stateValue == null || stateValue.isEmpty) &&
//         widget.field.initialValue != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           ref
//               .read(dynamicFormProvider.notifier)
//               .updateValue(widget.field.name, widget.field.initialValue);
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(dynamicFormProvider);
//     final notifier = ref.read(dynamicFormProvider.notifier);

//     final value = state.values[widget.field.name]?.toString() ?? '';

//     // ✅ Only sync controller when field is NOT focused (user not typing)
//     // and when value actually differs — handles autoPopulate() correctly
//     // without causing cursor-jump mid-typing.
//     if (_controller.text != value && !_focusNode.hasFocus) {
//       _controller.text = value;
//       _controller.selection = TextSelection.fromPosition(
//         TextPosition(offset: _controller.text.length),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: KTextField(
//         controller: _controller,
//         focusNode: _focusNode,
//         enabled: !widget.field.disabled,
//         hintText: widget.field.placeholder,
//         fieldHeadingText: widget.field.label,
//         errorText: state.errors[widget.field.name],
//         isRequired: widget.field.required,
//         onChanged: widget.field.disabled
//             ? null
//             : (val) => notifier.updateValue(widget.field.name, val),
//       ),
//     );
//   }
// }

import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/dynamic_field_label_style.dart';
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

    /// ✅ 🔥 DYNAMIC DISABLE LOGIC (KEY FIX)
    final isDisabled =
        widget.field.disabled ||
        (widget.field.disabledWhen?.call(values) ?? false);

    final isRequired =
        widget.field.required ||
        (widget.field.requiredWhen?.call(values) ?? false);

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
        enabled: !isDisabled, // 🔥 UPDATED
        hintText: widget.field.placeholder,
        fieldHeadingText: widget.field.label,
        fieldHeadingTextStyle: DynamicFieldLabelStyle.text,
        errorText: state.errors[widget.field.name],
        isRequired: isRequired,
        onChanged: isDisabled
            ? null
            : (val) => notifier.updateValue(widget.field.name, val),
      ),
    );
  }
}
