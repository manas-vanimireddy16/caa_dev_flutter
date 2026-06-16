import 'dart:convert';
import 'dart:developer';

import 'package:code_setup/modules/domain/core/storage/persistent_storage/persistent_storage.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/models/user_model.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- USER MODEL ---

class User {
  final int? userId;
  final bool? isAdmin;
  final String? employeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? personType;
  final int? section;
  final String? sectionName;
  final int? position;
  final String? positionName;
  final int? department;
  final String? departmentName;
  final String? email;
  final String? accessToken;

  User({
    this.userId,
    this.isAdmin,
    this.employeeId,
    this.employeeName,
    this.employeeArabicName,
    this.personType,
    this.section,
    this.sectionName,
    this.position,
    this.positionName,
    this.department,
    this.departmentName,
    this.email,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as int?,
      isAdmin: json['is_admin'] as bool?,
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      employeeArabicName: json['employee_arabic_name'] as String?,
      personType: json['person_type'] as String?,
      section: json['section'] as int?,
      sectionName: json['section_name'] as String?,
      position: json['position'] as int?,
      positionName: json['position_name'] as String?,
      department: json['department'] as int?,
      departmentName: json['department_name'] as String?,
      email: json['email'] as String?,
      accessToken: json['accessToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'is_admin': isAdmin,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'employee_arabic_name': employeeArabicName,
      'person_type': personType,
      'section': section,
      'section_name': sectionName,
      'position': position,
      'position_name': positionName,
      'department': department,
      'department_name': departmentName,
      'email': email,
      'accessToken': accessToken,
    };
  }
}

// --- RIVERPOD PROVIDER for User ---

final userProvider = StateProvider<User?>((ref) => null);
final rolesProvider = StateProvider<SelectedUserRole?>((ref) => null);
final userInfoProvider = StateProvider<UserInformation?>((ref) => null);

// --- KAUTHCRED CLASS ---

class KAuthCred {
  static const storageKey = 'fm';
  static const roleKey = 'role';
  static const userInfokey = 'userInfo';

  final KPersistentStorage _persistentStorage;

  KAuthCred({KPersistentStorage? persistentStorage})
    : _persistentStorage = persistentStorage ?? KPersistentStorage();

  /// Store User profile in persistent storage and update Riverpod state
  Future<void> storeProfileData(User user) async {
    print(user);
    try {
      KAppX.globalProvider.read(userProvider.notifier).state = user;
      await _persistentStorage.store(
        key: storageKey,
        data: user.toJson(),
        encoder: jsonEncode,
        overwrite: true,
      );
      log('Successfully saved profile data to persistent storage.');
    } catch (e, st) {
      log('Error saving profile data to persistent storage: $e\n$st');
    }
  }

  /// Retrieve User profile from persistent storage and update Riverpod state
  Future<User?> getProfileData() async {
    try {
      final jsonData = await _persistentStorage.retrieve(
        key: storageKey,
        decoder: jsonDecode,
      );

      if (jsonData != null) {
        final user = User.fromJson(Map<String, dynamic>.from(jsonData));
        KAppX.globalProvider.read(userProvider.notifier).state = user;
        return user;
      }
    } catch (e, st) {
      log('Error retrieving profile data from persistent storage: $e\n$st');
    }
    return null;
  }

  /// Delete User profile from persistent storage and clear Riverpod state
  Future<void> deleteProfileData() async {
    try {
      await _persistentStorage.delete(key: storageKey);
      KAppX.globalProvider.read(userProvider.notifier).state = null;
      log('Successfully deleted profile data from persistent storage.');
    } catch (e, st) {
      log('Error deleting profile data from persistent storage: $e\n$st');
    }
  }

  ///
  // 🔥 Store only SelectedUserRole
  Future<void> storeSelectedRole(SelectedUserRole role) async {
    try {
      final scopedRole = MobileServiceScope.filterSelectedRole(role);
      KAppX.globalProvider.read(rolesProvider.notifier).state = scopedRole;
      await _persistentStorage.store(
        key: roleKey, // Use same key
        data: scopedRole.toJson(),
        encoder: jsonEncode,
        overwrite: true,
      );
      log('✅ Selected role saved to persistent storage.');
    } catch (e, st) {
      log('❌ Error saving selected role: $e\n$st');
    }
  }

  // 🔥 Retrieve only SelectedUserRole
  Future<SelectedUserRole?> getSelectedRole() async {
    try {
      final jsonData = await _persistentStorage.retrieve(
        key: roleKey,
        decoder: jsonDecode,
      );

      if (jsonData != null) {
        final role = MobileServiceScope.filterSelectedRole(
          SelectedUserRole.fromJson(Map<String, dynamic>.from(jsonData)),
        );

        KAppX.globalProvider.read(rolesProvider.notifier).state = role;

        return role;
      }
    } catch (e, st) {
      log('❌ Error retrieving selected role: $e\n$st');
    }
    return null;
  }

  Future<void> deleteRoleData() async {
    try {
      await _persistentStorage.delete(key: roleKey);
      KAppX.globalProvider.read(rolesProvider.notifier).state = null;
      log('Successfully deleted role data from persistent storage.');
    } catch (e, st) {
      log('Error deleting role data from persistent storage: $e\n$st');
    }
  }

  Future<void> storeUserInfo(UserInformation user) async {
    print(user);
    try {
      KAppX.globalProvider.read(userInfoProvider.notifier).state = user;
      await _persistentStorage.store(
        key: userInfokey,
        data: user.toJson(),
        encoder: jsonEncode,
        overwrite: true,
      );
      log('Successfully role  data to persistent storage.');
    } catch (e, st) {
      log('Error saving role data to persistent storage: $e\n$st');
    }
  }

  Future<UserInformation?> getUserInfoData() async {
    try {
      final jsonData = await _persistentStorage.retrieve(
        key: userInfokey,
        decoder: jsonDecode,
      );

      if (jsonData != null) {
        final role = UserInformation.fromJson(
          Map<String, dynamic>.from(jsonData),
        );
        KAppX.globalProvider.read(userInfoProvider.notifier).state = role;
        return role;
      }
    } catch (e, st) {
      log('Error retrieving role data from persistent storage: $e\n$st');
    }
    return null;
  }

  Future<void> deleteUserInfoData() async {
    try {
      await _persistentStorage.delete(key: userInfokey);
      KAppX.globalProvider.read(userInfoProvider.notifier).state = null;
      log('Successfully deleted user info data from persistent storage.');
    } catch (e, st) {
      log('Error deleting user info data from persistent storage: $e\n$st');
    }
  }

  Future<void> clearSession() async {
    await deleteProfileData();
    await deleteUserInfoData();
    await deleteRoleData();
  }
}
