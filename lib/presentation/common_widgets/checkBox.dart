import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final String label;
  final List<String> options; // Values stored in state/backend
  final List<String> view; // Values shown in UI
  final List<String> selectedValues;
  final Function(List<String>) onChanged;

  const CustomCheckboxGroup({
    super.key,
    required this.label,
    required this.options,
    required this.view,
    required this.selectedValues,
    required this.onChanged,
  });

  void _onItemTapped(String option) {
    final updated = List<String>.from(selectedValues);
    if (updated.contains(option)) {
      updated.remove(option);
    } else {
      updated.add(option);
    }
    onChanged(updated);
  }

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
            fontWeight: currentTheme.fontWeights.wRegular,
            color: Colors.grey,
          ),
        ),
        6.toVerticalSizedBox,
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: List.generate(options.length, (index) {
            final option = options[index];
            final displayText = view[index];
            final isSelected = selectedValues.contains(option);

            return GestureDetector(
              onTap: () => _onItemTapped(option),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isSelected,
                    activeColor: Colors.indigo,
                    onChanged: (_) => _onItemTapped(option),
                  ),
                  Flexible(
                    child: Text(
                      displayText,
                      style: TextStyle(
                        fontSize: currentTheme.fontSizes.s14,
                        color: isSelected ? Colors.black : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

// class CustomCheckboxGroup extends StatelessWidget {
//   final String label;
//   final List<String> options;
//   final List<String> selectedValues;
//   final Function(List<String>) onChanged;

//   const CustomCheckboxGroup({
//     super.key,
//     required this.label,
//     required this.options,
//     required this.selectedValues,
//     required this.onChanged,
//   });

//   void _onItemTapped(String option) {
//     final updated = List<String>.from(selectedValues);
//     if (updated.contains(option)) {
//       updated.remove(option);
//     } else {
//       updated.add(option);
//     }
//     onChanged(updated);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey,
//           ),
//         ),
//         6.toVerticalSizedBox,
//         Wrap(
//           // spacing: 16,
//           // runSpacing: 8,
//           children: options.map((option) {
//             final isSelected = selectedValues.contains(option);
//             return SizedBox(
//               width:
//                   MediaQuery.of(context).size.width -
//                   40, // adjust according to padding
//               child: CheckboxListTile(
//                 value: isSelected,
//                 onChanged: (_) => _onItemTapped(option),
//                 activeColor: Colors.indigo,
//                 title: Text(
//                   option,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: isSelected ? Colors.black : Colors.grey[700],
//                     fontWeight: isSelected
//                         ? FontWeight.bold
//                         : FontWeight.normal,
//                   ),
//                 ),
//                 controlAffinity: ListTileControlAffinity.leading,
//                 dense: true,
//                 contentPadding: EdgeInsets.zero,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
