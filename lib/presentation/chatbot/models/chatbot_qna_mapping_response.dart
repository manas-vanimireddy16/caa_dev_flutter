import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';

/// Localized string pair from chatbot Q&A mapping (`question` / `answer`).
class ChatbotLocalizedText {
  final String? en;
  final String? ar;

  const ChatbotLocalizedText({this.en, this.ar});

  factory ChatbotLocalizedText.fromJson(dynamic json) {
    if (json is! Map) {
      final value = json?.toString();
      return ChatbotLocalizedText(en: value, ar: value);
    }
    return ChatbotLocalizedText(
      en: json['en']?.toString(),
      ar: json['ar']?.toString(),
    );
  }

  String resolve({required bool isArabic}) {
    final primary = isArabic ? ar : en;
    final fallback = isArabic ? en : ar;
    final primaryTrimmed = primary?.trim();
    if (primaryTrimmed != null && primaryTrimmed.isNotEmpty) {
      return primaryTrimmed;
    }
    final fallbackTrimmed = fallback?.trim();
    if (fallbackTrimmed != null && fallbackTrimmed.isNotEmpty) {
      return fallbackTrimmed;
    }
    return '';
  }
}

/// One Q&A mapping row from `/chatbot-qns-ans-mapping/list`.
class ChatbotQnAMappingItem {
  final int? id;
  final int? serviceId;
  final int? subServiceId;
  final ChatbotLocalizedText question;
  final ChatbotLocalizedText answer;

  const ChatbotQnAMappingItem({
    this.id,
    this.serviceId,
    this.subServiceId,
    this.question = const ChatbotLocalizedText(),
    this.answer = const ChatbotLocalizedText(),
  });

  factory ChatbotQnAMappingItem.fromJson(Map<String, dynamic> json) {
    return ChatbotQnAMappingItem(
      id: _toInt(json['id']),
      serviceId: _toInt(json['service_id']),
      subServiceId: _toInt(json['sub_service_id']),
      question: ChatbotLocalizedText.fromJson(json['question']),
      answer: ChatbotLocalizedText.fromJson(json['answer']),
    );
  }

  /// Converts this mapping into the chatbot chip/answer model.
  ChatbotQuestion toChatbotQuestion() {
    final enQuestion = question.resolve(isArabic: false);
    final arQuestion = question.resolve(isArabic: true);
    final enAnswer = answer.resolve(isArabic: false);
    final arAnswer = answer.resolve(isArabic: true);

    return ChatbotQuestion(
      questionId: id?.toString() ?? '',
      question: enQuestion.isNotEmpty ? enQuestion : arQuestion,
      questionEn: enQuestion,
      questionAr: arQuestion,
      answerEn: enAnswer,
      answerAr: arAnswer,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }
}

class ChatbotQnAMappingResponse {
  final String? status;
  final List<ChatbotQnAMappingItem> data;
  final int total;

  const ChatbotQnAMappingResponse({
    this.status,
    this.data = const [],
    this.total = 0,
  });

  factory ChatbotQnAMappingResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final items = rawData is List
        ? rawData
              .whereType<Map>()
              .map(
                (item) => ChatbotQnAMappingItem.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .where((item) {
                final hasQuestion =
                    item.question.resolve(isArabic: false).isNotEmpty ||
                    item.question.resolve(isArabic: true).isNotEmpty;
                return hasQuestion;
              })
              .toList()
        : const <ChatbotQnAMappingItem>[];

    return ChatbotQnAMappingResponse(
      status: json['status']?.toString(),
      data: items,
      total: _toInt(json['total']) ?? items.length,
    );
  }

  List<ChatbotQuestion> toQuestions() =>
      data.map((item) => item.toChatbotQuestion()).toList(growable: false);

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }
}
