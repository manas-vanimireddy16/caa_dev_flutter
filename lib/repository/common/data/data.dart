import 'dart:developer';
import 'dart:typed_data';

import 'package:code_setup/repository/common/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';

class CommonRepositoryImpl implements CommonRepository {
  @override
  String resolveDownloadPath(String fileUrl) {
    final trimmed = fileUrl.trim();
    if (trimmed.isEmpty) return '';

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    if (trimmed.startsWith('/')) {
      return trimmed;
    }

    return '${ApiEndPoint.downloadFiles}/$trimmed';
  }

  @override
  Future<Uint8List> downloadAttachment({required String fileUrl}) async {
    final path = resolveDownloadPath(fileUrl);
    if (path.isEmpty) {
      throw ApiException('File URL is missing');
    }

    try {
      final client = await KAppX.network.secureClient();
      if (client == null) {
        throw ApiException('Failed to initialize network client');
      }

      final Response<dynamic> response;
      if (path.startsWith('http://') || path.startsWith('https://')) {
        response = await client.get(
          path,
          options: Options(responseType: ResponseType.bytes),
        );
      } else {
        response = await client.get(
          path,
          options: Options(responseType: ResponseType.bytes),
        );
      }

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List<int>) {
          return Uint8List.fromList(response.data as List<int>);
        }
        if (response.data is Uint8List) {
          return response.data as Uint8List;
        }
      }

      final errorMessage =
          response.data is Map ? response.data['message'] : 'Download failed';
      throw ApiException(errorMessage?.toString() ?? 'Download failed');
    } on DioException catch (error) {
      log('download attachment error: ${error.message}');
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Download failed');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
