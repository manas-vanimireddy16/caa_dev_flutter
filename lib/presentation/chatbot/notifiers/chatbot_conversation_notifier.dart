import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:code_setup/presentation/chatbot/state/chatbot_conversation_state.dart';
import 'package:code_setup/repository/chatbot/domain/domain.dart';
import 'package:code_setup/repository/common_dashboard_all_services/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatbotConversationProvider =
    NotifierProvider<ChatbotConversationNotifier, ChatbotConversationState>(
  ChatbotConversationNotifier.new,
);

/// Handles chat messages and outbound requests to the chatbot service.
class ChatbotConversationNotifier extends Notifier<ChatbotConversationState> {
  final ChatbotRepository _chatbotRepository = ChatbotRepository();
  final CommonDashboardRepository _dashboardRepository =
      CommonDashboardRepository();

  int _messageCounter = 0;
  List<String>? _cachedRoleNames;

  @override
  ChatbotConversationState build() => const ChatbotConversationState();

  Future<void> sendMessage(String rawText) async {
    final text = rawText.trim();
    if (text.isEmpty || state.isSending) return;

    final userMessage = _createMessage(role: ChatMessageRole.user, text: text);
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isSending: true,
    );

    try {
      final userId = _resolveUserId();
      if (userId == null) {
        throw ApiException('Unable to identify your user account.');
      }

      final roles = await _resolveRoleNames(userId);
      final response = await _chatbotRepository.ask(
        query: text,
        userId: userId,
        roles: roles,
      );

      final answer = response.answer?.trim();
      final reply = (answer != null && answer.isNotEmpty)
          ? answer
          : 'Sorry, I could not find an answer to that question.';

      state = state.copyWith(
        messages: [
          ...state.messages,
          _createMessage(role: ChatMessageRole.assistant, text: reply),
        ],
        isSending: false,
      );
    } on ApiException catch (error) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          _createMessage(
            role: ChatMessageRole.assistant,
            text: error.message,
          ),
        ],
        isSending: false,
      );
    } catch (_) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          _createMessage(
            role: ChatMessageRole.assistant,
            text: 'Something went wrong. Please try again.',
          ),
        ],
        isSending: false,
      );
    }
  }

  int? _resolveUserId() {
    final userInfoId = ref.read(userInfoProvider)?.data?.id;
    if (userInfoId != null && userInfoId.isNotEmpty) {
      return int.tryParse(userInfoId);
    }
    return ref.read(userProvider)?.userId;
  }

  Future<List<String>> _resolveRoleNames(int userId) async {
    if (_cachedRoleNames != null && _cachedRoleNames!.isNotEmpty) {
      return _cachedRoleNames!;
    }

    try {
      final response = await _dashboardRepository.getUserRoles(userId);
      final names = response.data?.rolesSummary
              ?.map((role) => role.roleName)
              .whereType<String>()
              .where((name) => name.isNotEmpty)
              .toSet()
              .toList() ??
          [];

      if (names.isNotEmpty) {
        _cachedRoleNames = names;
        return names;
      }
    } catch (_) {}

    final selectedRole = ref.read(rolesProvider)?.roleName;
    if (selectedRole != null && selectedRole.isNotEmpty) {
      return [selectedRole];
    }

    return [];
  }

  ChatMessage _createMessage({
    required ChatMessageRole role,
    required String text,
  }) {
    _messageCounter += 1;
    return ChatMessage(
      id: 'msg_$_messageCounter',
      role: role,
      text: text,
      createdAt: DateTime.now(),
    );
  }
}
