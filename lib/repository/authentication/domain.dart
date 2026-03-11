import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/repository/authentication/data.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  factory AuthRepository() => AuthRepositpryImpl();

  Future<Map<String, dynamic>?> getAuthTokenWithSSOAccessToken(
    String accessToken,
  );
  Future<FileUploadDataModel?> uploadFile(FormData formData);
  Future<UserRoleResponse> getUserRoles(int id);
}
