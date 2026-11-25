import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';

/// Approve / reject dialog for Duty Mission.
/// On approve with air tickets, requires Business/Economy per employee first.
class DutyMissionApprovalDialog extends StatefulWidget {
  final ApprovalDialogType type;
  final List<AirTicketDetail> airTicketEmployees;
  final Future<void> Function(
    String comment,
    Map<String, String> ticketTypesByEmployeeId,
  )
  onSubmit;

  const DutyMissionApprovalDialog({
    super.key,
    required this.type,
    required this.onSubmit,
    this.airTicketEmployees = const [],
  });

  @override
  State<DutyMissionApprovalDialog> createState() =>
      _DutyMissionApprovalDialogState();
}

class _DutyMissionApprovalDialogState extends State<DutyMissionApprovalDialog> {
  final TextEditingController _commentController = TextEditingController();
  final Map<String, String> _ticketTypes = {};
  bool _isSubmitting = false;

  bool get _isReject => widget.type == ApprovalDialogType.reject;
  bool get _isApprove => widget.type == ApprovalDialogType.approve;
  bool get _needsTicketTypes =>
      _isApprove && widget.airTicketEmployees.isNotEmpty;
  bool get _isCommentRequired => _isReject;

  @override
  void initState() {
    super.initState();
    for (final ticket in widget.airTicketEmployees) {
      final id = ticket.employeeId?.toString() ?? '';
      if (id.isEmpty) continue;
      final existing = ticket.ticketType?.trim() ?? '';
      if (existing.isNotEmpty) {
        _ticketTypes[id] = existing;
      }
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool get _ticketTypesComplete {
    if (!_needsTicketTypes) return true;
    for (final ticket in widget.airTicketEmployees) {
      final id = ticket.employeeId?.toString() ?? '';
      if (id.isEmpty) continue;
      final value = _ticketTypes[id]?.trim() ?? '';
      if (value.isEmpty) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedBuilder(
        animation: _commentController,
        builder: (_, __) {
          final comment = _commentController.text.trim();
          final canSubmit =
              !_isSubmitting &&
              _ticketTypesComplete &&
              (!_isCommentRequired || comment.isNotEmpty);

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isReject ? 'Reject Request' : 'Approve Request',
                      style: AppTextStyles.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textHeading,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 24),
                      onPressed: _isSubmitting
                          ? null
                          : () => KAppX.router.pop(),
                    ),
                  ],
                ),
                8.toVerticalSizedBox,
                Text(
                  _isReject
                      ? 'Are you sure you want to Reject this Request?'
                      : 'Are you sure you want to Approve this Request?',
                  style: AppTextStyles.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkPrimaryTextColor,
                  ),
                ),
                if (_needsTicketTypes) ...[
                  16.toVerticalSizedBox,
                  Text(
                    'Ticket Type*',
                    style: AppTextStyles.requestDetailsFieldHeading(
                      fontSize: 13,
                    ).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.errorRed,
                    ),
                  ),
                  8.toVerticalSizedBox,
                  ...widget.airTicketEmployees.map(_ticketRow),
                  if (!_ticketTypesComplete) ...[
                    4.toVerticalSizedBox,
                    const Text(
                      'Select Business or Economy for every employee',
                      style: TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ],
                ],
                16.toVerticalSizedBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isCommentRequired ? 'Comments*' : 'Comments (Optional)',
                    style: AppTextStyles.requestDetailsFieldHeading(
                      fontSize: 13,
                    ).copyWith(
                      fontWeight: FontWeight.w500,
                      color: _isCommentRequired ? AppColors.errorRed : null,
                    ),
                  ),
                ),
                6.toVerticalSizedBox,
                TextField(
                  controller: _commentController,
                  minLines: 1,
                  maxLines: 3,
                  enabled: !_isSubmitting,
                  decoration: InputDecoration(
                    hintText: 'Add your Comments',
                    filled: true,
                    fillColor: const Color(0xFFF5F5F7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                20.toVerticalSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => KAppX.router.pop(),
                      child: const Text('Cancel'),
                    ),
                    12.toHorizontalSizedBox,
                    ElevatedButton(
                      onPressed: !canSubmit
                          ? null
                          : () async {
                              setState(() => _isSubmitting = true);
                              try {
                                await widget.onSubmit(
                                  comment,
                                  Map<String, String>.from(_ticketTypes),
                                );
                              } finally {
                                if (mounted) {
                                  setState(() => _isSubmitting = false);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isReject
                            ? Colors.red
                            : const Color(0xFF0F7B3B),
                        foregroundColor: Colors.white,
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(_isReject ? 'Reject' : 'Approve'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _ticketRow(AirTicketDetail ticket) {
    final employeeId = ticket.employeeId?.toString() ?? '';
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              ticket.employeeName?.trim().isNotEmpty == true
                  ? ticket.employeeName!
                  : (employeeId.isEmpty ? 'Employee' : 'Employee $employeeId'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.requestDetailsFieldContent(fontSize: 13),
            ),
          ),
          8.toHorizontalSizedBox,
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: _ticketTypes[employeeId],
              isExpanded: true,
              hint: const Text('Select', style: TextStyle(fontSize: 13)),
              items: const [
                DropdownMenuItem(value: 'Business', child: Text('Business')),
                DropdownMenuItem(value: 'Economy', child: Text('Economy')),
              ],
              onChanged: _isSubmitting || employeeId.isEmpty
                  ? null
                  : (value) {
                      setState(() {
                        if (value == null) {
                          _ticketTypes.remove(employeeId);
                        } else {
                          _ticketTypes[employeeId] = value;
                        }
                      });
                    },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F5F7),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
