import 'package:code_setup/modules/data/roles_imple.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/user_model.dart';

abstract class RolesRepo {
  factory RolesRepo() => RolesRepoImpl();

  Future<UserRoleResponse> getUserRoles(int id);
  Future<UserInformation> getUserInfo(int id);
}
