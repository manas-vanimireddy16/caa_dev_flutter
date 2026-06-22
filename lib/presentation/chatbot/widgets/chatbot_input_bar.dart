import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatbotInputBar extends StatefulWidget {
  final bool enabled;
  final ValueChanged<String> onSend;

  const ChatbotInputBar({
    super.key,
    required this.enabled,
    required this.onSend,
  });

  @override
  State<ChatbotInputBar> createState() => _ChatbotInputBarState();
}

class _ChatbotInputBarState extends State<ChatbotInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text;
    if (text.trim().isEmpty || !widget.enabled) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final hasKeyboard = keyboardInset > 0;

    return SafeArea(
      top: false,
      bottom: !hasKeyboard,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: ChatbotTheme.border)),
          color: ChatbotTheme.surface,
        ),
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: ChatbotTheme.inputFill,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: widget.enabled ? (_) => _submit() : null,
                  decoration: InputDecoration(
                    hintText: 'Type your message…',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: AppTextStyles.cairo(
                      fontSize: 14,
                      color: ChatbotTheme.mutedText,
                    ),
                  ),
                  style: AppTextStyles.cairo(
                    fontSize: 14,
                    color: ChatbotTheme.aiBubbleText,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: widget.enabled
                  ? ChatbotTheme.primary
                  : ChatbotTheme.primary.withValues(alpha: 0.4),
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: widget.enabled ? _submit : null,
                child: const SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
