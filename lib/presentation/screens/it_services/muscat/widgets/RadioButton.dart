import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final String selectedValue;
  final Function(String) onChanged;

  const CustomRadioGroup({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
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
            fontWeight: currentTheme.fontWeights.wBolder,
            color: Colors.grey,
          ),
        ),
        6.toVerticalSizedBox,
        Row(
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selectedValue,
                  activeColor: Colors.indigo, // customize color
                  onChanged: (val) => onChanged(val!),
                ),
                GestureDetector(
                  onTap: () => onChanged(option),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      color: selectedValue == option
                          ? Colors.black
                          : Colors.grey[700],
                      fontWeight: selectedValue == option
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                12.toVerticalSizedBox, // spacing between options
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
