// repository/dashboard_repository.dart
import 'dart:developer';
import 'dart:io';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/models.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/action_item_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/chat.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/it_technician.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/kpi.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestData.dart'
    hide Department;
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/service_dropdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/status_break_down.dart';
import 'package:code_setup/repository/mascat/domain/domain.dart';
import 'package:code_setup/repository/salalah/domain/dashboard.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MuscatDashboardRepositoryImpl implements MuscatDashboardRepository {
  // final token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEwMTgsImlzX2FkbWluIjpmYWxzZSwiZW1wbG95ZWVfaWQiOiIxNDA0MiIsImVtcGxveWVlX25hbWUiOiJNYW5hcyIsImVtcGxveWVlX2FyYWJpY19uYW1lIjoi2YXZhtmK2LEg2KjZhiDYtdiv2YrZgiDYqNmGINi52YTZiiDYp9mE2KjZhNmI2LTZiiIsInBlcnNvbl90eXBlIjoiQ0FBIiwic2VjdGlvbiI6NjYsInNlY3Rpb25fbmFtZSI6IklUIFN1cHBvcnQiLCJwb3NpdGlvbiI6MjI1LCJwb3NpdGlvbl9uYW1lIjoiQ29tcHV0ZXIgTmV0d29yayBFbmdpbmVlciIsImRlcGFydG1lbnQiOjI1LCJkZXBhcnRtZW50X25hbWUiOiJJbmZvcm1hdGlvbiBUZWNobm9sb2d5IiwiZW1haWwiOiJtYW5hcy52YW5pbWlyZWRkeUBhbW5ldGRpZ2l0YWwuY29tIiwiaWF0IjoxNzU5OTk3Njc5LCJleHAiOjE3NjM1OTc2Nzl9.aMuGbNRTDag8C8IsmPHzgax96e7LQs1w6Ft6z8vm-vs';

  //Uploads files and returns metadata including file_url
  @override
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  ) async {
    List<Map<String, dynamic>> uploadedFiles = [];

    for (var file in attachments) {
      final filePath = file['path'];
      if (filePath == null) continue;

      final fileName = file['file_name'] ?? filePath.split('/').last;
      final fileType = file['file_type'] ?? fileName.split('.').last;
      final fileDescription = 'description';
      final fileSize = File(filePath).lengthSync(); // Read size from device

      uploadedFiles.add({
        "file_url": filePath, // Add local file path as file_url
        "file_name": fileName,
        "file_type": fileType,
        "file_size": fileSize,
        "description": fileDescription,
      });
    }

    return uploadedFiles;
  }

  /// Sends payload including uploaded attachments
  @override
  Future<void> sendRequest(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.sendSalalahRequest;

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

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
  Future<void> selfAssign(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.assignToMe;

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

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
  Future<void> onClose(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.onClose;

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
  Future<TrendBreakdownModel> getTrendBreakdownData(String period) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.muscatTrendBreakdown(period),
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
  Future<StatusBreakdownModel> getApprovalStatusBreakdownData({
    required String period,
    required int serviceId,
    required int subServiceId,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {
          'time_period': period,
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };
        queryParams.removeWhere((key, value) => value == null);
        final response = await client.get(
          ApiEndPoint.promotionApprovalStatusBreakdown,
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
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData({
    required String period,
    required int serviceId,
    required int subServiceId,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {
          "year": period,
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };

        /// Remove null values
        queryParams.removeWhere((key, value) => value == null);

        final response = await client.get(
          ApiEndPoint.promotionApprovalTrendBreakdown,
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

  @override
  Future<List<SectionModel>> getSections(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.muscatSection(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          return (data['data'] as List)
              .map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
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

  @override
  Future<List<ServiceData>> getServices() async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.muscatServicesDropdown;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map((e) => ServiceData.fromJson(e as Map<String, dynamic>))
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
  Future<ITTechnicianListModel> getItTechnicianDetails() async {
    final client = await KAppX.network.secureClient();
    final userInfo = KAppX.globalProvider.read(userProvider);

    try {
      if (client != null) {
        final url = ApiEndPoint.muscatITTechnician;

        /// Build query parameters dynamically
        final queryParams = {
          "department_id": userInfo?.department?.toString(),
          "section_id": userInfo?.section?.toString(),
        };

        /// Remove null values
        queryParams.removeWhere((key, value) => value == null);

        final response = await client.get(url, queryParameters: queryParams);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          return ITTechnicianListModel.fromJson(data);
        } else {
          throw ApiException(
            'Failed to fetch IT technician details: ${response.statusCode}',
          );
        }
      } else {
        throw ApiException("No network client available");
      }
    }
    /// ---------------------- DIO ERROR ----------------------
    on DioException catch (error) {
      log('caught dio error in getItTechnicianDetails');

      final message =
          error.response?.data?['message'] ??
          error.message ??
          "Unknown network error";

      throw ApiException(message);
    }
    /// ---------------------- OTHER ERRORS ----------------------
    catch (e) {
      log('error getItTechnicianDetails → $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<RequestsData>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.muscatRequests;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map((e) => RequestsData.fromJson(e as Map<String, dynamic>))
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
  Future<List<SalalahActionItem>> getActionItems({
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
          ApiEndPoint.muscatActionItems,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          final List<dynamic> list = data['data'] ?? [];

          /// Parse each Action Item
          final actionItems = list
              .map(
                (item) =>
                    SalalahActionItem.fromJson(item as Map<String, dynamic>),
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
        final url = ApiEndPoint.muscatRequestById(id);
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
  Future<KPIResponse?> getKpiData() async {
    String url = ApiEndPoint.muscatKpiCard;
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
        final response = await client.get(
          ApiEndPoint.muscatStatusBreakdown(period),
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
}
