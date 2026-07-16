// Model for each comment entry

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:code_setup/utils/helper/localized_display_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class _CommentsRoutingStyles {
  static const borderColor = Color(0xFFE5E7EB);
  static const fieldFill = Color(0xFFF3F4F6);
  static const needMoreInfoGreen = Color(0xFF1B5E3B);
  static const approveGreen = Color(0xFF0D652D);
  static const rejectRed = Color(0xFFC02211);
  static const cardBackground = Color(0xFFFAFAFA);
  static const allocateBlue = Color(0xFF0274D1);
}

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
  final DashboardL10n? l10n;

  const CommentEntry({super.key, required this.data, this.l10n});

  String _localizedMessage(DashboardL10n labels) {
    final message = localizedDisplayName(
      isArabic: labels.isArabic,
      english: data.message,
      arabic: data.messageAr,
    );
    return message.isEmpty ? '-' : message;
  }

  String _localizedStatus(DashboardL10n labels) {
    final status = localizedDisplayName(
      isArabic: labels.isArabic,
      english: data.status,
      arabic: data.statusAr,
    );
    if (status.isNotEmpty) return status;
    final raw = data.status?.trim();
    if (raw != null && raw.isNotEmpty) {
      return labels.statusLabel(raw);
    }
    return '-';
  }

  String _localizedRole(DashboardL10n labels) {
    final role = localizedDisplayName(
      isArabic: labels.isArabic,
      english: data.role?.name,
      arabic: data.role?.arabicName,
    );
    return role.isEmpty ? (labels.isArabic ? 'موظف' : 'Employee') : role;
  }

  @override
  Widget build(BuildContext context) {
    final labels = l10n ?? DashboardL10n.of(context);
    final String dateTime = formatDate(data.createdAt);
    final String action = _localizedMessage(labels);
    final String role = _localizedRole(labels);
    final String status = _localizedStatus(labels);

    return Container(
      padding: EdgeInsets.all(12.toAutoScaledWidth),
      decoration: BoxDecoration(
        color: _CommentsRoutingStyles.cardBackground,
        borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
        border: Border.all(color: _CommentsRoutingStyles.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _labelValue(
                  labels.routingTileDateTime,
                  dateTime,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 8.toAutoScaledWidth),
              Expanded(
                child: _labelValue(labels.routingTileRole, role, maxLines: 1),
              ),
            ],
          ),
          SizedBox(height: 16.toAutoScaledHeight),
          _labelValue(labels.routingTileAction, action, maxLines: 2),
          SizedBox(height: 16.toAutoScaledHeight),
          _labelValue(labels.routingTileStatus, status, maxLines: 1),
        ],
      ),
    );
  }

  Widget _labelValue(String label, String value, {int maxLines = 2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.requestDetailsFieldHeading()),
        SizedBox(height: 4.toAutoScaledHeight),
        Text(
          value,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.requestDetailsFieldContent(),
        ),
      ],
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
  final Future<void> Function()? onUpdate;
  final Future<void> Function()? onReplace;
  final Future<void> Function()? onInProgress;
  final Future<void> Function()? onComplete;

  final bool buttonsDisabled;
  final bool updateButtonDisabled;

  final String? commentHint;
  final String? needMoreInfoLabel;

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
    this.onUpdate,
    this.onReplace,
    this.onInProgress,
    this.onComplete,
    this.buttonsDisabled = false,
    this.updateButtonDisabled = false,
    this.commentHint,
    this.needMoreInfoLabel,
  });

  @override
  State<AddCommentBox> createState() => _AddCommentBoxState();
}

class _AddCommentBoxState extends State<AddCommentBox> {
  bool isCommentMode = false;
  Widget _actionButton(
    String text,
    Color color,
    VoidCallback? onTap, {
    Widget? icon,
    bool disabled = false,
  }) {
    final isDisabled = widget.buttonsDisabled || disabled;
    final borderRadius = BorderRadius.circular(4.toAutoScaledWidth);

    return ElevatedButton(
      onPressed: isDisabled ? null : onTap,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(0, 36.toAutoScaledHeight)),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 8.toAutoScaledWidth,
            vertical: 8.toAutoScaledHeight,
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return color.withValues(alpha: 0.6);
          }
          return color;
        }),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: borderRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, SizedBox(width: 4.toAutoScaledWidth)],
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.cairo(
                color: Colors.white.withValues(alpha: isDisabled ? 0.7 : 1),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _whiteActionIcon(String assetPath) {
    return SvgPicture.asset(
      assetPath,
      width: 14.toAutoScaledWidth,
      height: 14.toAutoScaledHeight,
    );
  }

  // Widget _needMoreInfoTriggerButton(DashboardL10n l10n) {
  //   return Material(
  //     color: _CommentsRoutingStyles.needMoreInfoGreen,
  //     borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
  //     clipBehavior: Clip.antiAlias,
  //     child: InkWell(
  //       onTap: () => setState(() => isCommentMode = true),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: 14.toAutoScaledWidth,
  //           vertical: 8.toAutoScaledHeight,
  //         ),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               widget.needMoreInfoLabel ?? l10n.needMoreInfo,
  //               style: AppTextStyles.cairo(
  //                 color: Colors.white,
  //                 fontSize: 13,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             SizedBox(width: 6.toAutoScaledWidth),
  //             Icon(Icons.add, color: Colors.white, size: 16.toAutoScaledWidth),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _needMoreInfoTriggerButton(DashboardL10n l10n) {
    return Material(
      color: Colors.white,
      // borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
        side: BorderSide(
          color: _CommentsRoutingStyles.needMoreInfoGreen,
          width: 1.2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => isCommentMode = true),
        borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.toAutoScaledWidth,
            vertical: 8.toAutoScaledHeight,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.needMoreInfoLabel ?? l10n.needMoreInfo,
                style: AppTextStyles.cairo(
                  color: _CommentsRoutingStyles.needMoreInfoGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6.toAutoScaledWidth),
              Icon(
                Icons.add,
                color: _CommentsRoutingStyles.needMoreInfoGreen,
                size: 16.toAutoScaledWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachFileButton(DashboardL10n l10n) {
    return OutlinedButton(
      onPressed: widget.onAttach,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(0, 40.toAutoScaledHeight),
        padding: EdgeInsets.symmetric(
          horizontal: 12.toAutoScaledWidth,
          vertical: 8.toAutoScaledHeight,
        ),
        side: const BorderSide(color: _CommentsRoutingStyles.borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
        ),
        foregroundColor: const Color(0xFF374151),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.attach_file, size: 16.toAutoScaledWidth),
          SizedBox(width: 6.toAutoScaledWidth),
          Text(
            l10n.attachFile,
            style: TextStyle(
              fontSize: 12.toAutoScaledWidth,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(DashboardL10n l10n) {
    return OutlinedButton(
      onPressed: () {
        widget.controller.clear();
        setState(() => isCommentMode = false);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(0, 36.toAutoScaledHeight),
        padding: EdgeInsets.symmetric(
          horizontal: 12.toAutoScaledWidth,
          vertical: 8.toAutoScaledHeight,
        ),
        side: const BorderSide(color: _CommentsRoutingStyles.borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
        ),
        foregroundColor: const Color(0xFF6B7280),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, size: 16.toAutoScaledWidth),
          SizedBox(width: 6.toAutoScaledWidth),
          Text(
            l10n.transportFormCancel,
            style: AppTextStyles.cairo(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton(DashboardL10n l10n, bool canSend) {
    return ElevatedButton(
      onPressed: canSend
          ? () async {
              await widget.onSend?.call();
              widget.controller.clear();
              setState(() => isCommentMode = false);
            }
          : null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 36.toAutoScaledHeight),
        padding: EdgeInsets.symmetric(
          horizontal: 14.toAutoScaledWidth,
          vertical: 8.toAutoScaledHeight,
        ),
        backgroundColor: _CommentsRoutingStyles.needMoreInfoGreen,
        disabledBackgroundColor: _CommentsRoutingStyles.needMoreInfoGreen
            .withValues(alpha: 0.45),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
        ),
        foregroundColor: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.send, size: 16.toAutoScaledWidth),
          SizedBox(width: 6.toAutoScaledWidth),
          Text(
            'Send',
            style: AppTextStyles.cairo(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedNeedMoreInfoBox(DashboardL10n l10n) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 175.toAutoScaledHeight),
        padding: EdgeInsets.all(12.toAutoScaledWidth),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
          border: Border.all(
            color: _CommentsRoutingStyles.borderColor,
            width: 1,
          ),
        ),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: widget.controller,
          builder: (_, value, __) {
            final hasText = value.text.trim().isNotEmpty;
            final hasAttachment = widget.attachments.isNotEmpty;
            final canSend = hasText || hasAttachment;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.needMoreInfoLabel ?? l10n.needMoreInfo,
                  style: AppTextStyles.requestDetailsSectionHeading(),
                ),
                SizedBox(height: 12.toAutoScaledHeight),
                Text(
                  l10n.transportCommentsOptional,
                  style: AppTextStyles.requestDetailsFieldHeading(),
                ),
                SizedBox(height: 8.toAutoScaledHeight),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.toAutoScaledHeight,
                        decoration: BoxDecoration(
                          color: _CommentsRoutingStyles.fieldFill,
                          borderRadius: BorderRadius.circular(
                            4.toAutoScaledWidth,
                          ),
                          border: Border.all(
                            color: _CommentsRoutingStyles.borderColor,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.toAutoScaledWidth,
                        ),
                        child: TextField(
                          controller: widget.controller,
                          minLines: 1,
                          maxLines: 1,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText:
                                widget.commentHint ??
                                l10n.routingAddCommentHint,
                            hintStyle:
                                AppTextStyles.requestDetailsFieldHeading(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: AppTextStyles.requestDetailsFieldContent(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.toAutoScaledWidth),
                    _buildAttachFileButton(l10n),
                  ],
                ),
                if (widget.attachments.isNotEmpty) ...[
                  SizedBox(height: 8.toAutoScaledHeight),
                  _buildAttachmentsPreview(),
                ],
                SizedBox(height: 12.toAutoScaledHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildCancelButton(l10n),
                    SizedBox(width: 8.toAutoScaledWidth),
                    _buildSendButton(l10n, canSend),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSimpleCommentInput(DashboardL10n l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12.toAutoScaledWidth,
        vertical: 8.toAutoScaledHeight,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
        border: Border.all(color: _CommentsRoutingStyles.borderColor),
      ),
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
                icon: Icon(Icons.attach_file, size: 20.toAutoScaledWidth),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              SizedBox(width: 8.toAutoScaledWidth),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: widget.commentHint ?? l10n.routingAddCommentHint,
                    border: InputBorder.none,
                    isDense: true,
                    hintStyle: AppTextStyles.requestDetailsFieldHeading(),
                  ),
                  style: AppTextStyles.requestDetailsFieldContent(),
                ),
              ),
              IconButton(
                onPressed: canSend
                    ? () async {
                        await widget.onSend?.call();
                        widget.controller.clear();
                        setState(() => isCommentMode = false);
                      }
                    : null,
                icon: Icon(
                  Icons.send,
                  color: canSend ? Colors.blue : Colors.grey,
                  size: 20.toAutoScaledWidth,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildActionButtons(BuildContext context, ActionButtonsType type) {
    final l10n = DashboardL10n.of(context);
    switch (type) {
      case ActionButtonsType.assign:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(l10n.commentButtonAssign, Colors.blue, () async {
              await widget.onAssign?.call();
            }),
          ],
        );

      case ActionButtonsType.approve:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonApprove,
              const Color(0xFF0D652D),
              () async {
                await widget.onApprove?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.assignReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonAssign,
              const Color(0xFF0D652D),
              () async {
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
              },
            ),
            10.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonReject,
              const Color(0xFFC02211),
              () async {
                await widget.onReject?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.approveReject:
        return Row(
          children: [
            Expanded(
              child: _actionButton(
                l10n.commentButtonApprove,
                _CommentsRoutingStyles.approveGreen,
                () async {
                  await widget.onApprove?.call();
                },
                icon: _whiteActionIcon(
                  'assets/icons/check_circle_24dp_white.svg',
                ),
              ),
            ),
            SizedBox(width: 8.toAutoScaledWidth),
            Expanded(
              child: _actionButton(
                l10n.commentButtonReject,
                _CommentsRoutingStyles.rejectRed,
                () async {
                  await widget.onReject?.call();
                },
                icon: _whiteActionIcon('assets/icons/close_24dp_white.svg'),
              ),
            ),
          ],
        );
      case ActionButtonsType.approveRejectAllocateVehicle:
        return Row(
          children: [
            Expanded(
              child: _actionButton(
                l10n.commentButtonAllocateVehicle,
                _CommentsRoutingStyles.allocateBlue,
                () async {
                  await widget.onAssign?.call();
                },
                icon: _whiteActionIcon(
                  'assets/icons/check_circle_24dp_white.svg',
                ),
              ),
            ),
            SizedBox(width: 8.toAutoScaledWidth),
            Expanded(
              child: _actionButton(
                l10n.commentButtonReject,
                _CommentsRoutingStyles.rejectRed,
                () async {
                  await widget.onReject?.call();
                },
                icon: _whiteActionIcon('assets/icons/close_24dp_white.svg'),
              ),
            ),
            SizedBox(width: 8.toAutoScaledWidth),
            Expanded(
              child: _actionButton(
                l10n.commentButtonApprove,
                _CommentsRoutingStyles.approveGreen,
                () async {
                  await widget.onApprove?.call();
                },
                icon: _whiteActionIcon(
                  'assets/icons/check_circle_24dp_white.svg',
                ),
              ),
            ),
          ],
        );
      case ActionButtonsType.assignApproveReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(l10n.commentButtonAssign, Colors.blue, () async {
              await widget.onAssign?.call();
            }),
            _actionButton(
              l10n.commentButtonApprove,
              const Color(0xFF0D652D),
              () async {
                await widget.onApprove?.call();
              },
            ),
            10.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonReject,
              const Color(0xFFC02211),
              () async {
                await widget.onReject?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.reassignCloseReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonReassign,
              const Color(0xFF0D652D),
              () async {
                await widget.onReassign?.call();
              },
            ),
            8.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonClose,
              const Color(0xFF0D652D),
              () async {
                await widget.onClose?.call();
              },
            ),
            8.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonReject,
              const Color(0xFFC02211),
              () async {
                await widget.onReject?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.assignCloseReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonAssign,
              const Color(0xFF0D652D),
              () async {
                await widget.onAssign?.call();
              },
            ),
            8.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonClose,
              const Color(0xFF0D652D),
              () async {
                await widget.onClose?.call();
              },
            ),
            8.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonReject,
              const Color(0xFFC02211),
              () async {
                await widget.onReject?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.closeReject:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonClose,
              const Color(0xFF0D652D),
              () async {
                await widget.onClose?.call();
              },
            ),
            10.toHorizontalSizedBox,
            _actionButton(
              l10n.commentButtonReject,
              const Color(0xFFC02211),
              () async {
                await widget.onReject?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.replace:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(l10n.commentButtonReplace, Colors.blue, () async {
              await widget.onReplace?.call();
            }),
          ],
        );

      case ActionButtonsType.inProgress:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonInProgress,
              const Color(0xFF0D652D),
              () async {
                await widget.onInProgress?.call();
                return;
              },
            ),
          ],
        );
      case ActionButtonsType.complete:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonComplete,
              const Color(0xFF0D652D),
              () async {
                await widget.onComplete?.call();
              },
            ),
          ],
        );

      case ActionButtonsType.update:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonUpdate,
              AppColors.primaryBlue75,
              () async {
                await widget.onUpdate?.call();
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              disabled: widget.updateButtonDisabled,
            ),
          ],
        );

      case ActionButtonsType.approveRejectUpdate:
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: [
            _actionButton(
              l10n.commentButtonApprove,
              const Color(0xFF0D652D),
              () async {
                await widget.onApprove?.call();
              },
            ),
            _actionButton(
              l10n.commentButtonReject,
              const Color(0xFFC02211),
              () async {
                await widget.onReject?.call();
              },
            ),
            _actionButton(
              l10n.commentButtonUpdate,
              AppColors.primaryBlue75,
              () async {
                await widget.onUpdate?.call();
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              disabled: widget.updateButtonDisabled,
            ),
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
              style: AppTextStyles.requestDetailsFieldContent(),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: widget.onRemove,
            child: const Icon(Icons.close, size: 18, color: Color(0xFFC02211)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final bool isFromActionItems = widget.from.toLowerCase() == 'action items';

    final bool isShowButtons =
        widget.showButtons && !isCommentMode && isFromActionItems;
    final bool isShowCommentBox = !widget.showButtons || isCommentMode;
    final bool isExpandedNeedMoreInfo =
        widget.showButtons && isCommentMode && isShowCommentBox;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Expanded Need More Info UI (NO OUTER BOX)
        if (isExpandedNeedMoreInfo) ...[
          _buildExpandedNeedMoreInfoBox(l10n),

          if (isShowButtons) ...[
            SizedBox(height: 12.toAutoScaledHeight),

            Align(
              alignment: Alignment.centerRight,
              child: buildActionButtons(context, widget.actionType),
            ),
          ],
        ],

        // Normal Comment Input
        if (isShowCommentBox && !widget.showButtons)
          _buildSimpleCommentInput(l10n),

        // Collapsed State Box ONLY
        if (isShowButtons)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.toAutoScaledWidth),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(6.toAutoScaledWidth),
              border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: _needMoreInfoTriggerButton(l10n),
                ),

                SizedBox(height: 16.toAutoScaledHeight),

                Align(
                  alignment: Alignment.centerRight,
                  child: buildActionButtons(context, widget.actionType),
                ),
              ],
            ),
          ),

        // Attachments Preview
        if (widget.attachments.isNotEmpty &&
            !(widget.showButtons && isCommentMode)) ...[
          SizedBox(height: 8.toAutoScaledHeight),
          _buildAttachmentsPreview(),
        ],
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
    final l10n = DashboardL10n.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.toAutoScaledWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
        border: Border.all(color: _CommentsRoutingStyles.borderColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: Colors.black87,
                size: 18.toAutoScaledWidth,
              ),
              SizedBox(width: 8.toAutoScaledWidth),
              Expanded(
                child: Text(
                  l10n.commentsRoutingOverviewTitle,
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
                      l10n.noCommentsYet,
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
    );
  }
}
