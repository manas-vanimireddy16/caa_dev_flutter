import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_shell_notifier.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotIntroPanel extends ConsumerWidget {
  const ChatbotIntroPanel({super.key});

  static const _features = [
    'Track requests',
    'View meetings',
    'Read circulars',
    'Get instant answers',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shellNotifier = ref.read(chatbotShellProvider.notifier);

    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          decoration: BoxDecoration(
            color: ChatbotTheme.surface,
            borderRadius: BorderRadius.circular(ChatbotTheme.panelRadius),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: shellNotifier.minimize,
                  icon: const Icon(Icons.close, color: ChatbotTheme.mutedText),
                ),
              ),
              const ChatbotIcon(size: 120),
              const SizedBox(height: 16),
              Text(
                'Hi 👋 I\'m your AI Assistant',
                textAlign: TextAlign.center,
                style: AppTextStyles.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ChatbotTheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ..._features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 18,
                        color: ChatbotTheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature,
                          style: AppTextStyles.cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ChatbotTheme.aiBubbleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: ChatbotTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: shellNotifier.openChat,
                  child: Text(
                    'Chat with AI assistant',
                    style: AppTextStyles.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
