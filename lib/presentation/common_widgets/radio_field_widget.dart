import 'package:code_setup/presentation/core_widgets/buttons/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';

class KRadioOption<T> {
  final T value;
  final String label;

  /// 🔥 NEW
  final bool isDisabled;

  const KRadioOption({
    required this.value,
    required this.label,
    this.isDisabled = false,
  });
}

class KRadioGroup<T> extends ConsumerWidget {
  final String title;
  final bool isRequired;
  final List<KRadioOption<T>> options;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final double horizontalGap;
  final EdgeInsets? padding;
  final String? errorText;

  const KRadioGroup({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
    this.horizontalGap = 24,
    this.padding,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    TextStyle _labelStyle(bool isActive, bool isDisabled) => TextStyle(
      fontSize: currentTheme.fontSizes.s12,
      fontWeight: currentTheme.fontWeights.wBold,
      color: isDisabled
          ? Colors.grey
          : isActive
          ? currentTheme.colors.secondary
          : currentTheme.colors.secondary.shade40,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  fontWeight: currentTheme.fontWeights.wBold,
                  color: currentTheme.colors.secondary,
                ),
              ),
              if (isRequired) ...[
                4.toHorizontalSizedBox,
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s12,
                    fontWeight: currentTheme.fontWeights.wBold,
                    color: Colors.red,
                  ),
                ),
              ],
            ],
          ),

          16.toVerticalSizedBox,

          /// 🔹 Options
          Wrap(
            spacing: horizontalGap.toAutoScaledWidth,
            runSpacing: 8.toAutoScaledHeight,
            children: options.map((option) {
              final isActive = selectedValue == option.value;
              final isDisabled = option.isDisabled;

              return Opacity(
                opacity: isDisabled ? 0.5 : 1,
                child: IgnorePointer(
                  ignoring: isDisabled,
                  child: KRadioButton<T>(
                    title: option.label,
                    value: option.value,
                    isActive: isActive,
                    textStyle: _labelStyle(isActive, isDisabled),

                    /// 🔥 BLOCK CLICK IF DISABLED
                    onPressed: isDisabled ? (_) {} : onChanged,
                  ),
                ),
              );
            }).toList(),
          ),

          /// 🔹 Error
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText!,
                style: TextStyle(
                  color: currentTheme.colors.error,
                  fontSize: currentTheme.fontSizes.s12,
                  fontWeight: currentTheme.fontWeights.wRegular,
                ),
              ),
            ),

          16.toVerticalSizedBox,
        ],
      ),
    );
  }
}
