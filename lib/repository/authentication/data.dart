import 'dart:developer';

import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/repository/authentication/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';

class AuthRepositpryImpl implements AuthRepository {
  @override
  Future<Map<String, dynamic>?> getAuthTokenWithSSOAccessToken(
    String accessToken,
  ) async {
    try {
      final client = await KAppX.network.unsecureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.authMobileSignin,
          queryParameters: {'accessToken': accessToken},
        );
        if (response.statusCode == 200 && response.data != null) {
          return Map<String, dynamic>.from(response.data);
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {}
    return null;
  }

  @override
  Future<FileUploadDataModel?> uploadFile(FormData formData) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.uploadFiles,
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          final data = FileUploadDataModel.fromJson(response.data);
          return data;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
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
  Future<UserRoleResponse> getUserRoles(int id) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final response = await client.get(ApiEndPoint.userRoles(id));

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return UserRoleResponse.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      } else {
        throw ApiException('Failed to initialize network client');
      }
    } on DioException catch (error) {
      log('Caught Dio error: ${error.message}');
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Network error occurred');
    } catch (e, stack) {
      log('Error fetching user roles: $e', stackTrace: stack);
      throw ApiException(e.toString());
    }
  }
}
