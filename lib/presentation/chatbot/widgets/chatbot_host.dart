import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_shell_notifier.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_floating_button.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_intro_panel.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Global overlay host for the AI chatbot (floating / intro / chat).
class ChatbotHost extends ConsumerWidget {
  const ChatbotHost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shell = ref.watch(chatbotShellProvider);
    final shellNotifier = ref.read(chatbotShellProvider.notifier);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (shell.showsIntro) ...[
          Positioned.fill(
            child: GestureDetector(
              onTap: shellNotifier.minimize,
              child: const ColoredBox(color: ChatbotTheme.backdrop),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: const ChatbotIntroPanel(),
            ),
          ),
        ],
        if (shell.showsChat)
          ChatbotWindow(isExpanded: shell.isExpanded),
        if (shell.showsFloatingButton)
          const ChatbotFloatingButton(),
      ],
    );
  }
}
