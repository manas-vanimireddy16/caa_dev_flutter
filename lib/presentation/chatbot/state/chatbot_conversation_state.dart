import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:equatable/equatable.dart';

class ChatbotConversationState extends Equatable {
  final List<ChatMessage> messages;
  final bool isSending;

  const ChatbotConversationState({
    this.messages = const [],
    this.isSending = false,
  });

  ChatbotConversationState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
  }) {
    return ChatbotConversationState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object?> get props => [messages, isSending];
}
