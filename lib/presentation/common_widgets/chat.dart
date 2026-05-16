import 'package:code_setup/presentation/common_widgets/comment.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
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
  final Future<void> Function()? onReplace;
  final Future<void> Function()? onInProgress;
  final Future<void> Function()? onComplete;

  final ActionButtonsType actionType;
  final bool buttonsDisabled;

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
    this.onReplace,
    this.buttonsDisabled = false,
    required this.attachments,
    this.onInProgress,
    this.onComplete,
    this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;

    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFDDDDDD), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                const Icon(Icons.history, size: 20, color: Colors.black87),
                const SizedBox(width: 8),
                Text(
                  l10n?.commentsRoutingOverviewTitle ??
                      'Comments / Routing Overview',
                  style: TextStyle(
                    fontSize: theme.fontSizes.s16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),

            /// Chat list (scrollable)
            SizedBox(
              height: 320,
              child: entries.isEmpty
                  ? Center(
                      child: Text(
                        l10n?.noCommentsYet ?? 'No comments yet',
                        style: const TextStyle(color: Colors.black38),
                      ),
                    )
                  : ListView.separated(
                      itemCount: entries.length,
                      padding: const EdgeInsets.only(bottom: 12),
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (_, index) =>
                          CommentEntry(data: entries[index], l10n: l10n),
                    ),
            ),

            14.toVerticalSizedBox,

            /// Input + Approve/Reject
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
              onReplace: onReplace,
              buttonsDisabled: buttonsDisabled,
              onInProgress: onInProgress,
              onComplete: onComplete,
              commentHint: l10n?.routingAddCommentHint,
              needMoreInfoLabel: l10n?.needMoreInfo,
            ),
          ],
        ),
      ),
    );
  }
}
