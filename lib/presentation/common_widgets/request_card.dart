import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  static const _titleColor = Color(0xFF676767);
  static const _dataColor = Color(0xFF434347);
  static const _backgroundColor = Color(0xFFFFFFFF);
  static const _borderColor = Color(0xFFD8D8D8);
  static const _cardRadius = 8.0;
  static const _cardPadding = 24.0;
  static const _cardGap = 16.0;

  final String from;
  final Map<String, dynamic> data;
  final bool isShowClosed;
  final VoidCallback? onTap;
  final VoidCallback? onSelfAssign;
  final String Function(String key)? fieldLabelBuilder;
  final String Function(String status)? statusLabelBuilder;
  final String Function(String id)? requestIdLabelBuilder;

  const RequestCard({
    super.key,
    this.from = '',
    required this.data,
    this.onTap,
    this.onSelfAssign,
    this.fieldLabelBuilder,
    this.statusLabelBuilder,
    this.requestIdLabelBuilder,
    this.isShowClosed = false,
  });

  String _resolveStatus(dynamic status) {
    if (status == null || status.toString().trim().isEmpty) {
      return 'Draft';
    }
    final value = status.toString();
    return value[0].toUpperCase() + value.substring(1);
  }

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  bool _isDateLike(dynamic value) {
    if (value == null) return false;
    final v = value.toString();
    return v.contains('-') || v.contains('/') || v.contains('T');
  }

  bool _isStatusKey(String key) => key.toLowerCase() == 'status';

  bool _hasStatusKey() => data.keys.any(_isStatusKey);

  String _humanizeKey(String key) {
    if (fieldLabelBuilder != null) return fieldLabelBuilder!(key);
    return key
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .split(' ')
        .map((e) => e.isEmpty ? e : e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  dynamic _statusRawValue() {
    for (final entry in data.entries) {
      if (_isStatusKey(entry.key)) return entry.value;
    }
    return null;
  }

  String _statusLabel() {
    final status = _resolveStatus(_statusRawValue());

    if (isShowClosed && status.toLowerCase() == 'approved') {
      return 'Closed';
    }

    // Show Pending when status is In Progress
    if (status.toLowerCase().replaceAll('_', ' ') == 'in progress') {
      return 'Pending';
    }

    return statusLabelBuilder?.call(status) ?? status;
  }

  List<MapEntry<String, dynamic>> _contentEntries() {
    return data.entries.where((e) => !_isStatusKey(e.key)).toList();
  }

  String _displayValue(MapEntry<String, dynamic> entry) {
    final raw = entry.value;
    if (raw == null || raw.toString().trim().isEmpty) {
      return '-';
    }
    final text = raw.toString();
    return _isDateLike(raw) ? _formatDate(text) : text;
  }

  Widget _buildFieldCell(String key, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _humanizeKey(key),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.toAutoScaledWidth,
            fontWeight: FontWeight.w500,
            color: _titleColor,
            height: 1.3,
          ),
        ),
        SizedBox(height: 4.toAutoScaledHeight),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.toAutoScaledWidth,
            fontWeight: FontWeight.w600,
            color: _dataColor,
            height: 1.35,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicGrid(List<MapEntry<String, dynamic>> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final rows = <Widget>[];

    for (var i = 0; i < entries.length; i += 2) {
      if (i > 0) {
        rows.add(SizedBox(height: _cardGap.toAutoScaledHeight));
      }

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildFieldCell(entries[i].key, _displayValue(entries[i])),
            ),
            SizedBox(width: _cardGap.toAutoScaledWidth),
            Expanded(
              child: i + 1 < entries.length
                  ? _buildFieldCell(
                      entries[i + 1].key,
                      _displayValue(entries[i + 1]),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }

  Widget _buildFooter() {
    final status = _resolveStatus(_statusRawValue());

    final chipStatus =
        status.toLowerCase().replaceAll('_', ' ') == 'in progress'
        ? 'Pending'
        : status;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_hasStatusKey())
          Flexible(
            child: StatusChip(status: chipStatus, displayLabel: _statusLabel()),
          )
        else
          const SizedBox.shrink(),
        // Icon(Icons.open_in_new, size: 20.toAutoScaledWidth, color: _dataColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = _contentEntries();

    return Padding(
      padding: EdgeInsets.only(bottom: 12.toAutoScaledHeight),
      child: Material(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius.toAutoScaledWidth),
          side: const BorderSide(color: _borderColor, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(_cardPadding.toAutoScaledWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDynamicGrid(entries),
                if (entries.isNotEmpty || _hasStatusKey())
                  SizedBox(height: _cardGap.toAutoScaledHeight),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
