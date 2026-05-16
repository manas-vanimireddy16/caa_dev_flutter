import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/acknowledgement_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/checkbox_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/date_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/file_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/multi_select_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/number_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/radio_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/select_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/text_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/time_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/toggle_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/step_header.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicFormState {
  final Map<String, dynamic> values;
  final Map<String, String?> errors;
  final int currentStep;
  const DynamicFormState({
    required this.values,
    required this.errors,
    required this.currentStep,
  });

  DynamicFormState copyWith({
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
    int? currentStep,
  }) {
    return DynamicFormState(
      values: values ?? this.values,
      errors: errors ?? this.errors,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

final dynamicFormProvider =
    StateNotifierProvider<DynamicFormNotifier, DynamicFormState>(
      (ref) => DynamicFormNotifier(ref),
    );

// class DynamicForm extends ConsumerWidget {
//   final List<List<DynamicField>> steps;
//   final List<String> stepTitles;
//   final void Function(Map<String, dynamic>) onSubmit;
//   final String title;
//   final bool Function(Map<String, dynamic> values)? enableSubmitWhen;

//   const DynamicForm({
//     super.key,
//     required this.steps,
//     required this.stepTitles,
//     required this.onSubmit,
//     required this.title,
//     this.enableSubmitWhen,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(dynamicFormProvider);
//     final notifier = ref.read(dynamicFormProvider.notifier);

//     final currentStep = state.currentStep;
//     final currentFields = steps[currentStep];
//     final isLastStep = currentStep == steps.length - 1;
//     final visibleFields = currentFields.where((field) {
//       if (field.visibleWhen == null) return true;
//       return field.visibleWhen!(state.values);
//     }).toList();

//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return KScaffold(
//       appBar: KAppBar(
//         title: Text(
//           'New Request',
//           style: TextStyle(
//             fontSize: currentTheme.fontSizes.s18,
//             fontWeight: currentTheme.fontWeights.wBold,
//           ),
//         ),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             20.toVerticalSizedBox,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.toAutoScaledWidth),
//               child: Wrap(
//                 children: [
//                   Text(
//                     'Provide details about your $title',
//                     style: TextStyle(
//                       fontSize: currentTheme.fontSizes.s15,
//                       fontWeight: currentTheme.fontWeights.wRegular,
//                       color: Color(0XFF818184),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (steps.length == 1) 20.toVerticalSizedBox,

//             if (steps.length > 1)
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: StepHeader(currentStep: currentStep, steps: stepTitles),
//               ),

//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: visibleFields.length,
//                 itemBuilder: (_, index) {
//                   return FieldRenderer(field: visibleFields[index]);
//                 },
//               ),
//             ),

//             _BottomActionBar(
//               showPrevious: currentStep > 0,
//               isLast: isLastStep,
//               onPrevious: notifier.previousStep,
//               onNext: () {
//                 if (notifier.validateStep(visibleFields)) {
//                   // 🔥 REMOVE CURRENT FOCUS (KEY FIX)
//                   FocusManager.instance.primaryFocus?.unfocus();

//                   // Optional: small delay for smoother UX
//                   Future.microtask(() {
//                     notifier.nextStep();
//                   });
//                 }
//               },
//               onSubmit: () {
//                 if (notifier.validateStep(visibleFields)) {
//                   onSubmit(state.values);
//                 }
//               },
//               enableSubmitWhen: enableSubmitWhen,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class DynamicForm extends ConsumerStatefulWidget {
  final List<List<DynamicField>> steps;
  final List<String> stepTitles;
  final void Function(Map<String, dynamic>) onSubmit;
  final String title;
  final bool Function(Map<String, dynamic> values)? enableSubmitWhen;

  /// When non-null, the **Next** button is only enabled if this returns true
  /// for the current step (e.g. custom widgets storing state outside [values]).
  final bool Function(WidgetRef ref, int currentStep, Map<String, dynamic>
          values)?
      canProceedFromStep;

  const DynamicForm({
    super.key,
    required this.steps,
    required this.stepTitles,
    required this.onSubmit,
    required this.title,
    this.enableSubmitWhen,
    this.canProceedFromStep,
  });

  @override
  ConsumerState<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends ConsumerState<DynamicForm>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(dynamicFormProvider.notifier).initialize(widget.steps);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  /// 🔥 Detect keyboard open
  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;

    if (bottomInset > 0) {
      // slight delay → wait for keyboard animation
      Future.delayed(const Duration(milliseconds: 120), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.offset + 120,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);
    final l10n = DashboardL10n.of(context);

    final currentStep = state.currentStep;
    final currentFields = widget.steps[currentStep];
    final isLastStep = currentStep == widget.steps.length - 1;

    final visibleFields = currentFields.where((field) {
      if (field.visibleWhen == null) return true;
      return field.visibleWhen!(state.values);
    }).toList();

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: currentTheme.fontSizes.s18,
            fontWeight: currentTheme.fontWeights.wBold,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.toVerticalSizedBox,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toAutoScaledWidth),
              child: Wrap(
                children: [
                  Text(
                    l10n.dynamicFormSubtitle(widget.title),
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s15,
                      fontWeight: currentTheme.fontWeights.wRegular,
                      color: const Color(0XFF818184),
                    ),
                  ),
                ],
              ),
            ),

            if (widget.steps.length == 1) 20.toVerticalSizedBox,

            if (widget.steps.length > 1)
              Padding(
                padding: const EdgeInsets.all(16),
                child: StepHeader(
                  currentStep: currentStep,
                  steps: widget.stepTitles,
                ),
              ),

            /// 🔥 MAIN SCROLL AREA
            Expanded(
              child: ListView.builder(
                controller: _scrollController,

                /// 👇 dismiss keyboard on scroll
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,

                /// 🔥 KEY FIX → dynamic bottom padding
                padding: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  MediaQuery.of(context).viewInsets.bottom + 20,
                ),

                itemCount: visibleFields.length,
                itemBuilder: (_, index) {
                  return FieldRenderer(field: visibleFields[index]);
                },
              ),
            ),

            _BottomActionBar(
              l10n: l10n,
              showPrevious: currentStep > 0,
              isLast: isLastStep,
              onPrevious: notifier.previousStep,
              onNext: () {
                if (notifier.validateStep(visibleFields)) {
                  /// 🔥 IMPORTANT (already correct in your code)
                  FocusManager.instance.primaryFocus?.unfocus();

                  Future.microtask(() {
                    notifier.nextStep();
                  });
                }
              },
              onSubmit: () {
                if (notifier.validateStep(visibleFields)) {
                  widget.onSubmit(state.values);
                }
              },
              enableSubmitWhen: widget.enableSubmitWhen,
              canProceedFromStep: widget.canProceedFromStep,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomActionBar extends ConsumerWidget {
  final DashboardL10n l10n;
  final bool showPrevious;
  final bool isLast;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  final bool Function(Map<String, dynamic> values)? enableSubmitWhen;

  final bool Function(WidgetRef ref, int currentStep, Map<String, dynamic>
          values)?
      canProceedFromStep;

  const _BottomActionBar({
    required this.l10n,
    required this.showPrevious,
    required this.isLast,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
    this.enableSubmitWhen,
    this.canProceedFromStep,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(dynamicFormProvider);

    bool enableSubmit = true;

    /// run validation rule if provided
    if (enableSubmitWhen != null) {
      enableSubmit = enableSubmitWhen!(formState.values);
    }

    bool enableNext = true;
    if (!isLast && canProceedFromStep != null) {
      enableNext = canProceedFromStep!(
        ref,
        formState.currentStep,
        formState.values,
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Row(
        children: [
          if (showPrevious)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                child: Text(l10n.dynamicFormPrevious),
              ),
            ),

          if (showPrevious) const SizedBox(width: 12),

          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isLast
                    ? const Color(0xFF0D652D)
                    : Colors.white,
                foregroundColor: isLast
                    ? Colors.white
                    : const Color(0xFF0D652D),
                side: isLast
                    ? BorderSide.none
                    : const BorderSide(color: Colors.grey),
              ),
              onPressed: isLast
                  ? (enableSubmit ? onSubmit : null)
                  : (enableNext ? onNext : null),
              child: Text(
                isLast ? l10n.dynamicFormSubmit : l10n.dynamicFormNext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FieldRenderer extends ConsumerWidget {
  final DynamicField field;

  const FieldRenderer({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (field.type) {
      case FieldType.text:
      case FieldType.email:
      case FieldType.textarea:
        return TextFieldWidget(field: field);

      case FieldType.number:
        return NumberFieldWidget(field: field);

      case FieldType.select:
        return SelectFieldWidget(field: field);

      case FieldType.radio:
        return RadioFieldWidget(field: field);

      case FieldType.checkbox:
        return CheckboxFieldWidget(field: field);
      case FieldType.multiselect:
        return MultiSelectDropdownFieldWidget(field: field);
      case FieldType.acknowledgement:
        return AcknowledgementFieldWidget(field: field);

      case FieldType.date:
      case FieldType.year:
        return DateFieldWidget(field: field);

      case FieldType.time:
        return TimeFieldWidget(field: field);

      case FieldType.toggle:
        return ToggleFieldWidget(field: field);

      case FieldType.file:
        return FileFieldWidget(field: field);
      case FieldType.custom:
        return field.builder!(context, ref);

      case FieldType.rating:
        // You can add RatingFieldWidget later
        return const SizedBox();

      default:
        return const SizedBox.shrink();
    }
  }
}
