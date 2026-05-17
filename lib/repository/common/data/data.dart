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
import 'package:code_setup/repository/common/domain/domain.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class CommonRepoistoryImple implements CommonRepoistory {
  @override
  Future<dynamic> downloadFile(String id) async {
    String url = ApiEndPoint.download(id);
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final response = await client.get(
          url,
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == 200) {
          final contentType = response.headers.value('content-type') ?? '';

          // IMAGE
          if (contentType.contains('image/png') ||
              contentType.contains('image/jpeg') ||
              contentType.contains('image/jpg')) {
            return {
              'type': 'image',
              'bytes': response.data,
              'contentType': contentType,
            };
          }
          // PDF
          else if (contentType.contains('application/pdf')) {
            return {
              'type': 'pdf',
              'bytes': response.data,
              'contentType': contentType,
            };
          }
          // DOC
          else if (contentType.contains('application/msword')) {
            return {
              'type': 'doc',
              'bytes': response.data,
              'contentType': contentType,
            };
          }
          // DOCX
          else if (contentType.contains(
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          )) {
            return {
              'type': 'docx',
              'bytes': response.data,
              'contentType': contentType,
            };
          } else {
            throw ApiException('Unsupported file type');
          }
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';

          throw ApiException(errorMessage);
        }
      }

      return null;
    } on DioException catch (error) {
      log('caught dio error while downloading file');

      final message = error.response?.data['message'] ?? error.message;

      throw ApiException(message);
    } catch (e) {
      log('error downloading file $e');
      throw ApiException(e.toString());
    }
  }
}
