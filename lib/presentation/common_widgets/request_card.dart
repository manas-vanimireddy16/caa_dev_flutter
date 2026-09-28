import 'package:code_setup/presentation/common_widgets/request_card_workflow_action.dart';
import 'package:code_setup/presentation/common_widgets/status_widget.dart';
import 'package:code_setup/responsive/app_page_layout.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  static const _backgroundColor = Color(0xFFFFFFFF);
  static const _borderColor = Color(0xFFD8D8D8);
  static const _cardRadius = 8.0;
  static const _cardPadding = 14.0;
  static const _cardGap = 8.0;

  final String from;
  final Map<String, dynamic> data;
  final bool isShowClosed;
  final VoidCallback? onTap;
  final VoidCallback? onSelfAssign;
  final VoidCallback? onWorkflowTap;
  final String Function(String key)? fieldLabelBuilder;
  final String Function(String status)? statusLabelBuilder;
  final String Function(String id)? requestIdLabelBuilder;
  final bool mapInProgressToPending;

  const RequestCard({
    super.key,
    this.from = '',
    required this.data,
    this.onTap,
    this.onSelfAssign,
    this.onWorkflowTap,
    this.fieldLabelBuilder,
    this.statusLabelBuilder,
    this.requestIdLabelBuilder,
    this.isShowClosed = false,
    this.mapInProgressToPending = true,
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

  bool _isInProgressStatus(String status) {
    final normalized =
        status.toLowerCase().replaceAll('_', ' ').replaceAll(' ', '');
    return normalized == 'inprogress';
  }

  String _inProgressDisplayLabel() {
    return statusLabelBuilder?.call('In Progress') ?? 'In Progress';
  }

  String _statusLabel() {
    final status = _resolveStatus(_statusRawValue());

    if (isShowClosed && status.toLowerCase() == 'approved') {
      return 'Closed';
    }

    if (_isInProgressStatus(status)) {
      if (mapInProgressToPending) {
        return statusLabelBuilder?.call('Pending') ?? 'Pending';
      }
      return _inProgressDisplayLabel();
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
          style: AppTextStyles.requestCardFieldHeading(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.requestCardFieldContent(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildInlineRow(String key, String value) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF23272F),
          height: 1.35,
        ),
        children: [
          TextSpan(
            text: '${_humanizeKey(key)}: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCompactList(List<MapEntry<String, dynamic>> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          _buildInlineRow(entries[i].key, _displayValue(entries[i])),
        ],
      ],
    );
  }

  Widget _buildDynamicGrid(List<MapEntry<String, dynamic>> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final rows = <Widget>[];

    for (var i = 0; i < entries.length; i += 2) {
      if (i > 0) {
        rows.add(const SizedBox(height: _cardGap));
      }

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildFieldCell(entries[i].key, _displayValue(entries[i])),
            ),
            const SizedBox(width: _cardGap),
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

    final chipStatus = _isInProgressStatus(status)
        ? (mapInProgressToPending ? 'Pending' : 'in progress')
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
        if (onWorkflowTap != null)
          RequestCardWorkflowAction(onTap: onWorkflowTap!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = _contentEntries();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
          side: const BorderSide(color: _borderColor, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(_cardPadding),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact =
                  AppPageLayout.isTablet(context) ||
                  constraints.maxWidth >= 700;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: compact
                        ? _buildCompactList(entries)
                        : _buildDynamicGrid(entries),
                  ),
                  if (entries.isNotEmpty || _hasStatusKey())
                    const SizedBox(height: 10),
                  _buildFooter(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
