import 'dart:developer';

import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/foreign_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_foreign_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
import 'package:code_setup/repository/logistics/domain/logistics_foreign.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LogisticsForeignRepositoryImplementation
    implements LogisticsForeignRepository {
  static const String _serviceLabel = 'Logistics Foreign Employee';
  final toast = ShowFlutterToast();

  @override
  Future<void> sendForeignRequest(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.postLogisticsForeignRequests;
    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Vehicle request sent successfully');
          toast.showFlutterToastSuccess(
            response.data['message'] ?? 'Request sent successfully',
          );
        } else {
          toast.showFlutterToastFailure(
            response.data['message'] ?? 'Failed to send request',
          );
          debugPrint(
            '⚠️ Failed to send vehicle request: ${response.statusCode}',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot send vehicle request');
      }
    } on DioException catch (e) {
      debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');
      throw e;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw e;
    }
  }

  @override
  Future<List<ForeignData>> getForeignRequestData() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.dashboardForeignRequest);
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final requestData = data['data']
              .map<ForeignData>(
                (item) => ForeignData.fromJson(item as Map<String, dynamic>),
              )
              .toList();
          return requestData;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Failed to process $_serviceLabel request';
          throw ApiException(errorMessage);
        }
      }
      return [];
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching activity feeds $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<StatusBreakdownModel> getStatusBreakdown(String period) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.statusBreakdownForeignLogistics(period),
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return StatusBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Failed to process $_serviceLabel request';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException('Client is null - cannot process $_serviceLabel request');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<LogisticsTrendBreakdownModel> getForeignTrendBreakdown(
    String period,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.trendBreakdownForeignLogistics(period),
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return LogisticsTrendBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Failed to process $_serviceLabel request';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException('Client is null - cannot process $_serviceLabel request');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<LogisticsForeignDetailModel?> getRequestDetailsById(int id) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.logisticsForeignRequestDetailsById(id),
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return LogisticsForeignDetailModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Failed to process $_serviceLabel request';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException('Client is null - cannot process $_serviceLabel request');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<String> sendChat(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.postLogisticsChat(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Request sent successfully');

          return response.data["message"] ?? "Success";
        } else {
          debugPrint('⚠️ Failed to send request: ${response.statusCode}');
          return response.data["message"] ?? "Failed to process $_serviceLabel request";
        }
      } else {
        debugPrint('❌ Client is null — cannot send request');
        return "Client is null - cannot process $_serviceLabel request";
      }
    } on DioException catch (e) {
      debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');
      throw e;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw e;
    }
  }
}
