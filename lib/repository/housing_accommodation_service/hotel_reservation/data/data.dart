import 'dart:developer';
import 'dart:io';

import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/chat_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/presentation/screens/security_access/models/request_model.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class HotelReservationRepoistoryImple implements HotelReservationRepoistory {
  static const String _serviceLabel = 'Hotel Reservation';

  @override
  Future<Map<String, dynamic>> hotelReservationCreateRequest(
    Map<String, dynamic> payload,
  ) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.hotelReservationSendRequest;

    try {
      if (client == null) {
        throw ApiException(
          'Client is null — cannot create $_serviceLabel request',
        );
      }

      final response = await client.post(url, data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ShowFlutterToast().showFlutterToastSuccess(
          response.data['message'] ?? '$_serviceLabel request sent successfully',
        );
        return response.data as Map<String, dynamic>; // ✅ RETURN HERE
      } else {
        ShowFlutterToast().showFlutterToastFailure(
          response.data['message'] ??
              'Failed to create $_serviceLabel request',
        );
        return response.data as Map<String, dynamic>; // ✅ RETURN HERE
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          'Failed to create $_serviceLabel request';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('Failed to create $_serviceLabel request: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  ) async {
    final client = await KAppX.network.secureClient();
    final List<Map<String, dynamic>> uploadedResults = [];

    if (client == null) {
      debugPrint(
        '❌ Client is null — cannot upload $_serviceLabel attachments',
      );
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
        debugPrint(
          '❌ Failed to upload $_serviceLabel attachment: '
          '${e.response?.data ?? e.message}',
        );
      } catch (e) {
        debugPrint('❌ Unexpected error uploading $_serviceLabel attachment: $e');
        throw e;
      }
    }

    return uploadedResults;
  }

  @override
  Future<KPIResponse?> getKpiData(int serviceId, int subServiceId) async {
    String url = ApiEndPoint.hotelReservationKpiCards;
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
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel KPI data';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('Failed to fetch $_serviceLabel KPI data');
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel KPI data';
      throw ApiException(message);
    } catch (e) {
      log('Failed to fetch $_serviceLabel KPI data: $e');
      throw ApiException('Failed to fetch $_serviceLabel KPI data: $e');
    }
  }

  @override
  Future<KPIResponse?> getApprovalKpiData({
    required int serviceId,
    required int subServiceId,
  }) async {
    String url = ApiEndPoint.hotelReservationApprovalKpiCards;
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
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel approval KPI data';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('Failed to fetch $_serviceLabel approval KPI data');
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel approval KPI data';
      throw ApiException(message);
    } catch (e) {
      log('Failed to fetch $_serviceLabel approval KPI data: $e');
      throw ApiException('Failed to fetch $_serviceLabel approval KPI data: $e');
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
          ApiEndPoint.hotelReservationApprovalStatusBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return StatusBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel approval status breakdown';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException(
        'Client is null — cannot fetch $_serviceLabel approval status breakdown',
      );
    } on DioException catch (error) {
      log('Failed to fetch $_serviceLabel approval status breakdown');
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel approval status breakdown';
      throw ApiException(message);
    } catch (e) {
      log('Failed to fetch $_serviceLabel approval status breakdown: $e');
      throw ApiException(
        'Failed to fetch $_serviceLabel approval status breakdown: $e',
      );
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
          ApiEndPoint.hotelReservationApprovalTrendBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return TrendBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel approval trend breakdown';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException(
        'Client is null — cannot fetch $_serviceLabel approval trend breakdown',
      );
    } on DioException catch (error) {
      log('Failed to fetch $_serviceLabel approval trend breakdown');
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel approval trend breakdown';
      throw ApiException(message);
    } catch (e) {
      log('Failed to fetch $_serviceLabel approval trend breakdown: $e');
      throw ApiException(
        'Failed to fetch $_serviceLabel approval trend breakdown: $e',
      );
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
          ApiEndPoint.hotelReservationStatusBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return StatusBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel status breakdown';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException(
        'Client is null — cannot fetch $_serviceLabel status breakdown',
      );
    } on DioException catch (error) {
      log('Failed to fetch $_serviceLabel status breakdown');
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel status breakdown';
      throw ApiException(message);
    } catch (e) {
      log('Failed to fetch $_serviceLabel status breakdown: $e');
      throw ApiException('Failed to fetch $_serviceLabel status breakdown: $e');
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
          ApiEndPoint.hotelReservationTrendBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return TrendBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel trend breakdown';
          throw ApiException(errorMessage);
        }
      }
      throw ApiException(
        'Client is null — cannot fetch $_serviceLabel trend breakdown',
      );
    } on DioException catch (error) {
      log('Failed to fetch $_serviceLabel trend breakdown');
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel trend breakdown';
      throw ApiException(message);
    } catch (e) {
      log('Failed to fetch $_serviceLabel trend breakdown: $e');
      throw ApiException('Failed to fetch $_serviceLabel trend breakdown: $e');
    }
  }

  @override
  Future<List<HotelReservationRequestModel>> getRequests({
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
        };

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        if (status.isNotEmpty) {
          queryParams['status'] = status;
        }
        final url = ApiEndPoint.hotelReservationGetRequests;
        final response = await client.get(url, queryParameters: queryParams);

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
          throw ApiException(
            'Failed to fetch $_serviceLabel requests: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } on DioException catch (error) {
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel requests';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('Failed to fetch $_serviceLabel requests: $e');
    }
  }

  @override
  Future<List<HotelReservationRequestModel>> getActionItems({
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
          ApiEndPoint.hotelReservationGetActionItems,
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
              response.data?['message'] ??
              'Failed to fetch $_serviceLabel action items';
          throw ApiException(errorMessage);
        }
      }

      /// If client is null
      return [];
    } on DioException catch (error) {
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel action items';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('Failed to fetch $_serviceLabel action items: $e');
    }
  }

  @override
  Future<String> sendChat(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.hotelReservationSendChatById(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ??
                '$_serviceLabel chat message sent successfully',
          );
          debugPrint('✅ $_serviceLabel chat message sent successfully');

          return response.data["message"] ?? "Success";
        } else {
          debugPrint(
            '⚠️ Failed to send $_serviceLabel chat message: '
            '${response.statusCode}',
          );
          return response.data["message"] ??
              'Failed to send $_serviceLabel chat message';
        }
      } else {
        debugPrint(
          '❌ Client is null — cannot send $_serviceLabel chat message',
        );
        return 'Client is null — cannot send $_serviceLabel chat message';
      }
    } on DioException catch (e) {
      debugPrint(
        '❌ Failed to send $_serviceLabel chat message: '
        '${e.response?.data ?? e.message}',
      );
      throw e;
    } catch (e) {
      debugPrint('❌ Unexpected error sending $_serviceLabel chat message: $e');
      throw e;
    }
  }

  @override
  Future<String> sendAttachment(Map<String, dynamic> payload, int id) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.hotelReservationSendAttachmentById(id);

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ??
                '$_serviceLabel attachment sent successfully',
          );
          debugPrint('✅ $_serviceLabel attachment sent successfully');

          return response.data["message"] ?? "Success";
        } else {
          debugPrint(
            '⚠️ Failed to send $_serviceLabel attachment: '
            '${response.statusCode}',
          );
          return response.data["message"] ??
              'Failed to send $_serviceLabel attachment';
        }
      } else {
        debugPrint(
          '❌ Client is null — cannot send $_serviceLabel attachment',
        );
        return 'Client is null — cannot send $_serviceLabel attachment';
      }
    } on DioException catch (e) {
      debugPrint(
        '❌ Failed to send $_serviceLabel attachment: '
        '${e.response?.data ?? e.message}',
      );
      throw e;
    } catch (e) {
      debugPrint('❌ Unexpected error sending $_serviceLabel attachment: $e');
      throw e;
    }
  }

  @override
  Future<void> deleteAttachment(int attachmentId, {int? requestId}) async {
    final client = await KAppX.network.secureClient();
    if (client == null) {
      throw ApiException(
        'Client is null — cannot delete $_serviceLabel attachment',
      );
    }

    final url = ApiEndPoint.hotelReservationDeleteAttachment(attachmentId);

    try {
      final response = await client.delete(url);
      if (response.statusCode != 200 &&
          response.statusCode != 201 &&
          response.statusCode != 204) {
        throw ApiException(
          response.data?['message'] ??
              'Failed to delete $_serviceLabel attachment',
        );
      }
    } on DioException catch (error) {
      final message =
          error.response?.data['message'] ??
          'Failed to delete $_serviceLabel attachment';
      throw ApiException(message);
    }
  }

  @override
  Future<void> onApprove(Map<String, dynamic> payload) async {
    final client = await KAppX.network.secureClient();
    final String url = ApiEndPoint.hotelReservationApprove;

    try {
      if (client != null) {
        final response = await client.put(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ShowFlutterToast().showFlutterToastSuccess(
            '${response.data['message']}',
          );
          debugPrint('✅ $_serviceLabel request approved successfully');
        } else {
          debugPrint(
            '⚠️ Failed to approve $_serviceLabel request: '
            '${response.statusCode}',
          );
          ShowFlutterToast().showFlutterToastFailure(
            response.data?['message'] ??
                'Failed to approve $_serviceLabel request',
          );
        }
      } else {
        debugPrint(
          '❌ Client is null — cannot approve $_serviceLabel request',
        );
      }
    } on DioException catch (e) {
      debugPrint(
        '❌ Failed to approve $_serviceLabel request: '
        '${e.response?.data ?? e.message}',
      );
      throw e;
    } catch (e) {
      debugPrint('❌ Unexpected error approving $_serviceLabel request: $e');
      throw e;
    }
  }

  @override
  Future<List<ChatMessageModel>> getchatById(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.hotelReservationChatsById(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = ChatByIdResponseModel.fromJson(json);

          /// Return only `data` (so UI can access sub-objects)
          return result.data;
        } else {
          throw ApiException(
            'Failed to fetch $_serviceLabel chat messages: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } on DioException catch (error) {
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel chat messages';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('Failed to fetch $_serviceLabel chat messages: $e');
    }
  }

  @override
  Future<List<AttachmentModel>> getAttachmentsById(int id) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.hotelReservationAttachmentsById(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = AttachmentByIdResponseModel.fromJson(json);

          /// Return only `data` (so UI can access sub-objects)
          return result.data;
        } else {
          throw ApiException(
            'Failed to fetch $_serviceLabel attachments: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } on DioException catch (error) {
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel attachments';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('Failed to fetch $_serviceLabel attachments: $e');
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
          // 'service_id': serviceId,
          // 'sub_service_id': subServiceId,
        };
        final url = ApiEndPoint.hotelReservationRequestById(id);
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = response.data;

          /// Convert JSON → Model
          final result = RequestDetailModel.fromJson(json);

          /// Return only `data` (so UI can access sub-objects)
          return result.data;
        } else {
          throw ApiException(
            'Failed to fetch $_serviceLabel request details: ${response.statusCode}',
          );
        }
      } else {
        return null;
      }
    } on DioException catch (error) {
      final message =
          error.response?.data['message'] ??
          'Failed to fetch $_serviceLabel request details';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('Failed to fetch $_serviceLabel request details: $e');
    }
  }
}
