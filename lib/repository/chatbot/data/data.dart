import 'dart:convert';
import 'dart:developer';

import 'package:code_setup/presentation/chatbot/models/chatbot_ask_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_answer_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
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

  @override
  Future<ChatbotQuestionResponse> getQuestions({
    required String subServiceCode,
    required int userId,
    required String role,
  }) async {
    try {
      final data = await _getJson(
        ApiEndPoint.chatbotQuestions,
        queryParameters: {
          'sub_service_code': subServiceCode,
          'user_id': userId,
          'role': role,
        },
      );
      return ChatbotQuestionResponse.fromJson(data);
    } catch (e, stack) {
      log('Chatbot questions error: $e', stackTrace: stack);
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  @override
  Future<ChatbotAnswerResponse> getAnswer({
    required String questionId,
    required int userId,
    required String role,
  }) async {
    try {
      final data = await _getJson(
        ApiEndPoint.chatbotAnswer,
        queryParameters: {
          'question_id': questionId,
          'user_id': userId,
          'role': role,
        },
      );
      return ChatbotAnswerResponse.fromJson(data);
    } catch (e, stack) {
      log('Chatbot answer error: $e', stackTrace: stack);
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  @override
  Future<ChatbotAnswerResponse> askFaq({
    required String query,
    required String serviceCode,
    required int userId,
    required String role,
  }) async {
    try {
      final data = await _getJson(
        ApiEndPoint.chatbotAskFaq,
        queryParameters: {
          'query': query,
          'services': serviceCode,
          'user_id': userId,
          'role': role,
        },
      );
      return ChatbotAnswerResponse.fromJson(data);
    } catch (e, stack) {
      log('Chatbot ask FAQ error: $e', stackTrace: stack);
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> _getJson(
    String url, {
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client == null) {
        throw ApiException('Failed to initialize network client');
      }

      final response = await client.get(
        url,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 && response.data is Map) {
        return Map<String, dynamic>.from(response.data as Map);
      }

      final errorMessage =
          response.data?['message'] ??
          response.data?['detail'] ??
          'Unexpected error occurred';
      throw ApiException(errorMessage.toString());
    } on DioException catch (error) {
      final data = error.response?.data;
      final message = data is Map
          ? (data['message'] ?? data['detail'] ?? error.message)
          : error.message;
      throw ApiException(message?.toString() ?? 'Network error occurred');
    }
  }
}
