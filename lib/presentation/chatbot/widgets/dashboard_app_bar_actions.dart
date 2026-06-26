import 'package:code_setup/presentation/chatbot/widgets/chatbot_header_button.dart';
import 'package:flutter/material.dart';

/// Notification bell and AI assistant actions for main tab headers.
class DashboardAppBarActions extends StatelessWidget {
  const DashboardAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NotificationBellButton(),
        ChatbotHeaderButton(),
        SizedBox(width: 8),
      ],
    );
  }
}

class _NotificationBellButton extends StatelessWidget {
  const _NotificationBellButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Notifications',
      icon: const Icon(Icons.notifications_none, color: Colors.black, size: 26),
      onPressed: () {},
    );
  }
}
