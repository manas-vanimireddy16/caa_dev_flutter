part of '../view.dart';

/// Level-2 "first approval" dialog: rate each goal from request details.
class PerformanceManagementFirstApprovalDialog extends StatefulWidget {
  final List<GoalModel> goals;
  final String subtitle;
  final Future<void> Function(List<Map<String, dynamic>> goalPayload) onApprove;

  const PerformanceManagementFirstApprovalDialog({
    super.key,
    required this.goals,
    required this.subtitle,
    required this.onApprove,
  });

  @override
  State<PerformanceManagementFirstApprovalDialog> createState() =>
      _PerformanceManagementFirstApprovalDialogState();
}

class _PerformanceManagementFirstApprovalDialogState
    extends State<PerformanceManagementFirstApprovalDialog> {
  late final List<TextEditingController> _ratingControllers;
  late final List<TextEditingController> _remarkControllers;
  bool _isSubmitting = false;
  bool _showValidation = false;

  @override
  void initState() {
    super.initState();
    _ratingControllers = List.generate(
      widget.goals.length,
      (_) => TextEditingController(),
    );
    _remarkControllers = List.generate(
      widget.goals.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final controller in _ratingControllers) {
      controller.dispose();
    }
    for (final controller in _remarkControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool get _allRatingsEntered => _ratingControllers.every(
    (controller) => controller.text.trim().isNotEmpty,
  );

  List<Map<String, dynamic>> _buildGoalsPayload() {
    return List.generate(widget.goals.length, (index) {
      final goal = widget.goals[index];
      return {
        'id': goal.id,
        'rating': _ratingControllers[index].text.trim(),
        'remark': _remarkControllers[index].text.trim(),
        'goal_title': goal.goalTitle,
        'goal_description': goal.goalDescription,
        'goal_weight': goal.goalWeight,
      };
    });
  }

  Future<void> _submit() async {
    if (!_allRatingsEntered) {
      setState(() => _showValidation = true);
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await widget.onApprove(_buildGoalsPayload());
      if (mounted) {
        KAppX.router.pop();
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  InputDecoration _fieldDecoration({
    required String hint,
    required bool showError,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.requestDetailsFieldHeading(fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF5F5F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: showError
            ? const BorderSide(color: Color(0xFFD92D20))
            : BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: showError ? const Color(0xFFD92D20) : const Color(0xFF0F7B3B),
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.8;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Approve Request',
                          style: AppTextStyles.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 24 / 16,
                            color: AppColors.textHeading,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: AppTextStyles.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: _isSubmitting ? null : () => KAppX.router.pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                shrinkWrap: true,
                itemCount: widget.goals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final goal = widget.goals[index];
                  final weight = goal.goalWeight;
                  final weightLabel = weight == null ? '—' : '$weight%';
                  final description = (goal.goalDescription ?? '').trim();
                  final ratingMissing =
                      _showValidation &&
                      _ratingControllers[index].text.trim().isEmpty;

                  return Card(
                    elevation: 1.5,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (goal.goalTitle ?? '—').trim().isEmpty
                                ? '—'
                                : goal.goalTitle!.trim(),
                            style: AppTextStyles.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textHeading,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDE7F6),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Weight: $weightLabel',
                              style: AppTextStyles.cairo(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description.isEmpty ? '—' : description,
                            style: AppTextStyles.cairo(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Rating',
                            style: AppTextStyles.requestDetailsFieldHeading(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _ratingControllers[index],
                            enabled: !_isSubmitting,
                            keyboardType: TextInputType.text,
                            style: AppTextStyles.requestDetailsFieldContent(
                              fontSize: 14,
                            ),
                            onChanged: (_) {
                              if (_showValidation) setState(() {});
                            },
                            decoration: _fieldDecoration(
                              hint: 'Rating',
                              showError: ratingMissing,
                            ),
                          ),
                          if (ratingMissing) ...[
                            const SizedBox(height: 4),
                            const Text(
                              'Rating is required',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                              ),
                            ),
                          ],
                          const SizedBox(height: 14),
                          Text(
                            'Remarks (Optional)',
                            style: AppTextStyles.requestDetailsFieldHeading(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _remarkControllers[index],
                            enabled: !_isSubmitting,
                            minLines: 1,
                            maxLines: 3,
                            style: AppTextStyles.requestDetailsFieldContent(
                              fontSize: 14,
                            ),
                            decoration: _fieldDecoration(
                              hint: 'Remarks (Optional)',
                              showError: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _isSubmitting ? null : () => KAppX.router.pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.secondaryText,
                      minimumSize: Size(
                        96.toAutoScaledWidth,
                        42.toAutoScaledHeight,
                      ),
                      side: const BorderSide(color: Color(0xFFD0D5DD)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  8.toHorizontalSizedBox,
                  ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _submit,
                    icon: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check_circle_outline, size: 20),
                    label: const Text('Approve'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonGreen,
                      foregroundColor: Colors.white,
                      minimumSize: Size(
                        132.toAutoScaledWidth,
                        42.toAutoScaledHeight,
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
