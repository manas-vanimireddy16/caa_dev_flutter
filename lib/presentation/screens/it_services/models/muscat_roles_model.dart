class RolesResponseModel {
  final String? status;
  final String? message;
  final RolesData? data;

  RolesResponseModel({this.status, this.message, this.data});

  factory RolesResponseModel.fromJson(Map<String, dynamic> json) {
    return RolesResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? RolesData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class RolesData {
  final String? type;
  final int? departmentId;
  final int? sectionId;
  final List<RoleItem>? roles;

  RolesData({this.type, this.departmentId, this.sectionId, this.roles});

  factory RolesData.fromJson(Map<String, dynamic> json) {
    return RolesData(
      type: json['type'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
      roles: json['roles'] != null
          ? (json['roles'] as List).map((e) => RoleItem.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'department_id': departmentId,
      'section_id': sectionId,
      'roles': roles?.map((e) => e.toJson()).toList(),
    };
  }
}

class RoleItem {
  final int? roleId;
  final String? roleName;
  final String? roleNameAr;

  RoleItem({this.roleId, this.roleName, this.roleNameAr});

  factory RoleItem.fromJson(Map<String, dynamic> json) {
    return RoleItem(
      roleId: json['role_id'],
      roleName: json['role_name'],
      roleNameAr:
          json['role_arabic_name'] as String? ??
          json['arabic_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'role_name': roleName,
      'role_arabic_name': roleNameAr,
    };
  }

  String displayName({required bool isArabic}) {
    if (isArabic) {
      final trimmed = roleNameAr?.trim();
      if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    }
    return roleName?.trim() ?? '';
  }
}
