import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateActualReturnDialog extends StatefulWidget {
  final Future<void> Function({
    required String actualReturnDate,
    required String actualVehicleReturnTime,
    required String reason,
  }) onSubmit;

  final String? initialReturnDate;
  final String? initialReturnTime;
  final String? initialReason;

  const UpdateActualReturnDialog({
    super.key,
    required this.onSubmit,
    this.initialReturnDate,
    this.initialReturnTime,
    this.initialReason,
  });

  @override
  State<UpdateActualReturnDialog> createState() =>
      _UpdateActualReturnDialogState();
}

class _UpdateActualReturnDialogState extends State<UpdateActualReturnDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _returnDateController;
  late final TextEditingController _returnTimeController;
  late final TextEditingController _reasonController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _returnDateController = TextEditingController(
      text: _formatInitialDate(widget.initialReturnDate),
    );
    _returnTimeController = TextEditingController(
      text: _formatInitialTime(widget.initialReturnTime),
    );
    _reasonController = TextEditingController(text: widget.initialReason ?? '');
  }

  @override
  void dispose() {
    _returnDateController.dispose();
    _returnTimeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  String _formatInitialDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    try {
      final parsed = DateTime.parse(raw.trim());
      return DateFormat('MM/dd/yyyy').format(parsed);
    } catch (_) {
      return raw.trim();
    }
  }

  String _formatInitialTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    try {
      final parts = raw.trim().split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final now = DateTime.now();
        final dateTime = DateTime(now.year, now.month, now.day, hour, minute);
        return DateFormat('hh:mm a').format(dateTime);
      }
    } catch (_) {}
    return raw.trim();
  }

  String _toApiDate(String displayDate) {
    final parsed = DateFormat('MM/dd/yyyy').parse(displayDate);
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  String _toApiTime(String displayTime) {
    final parsed = DateFormat('hh:mm a').parse(displayTime);
    return DateFormat('HH:mm').format(parsed);
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _returnDateController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _returnTimeController.text = DateFormat('hh:mm a').format(dateTime);
    }
  }

  Widget _mandatoryLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.requestDetailsFieldHeading(fontSize: 13).copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textHeading,
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: Icon(icon, size: 20, color: AppColors.grey50),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryBlue75),
      ),
    );
  }

  Future<void> _submit(DashboardL10n l10n) async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;

    setState(() => _isSubmitting = true);
    try {
      await widget.onSubmit(
        actualReturnDate: _toApiDate(_returnDateController.text.trim()),
        actualVehicleReturnTime: _toApiTime(_returnTimeController.text.trim()),
        reason: _reasonController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (_) {
      // Repository shows toast for errors.
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.transportUpdateActualReturnTitle,
                  style: AppTextStyles.requestDetailsSectionHeading(
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _mandatoryLabel(l10n.transportActualReturnDate),
          const SizedBox(height: 8),
          TextFormField(
            controller: _returnDateController,
            readOnly: true,
            onTap: _isSubmitting ? null : _pickDate,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.transportSelectReturnDate;
              }
              return null;
            },
            decoration: _fieldDecoration(
              hint: 'mm/dd/yyyy',
              icon: Icons.calendar_today_outlined,
            ),
          ),
          const SizedBox(height: 20),
          _mandatoryLabel(l10n.transportActualVehicleReturnTime),
          const SizedBox(height: 8),
          TextFormField(
            controller: _returnTimeController,
            readOnly: true,
            onTap: _isSubmitting ? null : _pickTime,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.transportSelectReturnTime;
              }
              return null;
            },
            decoration: _fieldDecoration(
              hint: 'hh:mm aa',
              icon: Icons.access_time_outlined,
            ),
          ),
          const SizedBox(height: 20),
          _mandatoryLabel(l10n.transportReason),
          const SizedBox(height: 8),
          TextFormField(
            controller: _reasonController,
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.transportReasonRequired;
              }
              return null;
            },
            decoration: _fieldDecoration(
              hint: l10n.transportEnterReason,
              icon: Icons.notes_outlined,
            ).copyWith(
              suffixIcon: null,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondaryText,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.close, size: 18),
                label: Text(l10n.transportFormCancel),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: _isSubmitting ? null : () => _submit(l10n),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue75,
                  foregroundColor: AppColors.loginText,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_circle_outline, size: 18),
                label: Text(l10n.commentButtonUpdate),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
