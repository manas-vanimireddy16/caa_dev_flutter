import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Compact action chips shown under AI answers and navigation prompts.
class ChatbotActionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool selected;
  final bool emphasized;

  const ChatbotActionChip({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.selected = false,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final foreground = selected || emphasized
        ? Colors.white
        : ChatbotTheme.primary;
    final background = !enabled
        ? ChatbotTheme.border.withValues(alpha: 0.5)
        : selected || emphasized
        ? ChatbotTheme.primary
        : Colors.white;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected || emphasized
                  ? ChatbotTheme.primary
                  : ChatbotTheme.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: foreground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatbotMessageActions extends StatelessWidget {
  final ChatbotFeedbackChoice? feedback;
  final bool showFeedback;
  final bool showShowServices;
  final bool showShowSubServices;
  final bool showShowQuestions;
  final VoidCallback? onHelpful;
  final VoidCallback? onNotHelpful;
  final VoidCallback? onShowServices;
  final VoidCallback? onShowSubServices;
  final VoidCallback? onShowQuestions;

  const ChatbotMessageActions({
    super.key,
    this.feedback,
    this.showFeedback = false,
    this.showShowServices = false,
    this.showShowSubServices = false,
    this.showShowQuestions = false,
    this.onHelpful,
    this.onNotHelpful,
    this.onShowServices,
    this.onShowSubServices,
    this.onShowQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final hasFeedback = feedback != null;

    return Padding(
      padding: const EdgeInsets.only(left: 36, top: 8, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (showFeedback) ...[
                ChatbotActionChip(
                  label: '👍 Helpful',
                  selected: feedback == ChatbotFeedbackChoice.helpful,
                  onTap: hasFeedback ? null : onHelpful,
                ),
                ChatbotActionChip(
                  label: '👎 Not Helpful',
                  selected: feedback == ChatbotFeedbackChoice.notHelpful,
                  onTap: hasFeedback ? null : onNotHelpful,
                ),
              ],
              if (showShowServices)
                ChatbotActionChip(
                  label: 'Show Services',
                  icon: Icons.apps_rounded,
                  onTap: onShowServices,
                ),
              if (showShowSubServices)
                ChatbotActionChip(
                  label: 'Show Sub-Services',
                  icon: Icons.list_alt_rounded,
                  onTap: onShowSubServices,
                ),
              if (showShowQuestions)
                ChatbotActionChip(
                  label: 'Show Questions',
                  icon: Icons.help_outline_rounded,
                  onTap: onShowQuestions,
                ),
            ],
          ),
          if (hasFeedback) ...[
            const SizedBox(height: 6),
            Text(
              'Thanks for your feedback!',
              style: AppTextStyles.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ChatbotTheme.mutedText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
