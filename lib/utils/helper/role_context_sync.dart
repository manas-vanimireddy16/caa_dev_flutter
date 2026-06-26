import 'dart:developer';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';

/// Syncs backend active-role context after the selected role changes.
class RoleContextSync {
  RoleContextSync._();

  static Future<void> syncAfterRoleChange(SelectedUserRole role) async {
    try {
      final user = await KAuthCred().getUserInfoData();
      // final userInfo = await KAuthCred().getUserInfoData();
      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      final userId =
          user?.data?.id?.toString() ?? userInfo?.data?.id?.toString() ?? '';

      if (userId.isEmpty || role.roleId == 0) {
        log('[RoleContextSync] Skipped: missing userId or roleId');
        return;
      }

      final client = await KAppX.network.secureClient();
      if (client == null) {
        log('[RoleContextSync] Skipped: secure client unavailable');
        return;
      }

      String? departmentName;
      String? sectionName;

      final parsedUserId = int.tryParse(userId);
      if (parsedUserId != null) {
        try {
          final userRoles = await RolesRepo().getUserRoles(parsedUserId);
          final details = userRoles.data?.roleDetails ?? const [];
          for (final detail in details) {
            if (detail.role?.id == role.roleId) {
              departmentName = detail.department?.departmentName;
              sectionName = detail.section?.sectionName;
              break;
            }
          }
        } catch (e) {
          log('[RoleContextSync] Could not enrich role metadata: $e');
        }
      }

      final response = await client.put(
        ApiEndPoint.setActiveRole,
        data: {
          'user_id': userId,
          'role_id': role.roleId,
          'role_name': role.roleName,
          'role_arabic_name': null,
          'department_id': role.departmentId,
          'section_id': role.sectionId,
          'role_department_id': role.departmentId,
          'role_section_id': role.sectionId,
          'role_department_name': departmentName,
          'role_section_name': sectionName,
        },
      );

      if (response.statusCode == 200) {
        log('[RoleContextSync] Active role synced via set-active');
        return;
      }

      log(
        '[RoleContextSync] set-active failed: '
        '${response.statusCode} ${response.data}',
      );
    } catch (e, st) {
      log('[RoleContextSync] Failed to sync active role: $e\n$st');
    }
  }
}
