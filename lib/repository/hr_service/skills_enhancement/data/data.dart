import 'dart:developer';
import 'dart:io';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/chat_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/promotions_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/location_model.dart';
import 'package:code_setup/repository/hr_service/annual_increment/domain/domain.dart';
import 'package:code_setup/repository/hr_service/skills_enhancement/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class SkillsEnhancementRepositoryImple implements SkillsEnhancementRepository {
  @override
  Future<List<EmployeeList>> getUsers(int departmentId) async {
    final client = await KAppX.network.secureClient();
    if (client == null) {
      throw Exception("HTTP client not initialized");
    }

    try {
      final response = await client.get(
        ApiEndPoint.assignTaskToEmployeeUsersList(departmentId),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;

        // 🔴 IMPORTANT: data['data'] is [ List<Employee>, totalCount ]
        final List<dynamic> rawData = data['data'] as List<dynamic>? ?? [];

        // rawData[0] contains the actual employee list
        final List<dynamic> employeeList =
            rawData.isNotEmpty && rawData[0] is List
            ? rawData[0] as List<dynamic>
            : [];

        return employeeList
            .map((e) => EmployeeList.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw Exception(
        'Failed to fetch positions request for coverage: ${response.statusCode}',
      );
    } catch (e, st) {
      debugPrint('getUsers error: $e');
      debugPrintStack(stackTrace: st);
      throw Exception("Error fetching positions request for coverage");
    }
  }

  @override
  Future<Map<String, dynamic>> sendSkillsEnhancementRequest(
    Map<String, dynamic> payload,
  ) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.sendRequestForSkillsEnhancement;

    try {
      if (client == null) {
        throw ApiException('Client is null — cannot send Study Leave request');
      }

      final response = await client.post(url, data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ShowFlutterToast().showFlutterToastSuccess(
          response.data['message'] ?? 'Request sent successfully',
        );
        return response.data as Map<String, dynamic>; // ✅ RETURN HERE
      } else {
        ShowFlutterToast().showFlutterToastFailure(
          response.data['message'] ?? 'Failed to send request',
        );
        return response.data as Map<String, dynamic>; // ✅ RETURN HERE
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      throw ApiException(message);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  ) async {
    final client = await KAppX.network.secureClient();
    final List<Map<String, dynamic>> uploadedResults = [];

    if (client == null) {
      debugPrint('❌ Client is null — cannot send request');
      return uploadedResults;
    }

    for (var file in attachments) {
      final filePath = file['path'];
      if (filePath == null) continue;

      final fileName = file['file_name'] ?? filePath.split('/').last;
      final extension = fileName.split('.').last.toLowerCase();

      // ⛔ Check file size (must be < 10 MB)
      final fileSize = await File(filePath).length();
      if (fileSize > 10 * 1024 * 1024) {
        debugPrint('⚠️ $fileName skipped — exceeds 10MB limit');
        uploadedResults.add({
          'file_name': fileName,
          'file_url': null,
          'file_type': extension,
          'file_size': fileSize,
          'status': 'error',
          'message': 'File exceeds 10MB limit',
        });
        continue;
      }

      // 🧠 Detect MIME type dynamically
      String mimeType;
      if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
        mimeType = 'image/$extension';
      } else if (['pdf'].contains(extension)) {
        mimeType = 'application/pdf';
      } else if (['doc', 'docx'].contains(extension)) {
        mimeType = 'application/msword';
      } else if (['xls', 'xlsx'].contains(extension)) {
        mimeType = 'application/vnd.ms-excel';
      } else if (['txt'].contains(extension)) {
        mimeType = 'text/plain';
      } else {
        mimeType = 'application/octet-stream';
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        ),
      });

      try {
        final response = await client.post(
          ApiEndPoint.uploadFiles,
          data: formData,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final files = response.data['data']?['files'];
          if (files != null && files.isNotEmpty) {
            final fileData = files.first;

            // ✅ Extract clean document ID (no /download/)
            // final documentId = fileData['documentId'];

            uploadedResults.add({
              'file_name': fileData['originalName'] ?? fileName,
              'file_url': fileData['downloadUrl'],
              'file_type': extension,
              'file_size': fileData['size'] ?? fileSize,
            });
          }
        } else {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? '',
          );
        }
      } on DioException catch (e) {
        debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');
      } catch (e) {
        debugPrint('❌ Unexpected error: $e');
        throw e;
      }
    }

    return uploadedResults;
  }

  @override
  Future<LocationListResponseModel> getLocations() async {
    final String url = ApiEndPoint.studyLeaveLocations;
    final client = await KAppX.network.secureClient();

    if (client == null) {
      throw ApiException("Unable to create secure client");
    }

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return LocationListResponseModel.fromJson(data);
      } else {
        final errorMessage =
            response.data?['message'] ?? 'Unexpected error occurred';
        throw ApiException(errorMessage);
      }
    } on DioException catch (error) {
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<KPIResponse?> getKpiData(int serviceId, int subServiceId) async {
    String url = ApiEndPoint.skillsEnhancementKpiCards;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };
        final response = await client.get(url, queryParameters: queryParams);

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
  Future<KPIResponse?> getApprovalKpiData({
    required int serviceId,
    required int subServiceId,
  }) async {
    String url = ApiEndPoint.skillsEnhancementApprovalKpiCards;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };
        final response = await client.get(url, queryParameters: queryParams);

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
          ApiEndPoint.skillsEnhancementApprovalStatusBreakdown,
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
          ApiEndPoint.skillsEnhancementApprovalTrendBreakdown,
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
  Future<StatusBreakdownModel> getStatusBreakdownData({
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
          ApiEndPoint.skillsEnhancementStatusBreakdown,
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
  Future<TrendBreakdownModel> getTrendBreakdownData({
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
          ApiEndPoint.skillsEnhancementTrendBreakdown,
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
  Future<List<PromotionsModel>> getRequests({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final Map<String, dynamic> queryParams = {
          'offset': offset,
          'limit': limit,
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }
        final url = ApiEndPoint.skillsEnhancementGetRequests;
        final response = await client.get(url, queryParameters: queryParams);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map((e) => PromotionsModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception(
            'Failed to fetch required new resource request: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching required new resource request: $e");
    }
  }

  @override
  Future<List<PromotionsModel>> getActionItems({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
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
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };

        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        final response = await client.get(
          ApiEndPoint.skillsEnhancementGetActionItems,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          final List<dynamic> list = data['data'] ?? [];

          /// Parse each Action Item
          final actionItems = list
              .map(
                (item) =>
                    PromotionsModel.fromJson(item as Map<String, dynamic>),
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
  Future<String> sendChat(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.skillsEnhancementSendChatById(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Request sent successfully',
          );
          debugPrint('✅ Message sent successfully');

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
  Future<String> sendAttachment(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.skillsEnhancementSendAttachmentById(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Request sent successfully',
          );
          debugPrint('✅ Message sent successfully');

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
  Future<void> onApprove(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.skillsEnhancementApprove;

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
  Future<List<ChatMessageModel>> getchatById(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.skillsEnhancementChatsById(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = ChatByIdResponseModel.fromJson(json);

          /// Return only `data` (so UI can access sub-objects)
          return result.data;
        } else {
          throw Exception('Failed: ${response.statusCode}');
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching chatById details: $e");
    }
  }

  @override
  Future<List<AttachmentModel>> getAttachmentsById(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.skillsEnhancementAttachmentById(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = AttachmentByIdResponseModel.fromJson(json);

          /// Return only `data` (so UI can access sub-objects)
          return result.data;
        } else {
          throw Exception('Failed: ${response.statusCode}');
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching attachmentById details: $e");
    }
  }

  @override
  Future<RequestDetailData?> getRequestsById({
    required int id,
    required int serviceId,
    required int subServiceId,
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'service_id': serviceId,
          'sub_service_id': subServiceId,
        };
        final url = ApiEndPoint.skillsEnhancementRequestById(id);
        final response = await client.get(url, queryParameters: queryParams);

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
  Future<void> onAssignEmployee(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.skillsEnhancementAssign;
    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Assigned Employee successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Assigned Employee successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ?? 'Failed to Assign Employee',
          );
          debugPrint(
            '⚠️ Failed to send onAssignEmployee request: ${response.statusCode}',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot Fail to Assign Employee');
      }
    } on DioException catch (e) {
      log('caught error');
      final message = e.response?.data['message'] ?? e.message;
      throw ApiException(message);
      throw e;
    } catch (e) {
      log('error failed to Assigned Employee $e');
      throw ApiException(e.toString());
    }
  }
}
