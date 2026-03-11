import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final List<String> view;
  final String selectedValue;
  final Function(String)? onChanged; // 👈 made nullable
  final List<String> disabledOptions;

  final bool readOnly; // 👈 NEW flag to disable entire widget

  const CustomRadioGroup({
    super.key,
    required this.label,
    required this.options,
    required this.view,
    required this.selectedValue,
    required this.onChanged,
    this.disabledOptions = const [],
    this.readOnly = false, // 👈 default false
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: currentTheme.fontSizes.s14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),

        6.toVerticalSizedBox,

        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: List.generate(options.length, (index) {
            final option = options[index];
            final displayText = view[index];
            final isSelected = selectedValue == option;

            // 🔒 If readOnly == true → disable everything
            final isDisabled = readOnly || disabledOptions.contains(option);

            return GestureDetector(
              onTap: isDisabled ? null : () => onChanged?.call(option),
              child: Opacity(
                opacity: isDisabled ? 0.4 : 1.0, // disabled look
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: selectedValue,
                      activeColor: Colors.indigo,
                      onChanged: isDisabled
                          ? null
                          : (val) => onChanged?.call(val!),
                    ),
                    Text(
                      displayText,
                      style: TextStyle(
                        fontSize: currentTheme.fontSizes.s14,
                        color: isSelected ? Colors.black : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
