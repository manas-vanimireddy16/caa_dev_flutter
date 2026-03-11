import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

/// Robust multi-select dropdown field that supports any model type T
/// and ensures proper selection matching.
class KMultiDropdownField<T extends Object> extends StatefulWidget {
  final Widget? fieldHeading;
  final String? fieldHeadingText;
  final TextStyle? fieldHeadingTextStyle;

  final List<T> items;
  final List<T> selectedItems;
  final String Function(T item) labelBuilder;
  final Color Function(T item) colorBuilder;
  final ValueChanged<List<T>> onChanged;

  final String? hintText;
  final bool searchEnabled;
  final String? Function(List<DropdownItem<T>>?)? validator;
  final bool showSelectAllActions;

  const KMultiDropdownField({
    super.key,
    this.fieldHeading,
    this.fieldHeadingText,
    this.fieldHeadingTextStyle,
    required this.items,
    required this.selectedItems,
    required this.labelBuilder,
    required this.colorBuilder,
    required this.onChanged,
    this.hintText,
    this.searchEnabled = false,
    this.validator,
    this.showSelectAllActions = true,
  });

  @override
  State<KMultiDropdownField<T>> createState() => _KMultiDropdownFieldState<T>();
}

class _KMultiDropdownFieldState<T extends Object>
    extends State<KMultiDropdownField<T>> {
  late final MultiSelectController<T> _controller;
  late List<DropdownItem<T>> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _controller = MultiSelectController<T>();

    _buildItems();
    _controller.setItems(_dropdownItems);

    // Pre-select initial values
    _applySelection(widget.selectedItems);
  }

  void _buildItems() {
    _dropdownItems = widget.items
        .map((e) => DropdownItem<T>(label: widget.labelBuilder(e), value: e))
        .toList();
  }

  /// Apply selection from external state → dropdown UI
  void _applySelection(List<T> selected) {
    _controller.clearAll();

    for (final sel in selected) {
      _controller.selectWhere((item) => item.value == sel);
    }
  }

  @override
  void didUpdateWidget(covariant KMultiDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update items list
    if (oldWidget.items != widget.items) {
      _buildItems();
      _controller.setItems(_dropdownItems);
    }

    // Update selection list
    if (oldWidget.selectedItems != widget.selectedItems) {
      _applySelection(widget.selectedItems);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _notifyParent() {
    final values = _controller.selectedItems.map((d) => d.value as T).toList();
    widget.onChanged(values);
  }

  @override
  Widget build(BuildContext context) {
    Widget? headerWidget;

    if (widget.showSelectAllActions) {
      headerWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            const Text(
              "Select items",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                _controller.selectAll();
                setState(() {});
                _notifyParent();
              },
              child: const Text("Select all"),
            ),
            TextButton(
              onPressed: () {
                _controller.clearAll();
                setState(() {});
                _notifyParent();
              },
              child: const Text("Clear"),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldHeading != null || widget.fieldHeadingText != null) ...[
          widget.fieldHeading ??
              Text(
                widget.fieldHeadingText ?? "",
                style:
                    widget.fieldHeadingTextStyle ??
                    const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
          const SizedBox(height: 8),
        ],

        /// MAIN MULTI DROPDOWN
        MultiDropdown<T>(
          items: _dropdownItems,
          controller: _controller,
          searchEnabled: widget.searchEnabled,
          validator: widget.validator,

          dropdownDecoration: DropdownDecoration(
            maxHeight: 360,
            marginTop: 6,
            header: headerWidget,
          ),

          fieldDecoration: FieldDecoration(
            hintText: widget.hintText ?? 'Select',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            showClearIcon: true,
            padding: const EdgeInsets.all(10),
          ),

          chipDecoration: ChipDecoration(
            wrap: true,
            spacing: 6,
            runSpacing: 6,
            backgroundColor: const Color(0xFFEFEFEF),
            borderRadius: BorderRadius.circular(6),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          ),

          /// Custom item builder
          itemBuilder: (dynamic a, [dynamic b, dynamic c]) {
            final DropdownItem<T>? dropdownItem = a is DropdownItem<T>
                ? a
                : _dropdownItems.firstWhere(
                    (e) => e.value == a,
                    orElse: () => DropdownItem<T>(
                      label: widget.labelBuilder(a),
                      value: a,
                    ),
                  );

            final T value = dropdownItem!.value;

            final bool isSelected =
                dropdownItem.selected ||
                _controller.selectedItems.any((d) => d.value == value);

            final Color background = widget.colorBuilder(value);

            final void Function()? toggle = c is Function
                ? () => c()
                : (b is Function ? () => b() : null);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: background.withOpacity(0.85),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (_) {
                          if (toggle != null) {
                            toggle();
                          } else {
                            _controller.toggleWhere((candidate) {
                              final v = candidate is DropdownItem<T>
                                  ? candidate.value
                                  : candidate;
                              return v == value;
                            });
                          }
                          setState(() {});
                          _notifyParent();
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      child: Text(
                        widget.labelBuilder(value),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },

          dropdownItemDecoration: DropdownItemDecoration(
            selectedIcon: const Icon(Icons.check_box, color: Colors.green),
            disabledIcon: Icon(Icons.lock, color: Colors.grey),
          ),

          onSelectionChange: (dynamic values) {
            if (values is List<DropdownItem<T>>) {
              widget.onChanged(values.map((e) => e.value).toList());
            } else if (values is List<T>) {
              widget.onChanged(values);
            } else {
              try {
                widget.onChanged(
                  (values as List)
                      .map((e) => e is DropdownItem<T> ? e.value : e as T)
                      .toList(),
                );
              } catch (_) {
                widget.onChanged([]);
              }
            }
          },
        ),
      ],
    );
  }
}
