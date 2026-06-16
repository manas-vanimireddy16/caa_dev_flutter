import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rolesControllerProvider =
    StateNotifierProvider<RolesController, SelectedUserRole?>((ref) {
      return RolesController(ref);
    });

class RolesController extends StateNotifier<SelectedUserRole?> {
  final Ref ref;

  RolesController(this.ref) : super(null);

  Future<void> fetchRoles() async {
    try {
      /// ✅ GET USER INFO
      final userInfo = ref.read(userInfoProvider);
      final roleInfo = ref.read(rolesProvider);

      final userId = int.tryParse(userInfo?.data?.id ?? '');
      final roleId = roleInfo?.roleId;

      if (userId == null) return;

      /// ✅ API CALL
      final repo = RolesRepo();
      final userRoles = await repo.getUserRoles(userId);

      if (userRoles?.data?.roleDetails == null ||
          userRoles!.data!.roleDetails!.isEmpty) {
        return;
      }

      /// ✅ FIND MATCHING ROLE
      final detail = userRoles.data!.roleDetails!.firstWhere(
        (e) => e.role?.id == roleId,
        orElse: () => userRoles.data!.roleDetails!.first,
      );

      /// ✅ CREATE SELECTED ROLE
      final selected = MobileServiceScope.filterSelectedRole(
        SelectedUserRole(
          roleId: detail.role?.id ?? 0,
          roleName: detail.role?.name ?? '',
          departmentId: detail.department?.id ?? 0,
          sectionId: detail.section?.id ?? 0,
          services: detail.services ?? [],
        ),
      );

      /// ✅ UPDATE STATE
      state = selected;

      /// ✅ SAVE TO STORAGE
      await KAuthCred().storeSelectedRole(selected);
    } catch (e) {
      print("Error fetching roles: $e");
    }
  }

  Future<void> loadFromStorage() async {
    final stored = await KAuthCred().getSelectedRole();
    state = stored == null
        ? null
        : MobileServiceScope.filterSelectedRole(stored);
  }
}
