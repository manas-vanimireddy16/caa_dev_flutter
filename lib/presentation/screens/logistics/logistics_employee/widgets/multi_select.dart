import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropdown({
    Key? key,
    required this.items,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedItems = ['All Status']; // ✅ Default selection

  void _showMultiSelectDialog() async {
    List<String> tempSelected = List.from(selectedItems);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void toggleSelection(String item, bool? checked) {
              if (checked == true) {
                if (item == 'All Status') {
                  // Selecting "All Status" clears everything else
                  tempSelected = ['All Status'];
                } else {
                  // Selecting others removes "All Status"
                  tempSelected.remove('All Status');
                  if (!tempSelected.contains(item)) {
                    tempSelected.add(item);
                  }
                }
              } else {
                tempSelected.remove(item);
              }

              // If all deselected → fallback to All Status
              if (tempSelected.isEmpty) {
                tempSelected = ['All Status'];
              }

              setDialogState(() {});
            }

            return AlertDialog(
              title: const Text('Select Status'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    final isSelected = tempSelected.contains(item);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(item),
                      onChanged: (checked) => toggleSelection(item, checked),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => KAppX.router.pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => selectedItems = tempSelected);

                    // Send empty string to API when "All Status" selected
                    if (selectedItems.contains('All Status')) {
                      widget.onSelectionChanged([]);
                    } else {
                      widget.onSelectionChanged(selectedItems);
                    }

                    KAppX.router.pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Format display text in the dropdown box
  String _getDisplayText() {
    if (selectedItems.contains('All Status')) {
      return 'All Status';
    } else {
      return '${selectedItems.length} selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _getDisplayText();

    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                displayText,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
