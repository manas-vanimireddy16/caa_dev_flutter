import 'package:code_setup/presentation/chatbot/state/chatbot_shell_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatbotShellProvider =
    NotifierProvider<ChatbotShellNotifier, ChatbotShellState>(
  ChatbotShellNotifier.new,
);

/// Controls which chatbot surface is visible (floating / intro / chat).
class ChatbotShellNotifier extends Notifier<ChatbotShellState> {
  @override
  ChatbotShellState build() => const ChatbotShellState.initial();

  void openChat() {
    state = state.copyWith(
      visibility: ChatbotShellVisibility.chat,
      isExpanded: false,
    );
  }

  void showIntro() {
    state = state.copyWith(
      visibility: ChatbotShellVisibility.intro,
      isExpanded: false,
    );
  }

  void minimize() {
    state = state.copyWith(
      visibility: ChatbotShellVisibility.hidden,
      isExpanded: false,
    );
  }

  void toggleExpanded() {
    if (!state.showsChat) return;
    state = state.copyWith(isExpanded: !state.isExpanded);
  }
}
