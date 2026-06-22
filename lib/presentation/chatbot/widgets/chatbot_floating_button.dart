import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_shell_notifier.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotFloatingButton extends ConsumerWidget {
  const ChatbotFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Positioned(
      right: ChatbotTheme.horizontalInset,
      bottom: bottomInset + ChatbotTheme.bottomNavClearance,
      child: Material(
        elevation: 8,
        shadowColor: Colors.black26,
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => ref.read(chatbotShellProvider.notifier).showIntro(),
          customBorder: const CircleBorder(),
          child: ChatbotIcon(size: ChatbotTheme.floatingSize),
        ),
      ),
    );
  }
}
