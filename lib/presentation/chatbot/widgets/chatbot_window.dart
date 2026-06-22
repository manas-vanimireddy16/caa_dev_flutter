import 'dart:math' as math;

import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_conversation_notifier.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_shell_notifier.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_input_bar.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_message_bubble.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotWindow extends ConsumerStatefulWidget {
  final bool isExpanded;

  const ChatbotWindow({
    super.key,
    required this.isExpanded,
  });

  @override
  ConsumerState<ChatbotWindow> createState() => _ChatbotWindowState();
}

class _ChatbotWindowState extends ConsumerState<ChatbotWindow>
    with WidgetsBindingObserver {
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
    final shellNotifier = ref.read(chatbotShellProvider.notifier);
    final media = MediaQuery.of(context);
    final bottomInset = media.padding.bottom;
    final keyboardInset = media.viewInsets.bottom;
    final isKeyboardOpen = keyboardInset > 0;

    const topGap = 16.0;
    final navClearance = bottomInset + ChatbotTheme.bottomNavClearance;
    final bottomOffset = isKeyboardOpen ? keyboardInset + 8 : navClearance;
    final maxPanelHeight =
        media.size.height - media.padding.top - bottomOffset - topGap;

    final panelHeight = widget.isExpanded || isKeyboardOpen
        ? maxPanelHeight
        : math.min(ChatbotTheme.windowHeight, maxPanelHeight);

    final panel = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: widget.isExpanded ? media.size.width : media.size.width - 32,
      height: panelHeight,
      margin: widget.isExpanded
          ? EdgeInsets.only(
              top: media.padding.top + 8,
              bottom: isKeyboardOpen ? keyboardInset : 0,
            )
          : EdgeInsets.fromLTRB(16, 0, 16, bottomOffset),
      decoration: BoxDecoration(
        color: ChatbotTheme.surface,
        borderRadius: BorderRadius.circular(ChatbotTheme.panelRadius),
        border: Border.all(color: ChatbotTheme.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: ChatbotTheme.surface,
        child: Column(
          children: [
            _ChatbotHeader(
              isExpanded: widget.isExpanded,
              onExpand: shellNotifier.toggleExpanded,
              onClose: shellNotifier.minimize,
            ),
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
      ),
    );

    if (widget.isExpanded) {
      return Positioned.fill(
        child: ColoredBox(
          color: ChatbotTheme.backdrop,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: panel,
          ),
        ),
      );
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: panel,
    );
  }
}

class _ChatbotHeader extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onExpand;
  final VoidCallback onClose;

  const _ChatbotHeader({
    required this.isExpanded,
    required this.onExpand,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ChatbotTheme.headerBackground,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'AI assistant',
              style: AppTextStyles.cairo(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            tooltip: isExpanded ? 'Collapse' : 'Expand',
            onPressed: onExpand,
            icon: Icon(
              isExpanded ? Icons.close_fullscreen : Icons.open_in_full,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Colors.white, size: 22),
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
            const ChatbotIcon(size: 48),
            const SizedBox(height: 12),
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
