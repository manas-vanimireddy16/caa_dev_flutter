import 'package:code_setup/presentation/chatbot/models/chatbot_ask_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_answer_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
import 'package:code_setup/repository/chatbot/data/data.dart';

abstract class ChatbotRepository {
  factory ChatbotRepository() => ChatbotRepositoryImpl();

  Future<ChatbotAskResponse> ask({
    required String query,
    required int userId,
    required List<String> roles,
  });

  Future<ChatbotQuestionResponse> getQuestions({
    required String subServiceCode,
    required int userId,
    required String role,
  });

  Future<ChatbotAnswerResponse> getAnswer({
    required String questionId,
    required int userId,
    required String role,
  });

  Future<ChatbotAnswerResponse> askFaq({
    required String query,
    required String serviceCode,
    required int userId,
    required String role,
  });
}
