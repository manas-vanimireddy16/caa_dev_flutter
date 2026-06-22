class ChatbotAskResponse {
  final String? expectedQaId;
  final String? intent;
  final String? matchedQuestion;
  final String? answer;
  final double? score;
  final double? vectorScore;
  final double? bm25Score;
  final String? language;
  final String? sourceFile;
  final bool? authenticated;
  final String? userId;
  final String? role;

  ChatbotAskResponse({
    this.expectedQaId,
    this.intent,
    this.matchedQuestion,
    this.answer,
    this.score,
    this.vectorScore,
    this.bm25Score,
    this.language,
    this.sourceFile,
    this.authenticated,
    this.userId,
    this.role,
  });

  factory ChatbotAskResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotAskResponse(
      expectedQaId: json['expected_qa_id']?.toString(),
      intent: json['intent']?.toString(),
      matchedQuestion: json['matched_question']?.toString(),
      answer: json['answer']?.toString(),
      score: _toDouble(json['score']),
      vectorScore: _toDouble(json['vector_score']),
      bm25Score: _toDouble(json['bm25_score']),
      language: json['language']?.toString(),
      sourceFile: json['source_file']?.toString(),
      authenticated: json['authenticated'] as bool?,
      userId: json['user_id']?.toString(),
      role: json['role']?.toString(),
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
