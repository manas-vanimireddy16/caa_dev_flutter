import 'dart:developer';
import 'dart:io';

import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/technician.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request_by_id.dart';
import 'package:code_setup/repository/it_services/vpn/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class VPNRepoistoryImple implements VPNRepository {
  @override
  Future<List<VpnRequestData>> getVpnRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {
          'offset': offset.toString(),
          'limit': '20',
          // 'sort_by': sortBy,
          // 'sort_order': sortOrder,
        };

        // ✅ Convert list to comma-separated string only if not empty
        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }
        final response = await client.get(
          ApiEndPoint.vpnRequests,
          // queryParameters: queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final requestData = data['data']
              .map<VpnRequestData>(
                (item) => VpnRequestData.fromJson(item as Map<String, dynamic>),
              )
              .toList();
          return requestData;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return [];
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error getAllRequestData $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<VpnRequestData>> getVpnActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {
          'offset': offset.toString(),
          'limit': "20",
          // 'sort_by': sortBy,
          // 'sort_order': sortOrder,
        };

        // ✅ Convert list to comma-separated string only if not empty
        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }
        final response = await client.get(
          ApiEndPoint.vpnActionItems,
          queryParameters: queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final requestData = data['data']
              .map<VpnRequestData>(
                (item) => VpnRequestData.fromJson(item as Map<String, dynamic>),
              )
              .toList();
          return requestData;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return [];
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error getAllRequestData $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<VpnRequestByIdModel> getVpnRequestById({required int id}) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        // final queryParams = {
        //   'offset': offset.toString(),
        //   'limit': limit.toString(),
        //   'sort_by': sortBy,
        //   'sort_order': sortOrder,
        // };

        // if (status.isNotEmpty) {
        //   queryParams['status'] = status;
        // }

        // if (searchText.isNotEmpty) {
        //   queryParams['search_text'] = searchText;
        // }

        final response = await client.get(
          ApiEndPoint.vpnRequestbyId(id),
          // queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          // ✅ Correctly parse the expected model
          final vpnRequest = VpnRequestByIdModel.fromJson(data);

          return vpnRequest;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      // If client is null, handle gracefully
      throw ApiException('Network client not initialized');
    } on DioException catch (error) {
      log('caught Dio error: $error');
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Unknown network error');
    } catch (e) {
      log('error getVpnRequestById: $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<KPIResponse> getKpiData() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.vpnKpicard);
        if (response.statusCode == 200) {
          final data = Map<String, dynamic>.from(response.data);
          final vpnKpicard = KPIResponse.fromJson(data);
          return vpnKpicard;
        } else {
          final errorMessage =
              response.data['message'] ?? 'unexcepted error at vpn KPI ';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException('Network Client not initialized');
    } on DioException catch (error) {
      log('caught Dio error: $error');
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Unknown network error');
    } catch (e) {
      log('error getVpnRequestById: $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<TrendBreakdownModel> getTrendBreakdownData(String period) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.vpnTrendBreakdown(period),
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
  Future<StatusBreakdownModel> getStatusBreakdownData(String period) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.vpnStatusBreakdown(period),
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
            final documentId = fileData['documentId'];

            uploadedResults.add({
              'file_name': fileData['originalName'] ?? fileName,
              'file_url': documentId, // only documentId
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
  Future<void> sendVPNTicket(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.vpnNewTicket;
    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ New VPN ticket sent successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Request sent successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ?? 'Failed to send VPN request',
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

  Future<TechniciansResponse> getTechnicianData({
    required int id,
    required int sectionId,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.vpnTechnicians(id, sectionId),
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return TechniciansResponse.fromJson(data);
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
      log('error getTechnicianDatan $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> sendAssign(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.vpnAssign;
    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ New VPN assign sent successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'assign sent successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ?? 'Failed to send VPN assign',
          );
          debugPrint('⚠️ Failed to send assign : ${response.statusCode}');
        }
      } else {
        debugPrint('❌ Client is null — cannot send assign ');
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
  Future<void> approveorReject(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.vpnApproveorReject;
    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ New Approvre or Reject sent successfully');
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Approvre or Reject successfully',
          );
        } else {
          ShowFlutterToast().showFlutterToastFailure(
            response.data['message'] ?? 'Failed to send Approvre or Reject',
          );
          debugPrint(
            '⚠️ Failed to Approvre or Reject : ${response.statusCode}',
          );
        }
      } else {
        debugPrint('❌ Client is null — Approvre or Reject ');
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
  Future<String> sendChat(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.vpnChat(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ chat sent successfully');

          return response.data["message"] ?? "Success";
        } else {
          debugPrint('⚠️ Failed to chat: ${response.statusCode}');
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

    final String url = ApiEndPoint.vpnAttachment(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ chat sent successfully');

          return response.data["message"] ?? "Success";
        } else {
          debugPrint('⚠️ Failed to chat: ${response.statusCode}');
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
}
