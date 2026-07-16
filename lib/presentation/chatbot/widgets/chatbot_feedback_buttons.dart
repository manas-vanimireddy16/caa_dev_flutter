import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatbotFeedbackButtons extends StatelessWidget {
  final VoidCallback? onHelpful;
  final VoidCallback? onNotHelpful;

  const ChatbotFeedbackButtons({
    super.key,
    required this.onHelpful,
    required this.onNotHelpful,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          _FeedbackButton(
            label: 'Helpful',
            icon: Icons.thumb_up_alt_outlined,
            onTap: onHelpful,
          ),
          _FeedbackButton(
            label: 'Not Helpful',
            icon: Icons.thumb_down_alt_outlined,
            onTap: onNotHelpful,
          ),
        ],
      ),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _FeedbackButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: ChatbotTheme.primary,
        side: const BorderSide(color: ChatbotTheme.border),
        textStyle: AppTextStyles.cairo(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
