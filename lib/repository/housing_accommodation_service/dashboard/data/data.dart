import 'dart:developer';
import 'dart:io';

import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/presentation/screens/security_access/models/request_model.dart';
import 'package:code_setup/repository/housing_accommodation_service/dashboard/domain/domain.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class HotelReservationDashboardRepoistoryImple
    implements HotelReservationDashboardRepoistory {
  @override
  Future<KPIResponse?> getKpiData() async {
    String url = ApiEndPoint.hotelReservationKpiCard;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          return KPIResponse.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught dio error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching KPI data $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<StatusBreakdownModel> getStatusBreakdownData(String period) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {'time_period': period};
        queryParams.removeWhere((key, value) => value == null);
        final response = await client.get(
          ApiEndPoint.hotelReservationStatusBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return StatusBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException('Client is null');
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
  Future<TrendBreakdownModel> getTrendBreakdownData(String period) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {"year": period};

        /// Remove null values
        queryParams.removeWhere((key, value) => value == null);

        final response = await client.get(
          ApiEndPoint.hotelReservationTrendBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return TrendBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException('Client is null');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<KPIResponse?> getApprovalKpiData() async {
    String url = ApiEndPoint.securityAccessKpi;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          return KPIResponse.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught dio error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching KPI data $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<HotelReservationRequestModel>> getRequests({
    required int offset,
    required int limit,
    String sortBy = 'created_at',
    String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'offset': offset.toString(),
          'limit': '20',
          'sort_by': sortBy,
          'sort_order': sortOrder,
        };
        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }
        final url = ApiEndPoint.hotelReservationRequests;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map(
                (e) => HotelReservationRequestModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList();
        } else {
          throw Exception('Failed to fetch services: ${response.statusCode}');
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching services: $e");
    }
  }

  @override
  Future<List<HotelReservationRequestModel>> getActionItems({
    required int offset,
    required int limit,
    String status = '',
    String searchText = '',
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {
          'offset': offset.toString(),
          'limit': limit.toString(),
          'order_by': 'created_at',
          'sort_order': 'DESC',
        };

        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        final response = await client.get(
          ApiEndPoint.hotelReservationApprovalActionItems,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          final List<dynamic> list = data['data'] ?? [];

          /// Parse each Action Item
          final actionItems = list
              .map(
                (item) => HotelReservationRequestModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList();

          return actionItems;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      /// If client is null
      return [];
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<RequestDetailData?> getRequestsById(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = '${ApiEndPoint.hotelReservationRequestById(id)}';
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = RequestDetailModel.fromJson(json);

          /// Return only `data` (so UI can access sub-objects)
          return result.data;
        } else {
          throw Exception('Failed: ${response.statusCode}');
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching request details: $e");
    }
  }

  @override
  Future<String> sendChat(
    Map<String, dynamic> payload,
    int id,
    String type,
  ) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.salalahChatsById(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Request sent successfully');

          return response.data["message"] ?? "Success";
        } else {
          debugPrint('⚠️ Failed to send request: ${response.statusCode}');
          return response.data["message"] ?? "Something went wrong";
        }
      } else {
        debugPrint('❌ Client is null — cannot send request');
        return "Something went wrong";
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
  Future<void> onClose(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.securityAccessApproval;

    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ShowFlutterToast().showFlutterToastSuccess(
            '${response.data['message']}',
          );
          debugPrint('✅ Request sent successfully');
        } else {
          debugPrint('⚠️ Failed to send request: ${response.statusCode}');
          ShowFlutterToast().showFlutterToastFailure(
            '${response.statusMessage}',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot send request');
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
  Future<List<DepartmentModel>> getDepartments() async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.departments;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          return (data['data'] as List)
              .map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Failed with status code: ${response.statusCode}');
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error in getActionItems: $e');
    }
  }
}
