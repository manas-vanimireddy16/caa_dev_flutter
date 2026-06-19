import 'package:code_setup/presentation/common_widgets/request_details/comment.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';

class CommentsCard extends StatelessWidget {
  final String from;
  final String source;
  final bool showButtons;
  final List<ChatMessageModel> entries;
  final TextEditingController controller;
  final Future<void> Function()? onSend;
  final List<Map<String, dynamic>> attachments;

  final VoidCallback? onAttach;
  final VoidCallback? onRemove;
  final Future<void> Function()? onClose;
  final Future<void> Function()? onReject;
  final Future<void> Function()? onAssign;
  final Future<void> Function()? onReassign;
  final Future<void> Function()? onApprove;
  final Future<void> Function()? onUpdate;
  final Future<void> Function()? onReplace;
  final Future<void> Function()? onInProgress;
  final Future<void> Function()? onComplete;

  final ActionButtonsType actionType;
  final bool buttonsDisabled;
  final bool updateButtonDisabled;

  final DashboardL10n? l10n;

  const CommentsCard({
    super.key,
    this.from = '',
    this.source = '',
    this.showButtons = false,
    required this.entries,
    required this.controller,
    required this.actionType,
    this.onSend,
    this.onAttach,
    this.onRemove,
    this.onReject,
    this.onClose,
    this.onAssign,
    this.onReassign,
    this.onApprove,
    this.onUpdate,
    this.onReplace,
    this.buttonsDisabled = false,
    this.updateButtonDisabled = false,
    required this.attachments,
    this.onInProgress,
    this.onComplete,
    this.l10n,
  });

  static const _borderColor = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    // Must stay scroll-view safe: no Flexible/Expanded — parent is
    // SingleChildScrollView > Column in request detail screens.
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 12.toAutoScaledWidth),
      padding: EdgeInsets.all(12.toAutoScaledWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                size: 18.toAutoScaledWidth,
                color: Colors.black87,
              ),
              SizedBox(width: 8.toAutoScaledWidth),
              Expanded(
                child: Text(
                  l10n?.commentsRoutingOverviewTitle ??
                      'Comments / Routing Overview',
                  style: AppTextStyles.requestDetailsSectionHeading(),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.toAutoScaledHeight),
          SizedBox(
            width: double.infinity,
            height: 336.toAutoScaledHeight,
            child: entries.isEmpty
                ? Center(
                    child: Text(
                      l10n?.noCommentsYet ?? 'No comments yet',
                      style: AppTextStyles.requestDetailsFieldContent(),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: entries.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.toAutoScaledWidth,
                    ),
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 8.toAutoScaledHeight),
                    itemBuilder: (_, index) =>
                        CommentEntry(data: entries[index], l10n: l10n),
                  ),
          ),
          SizedBox(height: 8.toAutoScaledHeight),
          AddCommentBox(
            from: from,
            source: source,
            showButtons: showButtons,
            controller: controller,
            onSend: onSend,
            attachments: attachments,
            onAttach: onAttach,
            onRemove: onRemove,
            onClose: onClose,
            onReject: onReject,
            onAssign: onAssign,
            onReassign: onReassign,
            actionType: actionType,
            onApprove: onApprove,
            onUpdate: onUpdate,
            onReplace: onReplace,
            buttonsDisabled: buttonsDisabled,
            updateButtonDisabled: updateButtonDisabled,
            onInProgress: onInProgress,
            onComplete: onComplete,
            commentHint: l10n?.routingAddCommentHint,
            needMoreInfoLabel: l10n?.needMoreInfo,
          ),
        ],
      ),
    );
  }
}
