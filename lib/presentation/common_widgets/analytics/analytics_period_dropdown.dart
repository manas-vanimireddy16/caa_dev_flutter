import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Compact period/year selector for analytics card headers.
/// Uses FIXED sizes (no width/height auto-scaling) so iPad matches phone chrome.
class AnalyticsPeriodDropdown extends StatefulWidget {
  static const double _defaultWidth = 92;
  static const double _height = 36;
  static const double _borderRadius = 8;
  static const double _iconGap = 4;
  static const double _horizontalPadding = 10;
  static const double _widthBuffer = 4;
  static const double _fontSize = 14;
  static const double _iconSize = 18;

  static const List<String> _apiPeriodValues = [
    'weekly',
    'monthly',
    'quarterly',
    'yearly',
  ];

  final String value;
  final List<String> filterLabelList;
  final void Function(dynamic?) onChanged;
  final double? width;

  const AnalyticsPeriodDropdown({
    super.key,
    required this.value,
    required this.filterLabelList,
    required this.onChanged,
    this.width,
  });

  @override
  State<AnalyticsPeriodDropdown> createState() =>
      _AnalyticsPeriodDropdownState();
}

class _AnalyticsPeriodDropdownState extends State<AnalyticsPeriodDropdown> {
  late String _displayValue;

  @override
  void initState() {
    super.initState();
    _displayValue = _resolveDisplayValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant AnalyticsPeriodDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameLabelList(oldWidget.filterLabelList, widget.filterLabelList)) {
      final previousIndex = oldWidget.filterLabelList.indexOf(_displayValue);
      if (previousIndex >= 0 && previousIndex < widget.filterLabelList.length) {
        _displayValue = widget.filterLabelList[previousIndex];
      } else if (!widget.filterLabelList.contains(_displayValue)) {
        _displayValue = _resolveDisplayValue(widget.value);
      }
    } else if (oldWidget.value != widget.value) {
      _displayValue = _resolveDisplayValue(widget.value);
    }
  }

  bool _sameLabelList(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  String _resolveDisplayValue(String rawValue, {String? keepCurrent}) {
    if (widget.filterLabelList.isEmpty) return rawValue;
    if (widget.filterLabelList.contains(rawValue)) return rawValue;

    final apiIndex = AnalyticsPeriodDropdown._apiPeriodValues.indexOf(
      rawValue.toLowerCase(),
    );
    if (apiIndex >= 0 && apiIndex < widget.filterLabelList.length) {
      return widget.filterLabelList[apiIndex];
    }

    if (keepCurrent != null && widget.filterLabelList.contains(keepCurrent)) {
      return keepCurrent;
    }

    return widget.filterLabelList.first;
  }

  void _handleChanged(String? selected) {
    if (selected == null) return;
    setState(() => _displayValue = selected);
    widget.onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD1D5DB);

    final labelStyle = const TextStyle(
      fontSize: AnalyticsPeriodDropdown._fontSize,
      fontWeight: FontWeight.w400,
      color: Color(0xFF111827),
      height: 1.2,
    );
    final resolvedWidth = _resolveWidth(context, labelStyle);

    return Container(
      width: resolvedWidth,
      height: AnalyticsPeriodDropdown._height,
      padding: const EdgeInsets.symmetric(
        horizontal: AnalyticsPeriodDropdown._horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(
          AnalyticsPeriodDropdown._borderRadius,
        ),
      ),
      alignment: Alignment.center,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: VisualDensity.compact),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: ValueKey(_displayValue),
            value: widget.filterLabelList.contains(_displayValue)
                ? _displayValue
                : (widget.filterLabelList.isNotEmpty
                      ? widget.filterLabelList.first
                      : null),
            isExpanded: true,
            isDense: true,
            icon: const Padding(
              padding: EdgeInsets.only(left: AnalyticsPeriodDropdown._iconGap),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: AnalyticsPeriodDropdown._iconSize,
                color: Color(0xFF6B7280),
              ),
            ),
            iconSize: AnalyticsPeriodDropdown._iconSize,
            style: labelStyle,
            padding: EdgeInsets.zero,
            selectedItemBuilder: (context) {
              return widget.filterLabelList
                  .map(
                    (opt) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        opt,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: labelStyle,
                      ),
                    ),
                  )
                  .toList();
            },
            items: widget.filterLabelList
                .map(
                  (opt) => DropdownMenuItem<String>(
                    value: opt,
                    child: Text(
                      opt,
                      maxLines: 1,
                      softWrap: false,
                      style: labelStyle,
                    ),
                  ),
                )
                .toList(),
            onChanged: _handleChanged,
          ),
        ),
      ),
    );
  }

  double _resolveWidth(BuildContext context, TextStyle labelStyle) {
    if (widget.width != null) return widget.width!;

    final painter = TextPainter(textDirection: Directionality.of(context));
    var maxLabelWidth = 0.0;
    for (final label in widget.filterLabelList) {
      painter.text = TextSpan(text: label, style: labelStyle);
      painter.layout();
      maxLabelWidth = math.max(maxLabelWidth, painter.width);
    }

    const iconWidth = AnalyticsPeriodDropdown._iconSize;
    return math.max(
      AnalyticsPeriodDropdown._defaultWidth,
      maxLabelWidth +
          (AnalyticsPeriodDropdown._horizontalPadding * 2) +
          AnalyticsPeriodDropdown._iconGap +
          iconWidth +
          AnalyticsPeriodDropdown._widthBuffer,
    );
  }
}
