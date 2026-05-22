// import 'package:code_setup/presentation/models/buttons_enum.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';

// class ApprovalCommentDialog extends StatefulWidget {
//   final ApprovalDialogType type;

//   /// comment + optional decision number
//   final Future<void> Function(String comment, String? decisionNumber) onSubmit;

//   /// show / hide decision number field
//   final bool showDecisionNumber;

//   const ApprovalCommentDialog({
//     super.key,
//     required this.type,
//     required this.onSubmit,
//     this.showDecisionNumber = false,
//   });

//   @override
//   State<ApprovalCommentDialog> createState() => _ApprovalCommentDialogState();
// }

// class _ApprovalCommentDialogState extends State<ApprovalCommentDialog> {
//   final TextEditingController _commentController = TextEditingController();

//   final TextEditingController _decisionController = TextEditingController();

//   bool _isSubmitting = false;

//   /// =====================================================
//   /// TYPES
//   /// =====================================================

//   bool get _isReject => widget.type == ApprovalDialogType.reject;

//   bool get _isClose => widget.type == ApprovalDialogType.close;

//   bool get _isApprove => widget.type == ApprovalDialogType.approve;

//   /// COMMENT REQUIRED
//   bool get _isCommentRequired => _isReject || _isClose;

//   @override
//   void dispose() {
//     _commentController.dispose();
//     _decisionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),

//       child: AnimatedBuilder(
//         animation: Listenable.merge([_commentController, _decisionController]),

//         builder: (_, __) {
//           final comment = _commentController.text.trim();

//           final decision = _decisionController.text.trim();

//           /// =================================================
//           /// VALIDATION
//           /// =================================================

//           final bool canSubmit = _isCommentRequired
//               ? comment.isNotEmpty
//               : widget.showDecisionNumber
//               ? decision.isNotEmpty
//               : true;

//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               /// =============================================
//               /// HEADER
//               /// =============================================
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                 children: [
//                   Text(
//                     _isReject
//                         ? "Reject Request"
//                         : _isClose
//                         ? "Close Request"
//                         : "Approve Request",

//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),

//                   IconButton(
//                     icon: const Icon(Icons.close),

//                     onPressed: () => KAppX.router.pop(),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               /// =============================================
//               /// COMMENT LABEL
//               /// =============================================
//               ///
//               // Container(),a
//               Text(
//                 _isCommentRequired ? "Comments" : "Comments (Optional)",

//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,

//                   color: _isCommentRequired ? Colors.red : null,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               /// =============================================
//               /// COMMENT FIELD
//               /// =============================================
//               TextField(
//                 controller: _commentController,

//                 minLines: 3,
//                 maxLines: 5,

//                 decoration: InputDecoration(
//                   hintText: "Add your comments",

//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _isCommentRequired && comment.isEmpty
//                           ? Colors.red
//                           : Colors.grey,
//                     ),

//                     borderRadius: BorderRadius.circular(8),
//                   ),

//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _isCommentRequired && comment.isEmpty
//                           ? Colors.red
//                           : Colors.green,
//                     ),

//                     borderRadius: BorderRadius.circular(8),
//                   ),

//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),

//               /// =============================================
//               /// ERROR TEXT
//               /// =============================================
//               if (_isCommentRequired && comment.isEmpty) ...[
//                 const SizedBox(height: 4),

//                 const Text(
//                   "Comments required",

//                   style: TextStyle(color: Colors.red, fontSize: 11),
//                 ),
//               ],

//               /// =============================================
//               /// DECISION NUMBER
//               /// =============================================
//               if (_isApprove && widget.showDecisionNumber) ...[
//                 const SizedBox(height: 16),

//                 const Text(
//                   "Decision Number *",

//                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                 ),

//                 const SizedBox(height: 8),

//                 TextField(
//                   controller: _decisionController,

//                   decoration: InputDecoration(
//                     hintText: "Enter Decision Number",

//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 20),

//               /// =============================================
//               /// ACTION BUTTONS
//               /// =============================================
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,

//                 children: [
//                   TextButton(
//                     onPressed: _isSubmitting ? null : () => KAppX.router.pop(),

//                     child: const Text("Cancel"),
//                   ),

//                   const SizedBox(width: 12),

//                   ElevatedButton(
//                     onPressed: !canSubmit || _isSubmitting
//                         ? null
//                         : () async {
//                             setState(() {
//                               _isSubmitting = true;
//                             });

//                             await widget.onSubmit(
//                               comment,

//                               decision.isEmpty ? null : decision,
//                             );

//                             if (mounted) {
//                               KAppX.router.pop();
//                             }
//                           },

//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _isReject ? Colors.red : Colors.green,
//                     ),

//                     child: _isSubmitting
//                         ? const SizedBox(
//                             height: 18,
//                             width: 18,

//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Text("Submit"),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  /// =====================================================
  /// TYPES
  /// =====================================================

  bool get _isReject => widget.type == ApprovalDialogType.reject;

  bool get _isClose => widget.type == ApprovalDialogType.close;

  bool get _isApprove => widget.type == ApprovalDialogType.approve;

  /// COMMENT REQUIRED
  bool get _isCommentRequired => _isReject || _isClose;

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

      child: AnimatedBuilder(
        animation: Listenable.merge([_commentController, _decisionController]),

        builder: (_, __) {
          final comment = _commentController.text.trim();

          final decision = _decisionController.text.trim();

          /// =================================================
          /// VALIDATION
          /// =================================================

          final bool canSubmit = _isCommentRequired
              ? comment.isNotEmpty
              : widget.showDecisionNumber
              ? decision.isNotEmpty
              : true;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =============================================
              /// HEADER
              /// =============================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isReject
                        ? "Reject Request"
                        : _isClose
                        ? "Close Request"
                        : "Approve Request",

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 24 / 16, // line-height / font-size
                      letterSpacing: 0,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.close, size: 24),

                    onPressed: () => KAppX.router.pop(),
                  ),
                ],
              ),

              8.toVerticalSizedBox,

              /// =============================================
              /// COMMENT BOX
              /// =============================================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),

                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD8D8D8), width: 1),

                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// =============================================
                    /// TOP ICON
                    /// =============================================
                    Container(
                      height: 52.toAutoScaledHeight,
                      width: 52.toAutoScaledWidth,

                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.8, -1),
                          end: Alignment(1, 1),

                          colors: !_isReject
                              ? [Color(0xFFF5DEDB), Color(0xFFF6F6F9)]
                              : [
                                  Color(0xFF25A03B).withValues(alpha: 0.112),
                                  Color(0xFFF6F6F9).withValues(alpha: 0.8),
                                ],
                        ),

                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: _isReject
                          ? SvgPicture.asset(
                              'assets/icons/delete_forever_red.svg',
                            )
                          : SvgPicture.asset(
                              'assets/icons/check_circle_outline_green.svg',

                              width: 28.toAutoScaledWidth,
                              height: 28.toAutoScaledHeight,
                            ),
                    ),

                    20.toVerticalSizedBox,

                    /// =============================================
                    /// TITLE
                    /// =============================================
                    Text(
                      _isReject
                          ? 'Are you sure you want to Reject this Request ?'
                          : 'Are you sure you want to Approve this Request ?',

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        color: Color.fromRGBO(4, 4, 10, 1),
                      ),
                    ),

                    20.toVerticalSizedBox,

                    /// =============================================
                    /// COMMENT LABEL
                    /// =============================================
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Text(
                        _isCommentRequired ? "Comments" : "Comments (Optional)",

                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _isCommentRequired ? Colors.red : null,
                        ),
                      ),
                    ),

                    6.toVerticalSizedBox,

                    /// =============================================
                    /// COMMENT FIELD
                    /// =============================================
                    TextField(
                      controller: _commentController,
                      minLines: 1,
                      maxLines: 3,

                      decoration: InputDecoration(
                        hintText: "Add your Comments",

                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),

                        filled: true,

                        fillColor: const Color(0xFFF5F5F7),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide(
                            color: _isCommentRequired
                                ? const Color(0xFFD92D20)
                                : const Color(0xFF0F7B3B),

                            width: 1,
                          ),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    16.toVerticalSizedBox,

                    /// =============================================
                    /// ERROR TEXT
                    /// =============================================
                    if (_isCommentRequired && comment.isEmpty) ...[
                      const SizedBox(height: 4),

                      const Text(
                        "Comments required",

                        style: TextStyle(color: Colors.red, fontSize: 11),
                      ),
                    ],

                    /// =============================================
                    /// DECISION NUMBER
                    /// =============================================
                    if (_isApprove && widget.showDecisionNumber) ...[
                      const SizedBox(height: 16),

                      const Text(
                        "Decision Number *",

                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      8.toVerticalSizedBox,

                      TextField(
                        controller: _decisionController,

                        decoration: InputDecoration(
                          hintText: "Enter Decision Number",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],

                    16.toVerticalSizedBox,

                    /// =============================================
                    /// ACTION BUTTONS
                    /// =============================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ================= CANCEL BUTTON =================
                        OutlinedButton.icon(
                          onPressed: _isSubmitting
                              ? null
                              : () => KAppX.router.pop(),

                          icon: const Icon(Icons.close, size: 20),

                          label: const Text("Cancel"),

                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF434347),

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

                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        8.toHorizontalSizedBox,

                        /// ================= APPROVE BUTTON =================
                        ElevatedButton.icon(
                          onPressed: !canSubmit || _isSubmitting
                              ? null
                              : () async {
                                  setState(() {
                                    _isSubmitting = true;
                                  });

                                  await widget.onSubmit(
                                    comment,
                                    decision.isEmpty ? null : decision,
                                  );

                                  if (mounted) {
                                    KAppX.router.pop();
                                  }
                                },

                          icon: _isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,

                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.check_circle_outline,
                                  size: 20,
                                ),

                          label: Text(_isReject ? "Reject" : "Approve"),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isReject
                                ? AppColors.buttonRed
                                : AppColors.buttonGreen,

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

                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
