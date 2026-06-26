import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_conversation_notifier.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_input_bar.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_message_bubble.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Full-screen chat conversation body for the AI assistant.
class ChatbotConversationView extends ConsumerStatefulWidget {
  const ChatbotConversationView({super.key});

  @override
  ConsumerState<ChatbotConversationView> createState() =>
      _ChatbotConversationViewState();
}

class _ChatbotConversationViewState
    extends ConsumerState<ChatbotConversationView> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatbotConversationProvider, (_, __) => _scrollToBottom());

    final conversation = ref.watch(chatbotConversationProvider);

    return ColoredBox(
      color: ChatbotTheme.surface,
      child: Column(
        children: [
          Expanded(
            child: conversation.messages.isEmpty
                ? _EmptyChatState(isSending: conversation.isSending)
                : ListView.builder(
                    controller: _scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    itemCount: conversation.messages.length +
                        (conversation.isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (conversation.isSending &&
                          index == conversation.messages.length) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: ChatbotMessageBubble(
                            text: 'Thinking…',
                            isUser: false,
                            isPending: true,
                          ),
                        );
                      }

                      final message = conversation.messages[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ChatbotMessageBubble(
                          text: message.text,
                          isUser: message.isUser,
                        ),
                      );
                    },
                  ),
          ),
          ChatbotInputBar(
            enabled: !conversation.isSending,
            onSend: (text) => ref
                .read(chatbotConversationProvider.notifier)
                .sendMessage(text),
          ),
        ],
      ),
    );
  }
}

class _EmptyChatState extends StatelessWidget {
  final bool isSending;

  const _EmptyChatState({required this.isSending});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ChatbotIcon(size: 72),
            const SizedBox(height: 16),
            Text(
              'Hi, I\'m your AI Assistant',
              textAlign: TextAlign.center,
              style: AppTextStyles.cairo(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ChatbotTheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask me about requests, meetings, or circulars.',
              textAlign: TextAlign.center,
              style: AppTextStyles.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ChatbotTheme.mutedText,
              ),
            ),
            if (isSending) ...[
              const SizedBox(height: 16),
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
