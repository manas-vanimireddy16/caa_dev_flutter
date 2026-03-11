import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class ApprovalCommentDialog extends StatefulWidget {
  final ApprovalDialogType type;

  /// comment + optional decision number
  final Future<void> Function(String comment, String? decisionNumber) onSubmit;

  /// show / hide decision number field
  final bool showDecisionNumber;

  const ApprovalCommentDialog({
    super.key,
    required this.type,
    required this.onSubmit,
    this.showDecisionNumber = false,
  });

  @override
  State<ApprovalCommentDialog> createState() => _ApprovalCommentDialogState();
}

class _ApprovalCommentDialogState extends State<ApprovalCommentDialog> {
  final TextEditingController _commentController = TextEditingController();

  final TextEditingController _decisionController = TextEditingController();

  bool _isSubmitting = false;

  bool get _isReject => widget.type == ApprovalDialogType.reject;

  bool get _isApprove => widget.type == ApprovalDialogType.approve;

  @override
  void dispose() {
    _commentController.dispose();
    _decisionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      /// Listen to BOTH controllers
      child: AnimatedBuilder(
        animation: Listenable.merge([_commentController, _decisionController]),
        builder: (_, __) {
          final comment = _commentController.text.trim();
          final decision = _decisionController.text.trim();

          /// ✅ VALIDATION RULES
          /// Reject -> comment required
          /// Approve + decision enabled -> decision required
          /// Approve + decision disabled -> no restriction
          final bool canSubmit = _isReject
              ? comment.isNotEmpty
              : widget.showDecisionNumber
              ? decision.isNotEmpty
              : true;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isReject ? "Reject Request" : "Approve Request",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => KAppX.router.pop(),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// COMMENT LABEL
              Text(
                _isReject ? "Reason for Rejection *" : "Comments (Optional)",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              /// COMMENT FIELD
              TextField(
                controller: _commentController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: _isReject
                      ? "Please provide a reason for rejecting this request..."
                      : "Add your comments",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              /// DECISION NUMBER (ONLY FOR APPROVE)
              if (_isApprove && widget.showDecisionNumber) ...[
                const SizedBox(height: 16),

                const Text(
                  "Decision Number *",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: _decisionController,
                  decoration: InputDecoration(
                    hintText: "Enter Decision Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              /// ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting ? null : () => KAppX.router.pop(),
                    child: const Text("CANCEL"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: !canSubmit || _isSubmitting
                        ? null
                        : () async {
                            setState(() => _isSubmitting = true);

                            await widget.onSubmit(
                              comment,
                              decision.isEmpty ? null : decision,
                            );

                            if (mounted) {
                              KAppX.router.pop();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isReject ? Colors.red : Colors.green,
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
                        : const Text("SUBMIT"),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
