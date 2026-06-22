import 'dart:convert';
import 'dart:developer';

import 'package:code_setup/presentation/chatbot/models/chatbot_ask_response.dart';
import 'package:code_setup/repository/chatbot/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
  @override
  Future<ChatbotAskResponse> ask({
    required String query,
    required int userId,
    required List<String> roles,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client == null) {
        throw ApiException('Failed to initialize network client');
      }

      final response = await client.get(
        ApiEndPoint.chatbotAsk,
        queryParameters: {
          'query': query,
          'user_id': userId,
          'role': jsonEncode(roles),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = Map<String, dynamic>.from(response.data as Map);
        return ChatbotAskResponse.fromJson(data);
      }

      final errorMessage =
          response.data?['message'] ?? 'Unexpected error occurred';
      throw ApiException(errorMessage.toString());
    } on DioException catch (error) {
      log('Chatbot ask error: ${error.message}');
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Network error occurred');
    } catch (e, stack) {
      if (e is ApiException) rethrow;
      log('Chatbot ask error: $e', stackTrace: stack);
      throw ApiException(e.toString());
    }
  }
}
