import 'package:code_setup/presentation/chatbot/models/chatbot_ask_response.dart';
import 'package:code_setup/repository/chatbot/data/data.dart';

abstract class ChatbotRepository {
  factory ChatbotRepository() => ChatbotRepositoryImpl();

  Future<ChatbotAskResponse> ask({
    required String query,
    required int userId,
    required List<String> roles,
  });
}
