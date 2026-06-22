import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatbotMessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isPending;

  const ChatbotMessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.72,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: ChatbotTheme.userBubble,
            borderRadius: BorderRadius.circular(ChatbotTheme.bubbleRadius),
          ),
          child: Text(
            text,
            style: AppTextStyles.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.only(top: 2, right: 8),
          decoration: BoxDecoration(
            color: ChatbotTheme.inputFill,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: ChatbotIcon(size: 16),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ChatbotTheme.aiBubble,
              borderRadius: BorderRadius.circular(ChatbotTheme.bubbleRadius),
            ),
            child: Text(
              text,
              style: AppTextStyles.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isPending
                    ? ChatbotTheme.mutedText
                    : ChatbotTheme.aiBubbleText,
                height: 1.4,
                fontStyle: isPending ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
