import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:flutter/foundation.dart';

class RoleService {
  static final RoleService _instance = RoleService._internal();
  factory RoleService() => _instance;
  RoleService._internal();

  final RolesRepo _repo = RolesRepo();
  final KAuthCred _storage = KAuthCred();

  Future<SelectedUserRole?> fetchAndStoreUserRole(int id) async {
    try {
      final userRoles = await _repo.getUserRoles(id);
      return await _selectOrStoreRole(userRoles);
    } catch (e) {
      debugPrint("RoleService error: $e");
      return null;
    }
  }

  Future<SelectedUserRole?> _selectOrStoreRole(
    UserRoleResponse userRoles,
  ) async {
    final saved = await _storage.getSelectedRole();

    if (saved != null) {
      print("🔵 Using saved role ${saved.roleName}");
      return MobileServiceScope.filterSelectedRole(saved);
    }

    final first = userRoles.data!.rolesSummary!.first;

    final detail = userRoles.data!.roleDetails!.firstWhere(
      (e) => e.role?.id == first.roleId,
      orElse: () => userRoles.data!.roleDetails!.first,
    );

    final selected = MobileServiceScope.filterSelectedRole(
      SelectedUserRole(
        roleId: first.roleId!,
        roleName: first.roleName!,
        departmentId: detail.department?.id ?? 0,
        sectionId: detail.section?.id ?? 0,
        services: detail.services ?? [],
      ),
    );

    await _storage.storeSelectedRole(selected);

    return selected;
  }
}
