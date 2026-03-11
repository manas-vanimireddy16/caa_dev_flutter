import 'dart:developer';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import '../domain/models/user_model.dart';

class RolesRepoImpl implements RolesRepo {
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

  @override
  Future<UserInformation> getUserInfo(int id) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final response = await client.get(ApiEndPoint.userInfo(id));

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return UserInformation.fromJson(data);
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
      log('Error fetching user info: $e', stackTrace: stack);
      throw ApiException(e.toString());
    }
  }
}
