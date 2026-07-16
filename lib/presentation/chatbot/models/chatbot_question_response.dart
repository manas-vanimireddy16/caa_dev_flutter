class ChatbotQuestion {
  final String questionId;
  final String question;
  final String? sourceSection;

  const ChatbotQuestion({
    required this.questionId,
    required this.question,
    this.sourceSection,
  });

  factory ChatbotQuestion.fromJson(Map<String, dynamic> json) {
    return ChatbotQuestion(
      questionId: json['question_id']?.toString() ?? '',
      question: json['question']?.toString() ?? '',
      sourceSection: json['source_section']?.toString(),
    );
  }
}

class ChatbotQuestionResponse {
  final String? serviceCode;
  final String? serviceName;
  final String? subServiceCode;
  final String? subServiceName;
  final List<ChatbotQuestion> questions;
  final int questionCount;
  final bool? authenticated;
  final String? userId;
  final String? role;

  const ChatbotQuestionResponse({
    this.serviceCode,
    this.serviceName,
    this.subServiceCode,
    this.subServiceName,
    this.questions = const [],
    this.questionCount = 0,
    this.authenticated,
    this.userId,
    this.role,
  });

  factory ChatbotQuestionResponse.fromJson(Map<String, dynamic> json) {
    final rawQuestions = json['questions'];
    return ChatbotQuestionResponse(
      serviceCode: json['service_code']?.toString(),
      serviceName: json['service_name']?.toString(),
      subServiceCode: json['sub_service_code']?.toString(),
      subServiceName: json['sub_service_name']?.toString(),
      questions: rawQuestions is List
          ? rawQuestions
                .whereType<Map>()
                .map(
                  (item) => ChatbotQuestion.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
                .where(
                  (item) =>
                      item.questionId.trim().isNotEmpty &&
                      item.question.trim().isNotEmpty,
                )
                .toList()
          : const [],
      questionCount: _toInt(json['question_count']),
      authenticated: json['authenticated'] as bool?,
      userId: json['user_id']?.toString(),
      role: json['role']?.toString(),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
