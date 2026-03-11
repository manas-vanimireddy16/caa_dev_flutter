import 'dart:developer';
import 'dart:io';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/master_roles.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/chat_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/security_self/models/security_awareness_request_data.dart';
import 'package:code_setup/presentation/screens/security_self/models/security_threat_request_data.dart'
    hide ChatMessageModel;
import 'package:code_setup/presentation/screens/security_self/models/security_threat_reassign.dart';
import 'package:code_setup/repository/aviation_security_facilitation/airport_entry/domain/domain.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/security_self/request_to_organize_security_awareness/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';

class AssignmentDecisionRepoistoryImple
    implements AssignmentDecisionRepoistory {
  @override
  Future<List<Position>> getPositions() async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.assignmentDecisionPositions;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map((e) => Position.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception(
            'Failed to fetch postions assignment decision: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching postions assignment decision: $e");
    }
  }

  @override
  Future<List<Employee>> getUsers() async {
    final client = await KAppX.network.secureClient();
    if (client == null) {
      throw Exception("HTTP client not initialized");
    }

    try {
      final response = await client.get(ApiEndPoint.assignmentDecisionUsers);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List list = data['data'] as List? ?? [];

        return list
            .map((e) => Employee.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw Exception(
        'Failed to fetch positions assignment decision: ${response.statusCode}',
      );
    } catch (e, st) {
      debugPrint('getUsers error: $e');
      debugPrintStack(stackTrace: st);
      throw Exception("Error fetching positions assignment decision");
    }
  }

  @override
  Future<void> sendAssignmentDecisionRequest(
    Map<String, dynamic> payload,
  ) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.assignmentDecisionNewRequest;
    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ New SecurityAwareness request sent successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Request sent successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ??
                'Failed to send SecurityAwareness request',
          );
          debugPrint(
            '⚠️ Failed to send SecurityAwareness request: ${response.statusCode}',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot send SecurityAwareness request');
      }
    } on DioException catch (e) {
      log('caught error');
      final message = e.response?.data['message'] ?? e.message;
      throw ApiException(message);
      throw e;
    } catch (e) {
      log('error SecurityAwareness request $e');
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
  Future<KPIResponse?> getKpiData(int service_id, int sub_service_id) async {
    String url = ApiEndPoint.assignmentDecisionKpiData;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'service_id': service_id,
          'sub_service_id': sub_service_id,
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
  Future<KPIResponse?> getCombinedKpiData() async {
    String url = ApiEndPoint.airportEntryKpi;
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
  Future<KPIResponse?> getCombinedApprovalKpiData() async {
    String url = ApiEndPoint.airportEntryApprovalKpi;
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
  Future<KPIResponse?> getApprovalKpiData() async {
    String url = ApiEndPoint.assignmentDecisionApprovalKpiData;
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
  Future<StatusBreakdownModel> getApprovalStatusBreakdownData(
    String period,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {'time_period': period};
        queryParams.removeWhere((key, value) => value == null);
        final response = await client.get(
          ApiEndPoint.airportEntryApprovalStatusBreakdown,
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
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData(
    String period,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {"year": period};

        /// Remove null values
        queryParams.removeWhere((key, value) => value == null);

        final response = await client.get(
          ApiEndPoint.airportEntryApprovalTrendBreakdown,
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
  Future<List<AssignmentDecision>> getRequests({
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
        final Map<String, dynamic> queryParams = {
          'offset': offset,
          'limit': limit,
        };

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }
        final url = ApiEndPoint.assignmentDecisionRequests;
        final response = await client.get(url, queryParameters: queryParams);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map(
                (e) => AssignmentDecision.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        } else {
          throw Exception(
            'Failed to fetch assignment decision request: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching assignment decision request: $e");
    }
  }

  @override
  Future<List<AssignmentDecision>> getActionItems({
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
          ApiEndPoint.assignmentDecisionApprovalRequests,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          final List<dynamic> list = data['data'] ?? [];

          /// Parse each Action Item
          final actionItems = list
              .map(
                (item) =>
                    AssignmentDecision.fromJson(item as Map<String, dynamic>),
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
  Future<List<OrganizeSecurityAwarenessRequestData>> getCombinedRequests({
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
        final quaryParams = {'offset': offset, 'limit': limit};

        final url = ApiEndPoint.airportEntryRequests;
        final response = await client.get(url, queryParameters: quaryParams);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map(
                (e) => OrganizeSecurityAwarenessRequestData.fromJson(
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
  Future<List<ThreatRequestDetail>> getCombinedActionItems({
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
          ApiEndPoint.airportEntryActionItems,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          final List<dynamic> list = data['data'] ?? [];

          /// Parse each Action Item
          final actionItems = list
              .map(
                (item) =>
                    ThreatRequestDetail.fromJson(item as Map<String, dynamic>),
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
        final url = ApiEndPoint.assignmentDecisionRequestById(id);
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
  Future<String> sendChat(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.airportEntrySendChatById(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
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
    final String url = ApiEndPoint.assignmentDecisionApproval;

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
  Future<void> onReject(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.assignmentDecisionReject;

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
  Future<void> onEventChange(
    int requestId,
    Map<String, dynamic> payload,
  ) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.eventDateChange(requestId);

    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // ShowFlutterToast().showFlutterToastSuccess(
          //   '${response.data['message']}',
          // );
          debugPrint('✅ Request sent successfully');
        } else {
          debugPrint('⚠️ Failed to send request: ${response.statusCode}');
          // ShowFlutterToast().showFlutterToastFailure(
          //   '${response.statusMessage}',
          // );
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
  Future<List<PendingApprovalUser>> getEngineersList(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.reportSecurityThreatEngineers(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map(
                (e) => PendingApprovalUser.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        } else {
          throw Exception('Failed to engineers ${response.statusCode}');
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching engineers: $e");
    }
  }

  @override
  Future<List<MasterRolesModel>> getRolesList() async {
    final client = await KAppX.network.secureClient();
    final userInfo = KAppX.globalProvider.read(rolesProvider);

    try {
      if (client != null) {
        final url = ApiEndPoint.masterRoles;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map((e) => MasterRolesModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Failed to roles list ${response.statusCode}');
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching roles list: $e");
    }
  }

  @override
  Future<void> onAssignEngineer(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.organizeSecurityAwarenessAssign;
    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Assigned engineer successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Assigned engineer successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ?? 'Failed to Assign engineer',
          );
          debugPrint(
            '⚠️ Failed to send vehicle request: ${response.statusCode}',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot Fail to Assign engineer');
      }
    } on DioException catch (e) {
      log('caught error');
      final message = e.response?.data['message'] ?? e.message;
      throw ApiException(message);
      throw e;
    } catch (e) {
      log('error failed to Assigned Engineer $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<ChatMessageModel>> getchatById(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.airportEntryChatById(id);
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
  Future<List<EmployeeSummary>> getEmployeeList({
    required int departmentId,
    required int sectionId,
    required String roleId,
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParameter = {
          'role_id': roleId,
          'section_id': sectionId,
          'department_id': departmentId,
        };
        final url = ApiEndPoint.assignmentDecisionEmployeesList;
        final response = await client.get(url, queryParameters: queryParameter);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = EmployeesResponse.fromJson(json);

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
  Future<void> onAssignEmployee(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.assignmentDecisionEmployeeAssignEmployee;
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

  @override
  Future<void> onReplaceEmployee(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.assignmentDecisionReplaceEmployee;
    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Replaced Employee successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Replaced Employee successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ?? 'Failed to Replaced Employee',
          );
          debugPrint(
            '⚠️ Failed to send onReplaceEmployee request: ${response.statusCode}',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot Fail to Replaced Employee');
      }
    } on DioException catch (e) {
      log('caught error');
      final message = e.response?.data['message'] ?? e.message;
      throw ApiException(message);
      throw e;
    } catch (e) {
      log('error failed to Replaced Employee $e');
      throw ApiException(e.toString());
    }
  }
}
