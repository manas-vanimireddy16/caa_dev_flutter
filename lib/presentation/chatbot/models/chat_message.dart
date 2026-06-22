import 'package:equatable/equatable.dart';

enum ChatMessageRole { user, assistant }

class ChatMessage extends Equatable {
  final String id;
  final ChatMessageRole role;
  final String text;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
  });

  bool get isUser => role == ChatMessageRole.user;
  bool get isAssistant => role == ChatMessageRole.assistant;

  @override
  List<Object?> get props => [id, role, text, createdAt];
}
