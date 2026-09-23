import 'package:equatable/equatable.dart';

enum ChatMessageRole { user, assistant }

enum ChatbotFeedbackChoice { helpful, notHelpful }

class ChatMessage extends Equatable {
  final String id;
  final ChatMessageRole role;
  final String text;
  final DateTime createdAt;

  /// Optional bilingual payload so UI can follow the selected app language.
  final String? textEn;
  final String? textAr;

  /// True for AI answers that should show feedback + navigation actions.
  final bool isAnswer;

  /// True for error assistant messages that should show recovery navigation.
  final bool isError;

  /// Feedback submitted for this specific answer, if any.
  final ChatbotFeedbackChoice? feedback;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
    this.textEn,
    this.textAr,
    this.isAnswer = false,
    this.isError = false,
    this.feedback,
  });

  bool get isUser => role == ChatMessageRole.user;
  bool get isAssistant => role == ChatMessageRole.assistant;
  bool get hasFeedback => feedback != null;

  String displayText({required bool isArabic}) {
    final primary = isArabic ? textAr : textEn;
    final fallback = isArabic ? textEn : textAr;
    final primaryTrimmed = primary?.trim();
    if (primaryTrimmed != null && primaryTrimmed.isNotEmpty) {
      return primaryTrimmed;
    }
    final fallbackTrimmed = fallback?.trim();
    if (fallbackTrimmed != null && fallbackTrimmed.isNotEmpty) {
      return fallbackTrimmed;
    }
    return text;
  }

  ChatMessage copyWith({
    String? id,
    ChatMessageRole? role,
    String? text,
    DateTime? createdAt,
    String? textEn,
    String? textAr,
    bool? isAnswer,
    bool? isError,
    ChatbotFeedbackChoice? feedback,
    bool clearFeedback = false,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      textEn: textEn ?? this.textEn,
      textAr: textAr ?? this.textAr,
      isAnswer: isAnswer ?? this.isAnswer,
      isError: isError ?? this.isError,
      feedback: clearFeedback ? null : feedback ?? this.feedback,
    );
  }

  @override
  List<Object?> get props =>
      [id, role, text, createdAt, textEn, textAr, isAnswer, isError, feedback];
}
