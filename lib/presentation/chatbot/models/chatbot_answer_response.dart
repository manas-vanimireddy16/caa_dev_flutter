class ChatbotAnswerResponse {
  final String? questionId;
  final String? question;
  final String? answer;
  final String? sourceSection;
  final String? serviceCode;
  final String? serviceName;
  final String? subServiceCode;
  final String? subServiceName;
  final bool? authenticated;
  final String? userId;
  final String? role;

  const ChatbotAnswerResponse({
    this.questionId,
    this.question,
    this.answer,
    this.sourceSection,
    this.serviceCode,
    this.serviceName,
    this.subServiceCode,
    this.subServiceName,
    this.authenticated,
    this.userId,
    this.role,
  });

  factory ChatbotAnswerResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotAnswerResponse(
      questionId: json['question_id']?.toString(),
      question: json['question']?.toString(),
      answer: json['answer']?.toString(),
      sourceSection: json['source_section']?.toString(),
      serviceCode: json['service_code']?.toString(),
      serviceName: json['service_name']?.toString(),
      subServiceCode: json['sub_service_code']?.toString(),
      subServiceName: json['sub_service_name']?.toString(),
      authenticated: json['authenticated'] as bool?,
      userId: json['user_id']?.toString(),
      role: json['role']?.toString(),
    );
  }
}
