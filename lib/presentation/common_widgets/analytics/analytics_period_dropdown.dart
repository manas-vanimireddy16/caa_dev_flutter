import 'dart:math' as math;

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';

/// Compact period/year selector for analytics card headers.
class AnalyticsPeriodDropdown extends StatefulWidget {
  static const double _defaultWidth = 92;
  static const double _height = 36;
  static const double _borderRadius = 2;
  static const double _iconGap = 8;
  static const double _horizontalPadding = 10;
  static const double _widthBuffer = 4;

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
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    const borderColor = Color(0xFFD1D5DB);

    final labelStyle = TextStyle(
      fontSize: currentTheme.fontSizes.s12,
      fontWeight: currentTheme.fontWeights.wRegular,
      color: AppColors.headingColor,
      height: 1.2,
    );
    final resolvedWidth = _resolveWidth(context, labelStyle);

    return Container(
      width: resolvedWidth.toAutoScaledWidth,
      height: AnalyticsPeriodDropdown._height.toAutoScaledHeight,
      padding: EdgeInsets.symmetric(
        horizontal: AnalyticsPeriodDropdown._horizontalPadding.toAutoScaledWidth,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(
          AnalyticsPeriodDropdown._borderRadius.toAutoScaledWidth,
        ),
      ),
      alignment: Alignment.center,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: VisualDensity.standard),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: ValueKey(_displayValue),
            value: _displayValue,
            isExpanded: true,
            icon: Padding(
              padding: EdgeInsets.only(
                left: AnalyticsPeriodDropdown._iconGap.toAutoScaledWidth,
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 16.toAutoScaledWidth,
                color: const Color(0xFF6B7280),
              ),
            ),
            iconSize: 16.toAutoScaledWidth,
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
                        overflow: TextOverflow.visible,
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

    const iconWidth = 16.0;
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
