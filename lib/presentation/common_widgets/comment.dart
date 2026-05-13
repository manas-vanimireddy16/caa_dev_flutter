// Model for each comment entry

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:flutter/material.dart';

enum CommentStatus { pending, validating, approved }

class StatusBadge extends StatelessWidget {
  final CommentStatus status;
  final String label;

  const StatusBadge({super.key, required this.status, required this.label});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;
    switch (status) {
      case CommentStatus.pending:
        bg = const Color(0xFFFDF5DF);
        fg = const Color(0xFFF4B31C);
        icon = Icons.access_time;
        break;
      case CommentStatus.validating:
        bg = const Color(0xFFE2EEFF);
        fg = const Color(0xFF1A99F2);
        icon = Icons.autorenew;
        break;
      case CommentStatus.approved:
        bg = const Color(0xFFC9F1DF);
        fg = const Color(0xFF31B480);
        icon = Icons.check_circle_outline;
        break;
    }

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fg, size: 17),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: currentTheme.fontSizes.s14,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// COMMENT ENTRY WIDGET
// ------------------------------------------------------------

class CommentEntry extends StatelessWidget {
  final ChatMessageModel data;
  const CommentEntry({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String dateTime = formatDate(data.createdAt);
    final String action = data.message ?? "-";
    final String role = data.role?.name ?? "Employee";
    final String status = data.status ?? "-";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          /// -------- ROW 1 --------
          Row(children: [_item("Date / Time", dateTime), _item("Role", role)]),

          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade300, height: 1),
          const SizedBox(height: 12),

          /// -------- ROW 2 --------
          Row(children: [_item("Action", action), _item("Status", status)]),
        ],
      ),
    );
  }

  /// Label + value (no box)
  Widget _item(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// Status with chip
  Widget _statusItem(String label, String status) {
    final Color color = status.toLowerCase() == "approved"
        ? Colors.green
        : status.toLowerCase() == "rejected"
        ? Colors.red
        : Colors.orange;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// ADD COMMENT BOX — FIXED & COMPLETE

class AddCommentBox extends StatefulWidget {
  final String from;
  final String source;
  final bool showButtons;
  final ActionButtonsType actionType;

  final TextEditingController controller;
  final List<Map<String, dynamic>> attachments;

  final VoidCallback? onAttach;
  final VoidCallback? onRemove;
  final Future<void> Function()? onSend;

  final Future<void> Function()? onAssign;
  final Future<void> Function()? onReassign;
  final Future<void> Function()? onClose;
  final Future<void> Function()? onReject;
  final Future<void> Function()? onApprove;
  final Future<void> Function()? onReplace;
  final Future<void> Function()? onInProgress;
  final Future<void> Function()? onComplete;

  final bool buttonsDisabled;

  const AddCommentBox({
    super.key,
    this.from = '',
    this.source = '',
    this.showButtons = false,
    required this.actionType,
    required this.controller,
    required this.attachments,
    this.onAttach,
    this.onRemove,
    this.onSend,
    this.onAssign,
    this.onReassign,
    this.onClose,
    this.onReject,
    this.onApprove,
    this.onReplace,
    this.onInProgress,
    this.onComplete,
    this.buttonsDisabled = false,
  });

  @override
  State<AddCommentBox> createState() => _AddCommentBoxState();
}

class _AttachmentPreview extends StatelessWidget {
  final Map<String, dynamic> file;
  final VoidCallback? onRemove;

  const _AttachmentPreview({required this.file, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFD6E4FF)),
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              file['file_name'] ?? 'File',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class _AddCommentBoxState extends State<AddCommentBox> {
  bool isCommentMode = false;

  Widget _actionButton(String text, Color color, VoidCallback? onTap) {
    final disabled = widget.buttonsDisabled;

    return ElevatedButton(
      onPressed: disabled ? null : onTap,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(100, 35)),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return color.withOpacity(0.6);
          }
          return color;
        }),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white.withOpacity(disabled ? 0.7 : 1)),
      ),
    );
  }

  Widget buildActionButtons(ActionButtonsType type) {
    switch (type) {
      case ActionButtonsType.assign:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Assign", Colors.blue, () async {
              await widget.onAssign?.call();
            }),
          ],
        );

      case ActionButtonsType.approve:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Approve", Colors.green, () async {
              await widget.onApprove?.call();
            }),
          ],
        );

      case ActionButtonsType.assignReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Assign", Colors.green, () async {
              if (widget.source.toLowerCase() == 'securityawarenessassign') {
                KAppX.router.push(
                  OrganizeSecurityAwarenessNewRequestRoute(
                    source: widget.source,
                    service: Service(),
                    subService: SubService(),
                  ),
                );
                return;
              }
              await widget.onAssign?.call();
            }),
            10.toHorizontalSizedBox,
            _actionButton("Reject", Colors.red, () async {
              await widget.onReject?.call();
            }),
          ],
        );

      case ActionButtonsType.approveReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Approve", Colors.green, () async {
              await widget.onApprove?.call();
            }),
            10.toHorizontalSizedBox,
            _actionButton("Reject", Colors.red, () async {
              await widget.onReject?.call();
            }),
          ],
        );
      case ActionButtonsType.approveRejectAllocateVehicle:
        return Wrap(
          children: [
            _actionButton("Approve", Colors.green, () async {
              await widget.onApprove?.call();
            }),
            10.toHorizontalSizedBox,
            _actionButton("Reject", Colors.red, () async {
              await widget.onReject?.call();
            }),
            _actionButton(
              "Allocate Vehicle",
              const Color.fromARGB(189, 2, 116, 209),
              () async {
                await widget.onAssign?.call();
              },
            ),
          ],
        );
      case ActionButtonsType.assignApproveReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Assign", Colors.blue, () async {
              await widget.onAssign?.call();
            }),
            _actionButton("Approve", Colors.green, () async {
              await widget.onApprove?.call();
            }),
            10.toHorizontalSizedBox,
            _actionButton("Reject", Colors.red, () async {
              await widget.onReject?.call();
            }),
          ],
        );

      case ActionButtonsType.reassignCloseReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Reassign", Colors.orange, () async {
              await widget.onReassign?.call();
            }),
            8.toHorizontalSizedBox,
            _actionButton("Close", Colors.green, () async {
              await widget.onClose?.call();
            }),
            8.toHorizontalSizedBox,
            _actionButton("Reject", Colors.red, () async {
              await widget.onReject?.call();
            }),
          ],
        );

      case ActionButtonsType.closeReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Close", Colors.green, () async {
              await widget.onClose?.call();
            }),
            10.toHorizontalSizedBox,
            _actionButton("Reject", Colors.red, () async {
              await widget.onReject?.call();
            }),
          ],
        );

      case ActionButtonsType.replace:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Replace", Colors.blue, () async {
              await widget.onReplace?.call();
            }),
          ],
        );

      case ActionButtonsType.inProgress:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("In Progress", Colors.green, () async {
              await widget.onInProgress?.call();
              return;
            }),
          ],
        );
      case ActionButtonsType.complete:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton("Complete", Colors.green, () async {
              await widget.onComplete?.call();
            }),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAttachmentsPreview() {
    if (widget.attachments.isEmpty) return const SizedBox.shrink();

    final file = widget.attachments.first;
    final name = file['file_name'] ?? 'File';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFD6E4FF)),
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file, size: 18, color: Color(0xFF2979FF)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: widget.onRemove,
            child: const Icon(Icons.close, size: 18, color: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;
    final bool isFromActionItems = widget.from.toLowerCase() == 'action items';

    final bool isShowButtons =
        widget.showButtons && !isCommentMode && isFromActionItems;
    final bool isShowCommentBox = !widget.showButtons || isCommentMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// COMMENT INPUT
        if (isShowCommentBox)
          Card(
            color: theme.colors.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFEAEAEF)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (_, value, __) {
                  final hasText = value.text.trim().isNotEmpty;
                  final hasAttachment = widget.attachments.isNotEmpty;

                  final canSend = hasText || hasAttachment;

                  return Row(
                    children: [
                      IconButton(
                        onPressed: widget.onAttach,
                        icon: const Icon(Icons.attach_file),
                      ),
                      Expanded(
                        child: TextField(
                          controller: widget.controller,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (widget.showButtons && isCommentMode)
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            widget.controller.clear();
                            setState(() => isCommentMode = false);
                          },
                        ),
                      IconButton(
                        onPressed: canSend
                            ? () async {
                                await widget.onSend
                                    ?.call(); // ✅ WAIT until send finishes
                                widget.controller.clear(); // ✅ clear AFTER send
                                setState(() => isCommentMode = false);
                              }
                            : null,
                        icon: Icon(
                          Icons.send,
                          color: canSend ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

        /// NEED MORE INFO
        if (widget.showButtons && !isCommentMode) ...[
          6.toVerticalSizedBox,
          InkWell(
            onTap: () => setState(() => isCommentMode = true),
            child: Row(
              children: const [
                Icon(Icons.info_outline, size: 18, color: Colors.blue),
                SizedBox(width: 6),
                Text(
                  "Need more info",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],

        if (widget.attachments.isNotEmpty) ...[
          6.toVerticalSizedBox,
          _buildAttachmentsPreview(),
        ],

        10.toVerticalSizedBox,

        if (isShowButtons) buildActionButtons(widget.actionType),
      ],
    );
  }
}

// ------------------------------------------------------------
// COMMENTS OVERVIEW CARD
// ------------------------------------------------------------

class CommentsRoutingOverview extends StatelessWidget {
  final List<ChatMessageModel> entries;
  final TextEditingController controller = TextEditingController();

  CommentsRoutingOverview({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;

    return Card(
      color: theme.colors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: Colors.black87, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Comments / Routing Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: theme.fontSizes.s16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),

            ...entries.map((entry) => CommentEntry(data: entry)),

            AddCommentBox(
              controller: controller,
              actionType: ActionButtonsType.none,
              attachments: [],
              onAttach: () async {},
              onSend: () async {},
              onClose: () async {},
              onReject: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
