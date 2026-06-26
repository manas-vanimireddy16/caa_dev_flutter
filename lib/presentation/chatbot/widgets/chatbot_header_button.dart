import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:flutter/material.dart';

/// Header launcher for the AI assistant (home / services / links only).
class ChatbotHeaderButton extends StatelessWidget {
  const ChatbotHeaderButton({super.key});

  static const double _size = 36;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.router.push(const ChatbotRoute()),
          customBorder: const CircleBorder(),
          child: const ChatbotIcon(size: _size),
        ),
      ),
    );
  }
}
