import 'package:auto_route/auto_route.dart';
import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_conversation_view.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      backgroundColor: ChatbotTheme.surface,
      appBar: AppBar(
        title: Text(
          'AI assistant',
          style: AppTextStyles.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: ChatbotTheme.headerBackground,
        foregroundColor: Colors.white,
        surfaceTintColor: ChatbotTheme.headerBackground,
        elevation: 0,
      ),
      body: const ChatbotConversationView(),
    );
  }
}
