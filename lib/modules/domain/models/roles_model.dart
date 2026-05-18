import 'dart:convert';

class UserRoleResponse {
  final String? status;
  final UserData? data;

  UserRoleResponse({this.status, this.data});

  factory UserRoleResponse.fromJson(Map<String, dynamic> json) {
    return UserRoleResponse(
      status: json['status'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};

  /// Helper to parse from raw JSON string
  static UserRoleResponse fromRawJson(String str) =>
      UserRoleResponse.fromJson(json.decode(str));

  /// Helper to convert back to raw JSON string
  String toRawJson() => json.encode(toJson());
}

class UserData {
  final int? userId;
  final int? totalRoles;
  final List<RoleSummary>? rolesSummary;
  final List<RoleDetail>? roleDetails;

  UserData({this.userId, this.totalRoles, this.rolesSummary, this.roleDetails});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'],
      totalRoles: json['total_roles'],
      rolesSummary: (json['roles_summary'] as List?)
          ?.map((e) => RoleSummary.fromJson(e))
          .toList(),
      roleDetails: (json['role_details'] as List?)
          ?.map((e) => RoleDetail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'total_roles': totalRoles,
    'roles_summary': rolesSummary?.map((e) => e.toJson()).toList(),
    'role_details': roleDetails?.map((e) => e.toJson()).toList(),
  };
}

class RoleSummary {
  final int? roleId;
  final String? roleName;

  RoleSummary({this.roleId, this.roleName});

  factory RoleSummary.fromJson(Map<String, dynamic> json) =>
      RoleSummary(roleId: json['role_id'], roleName: json['role_name']);

  Map<String, dynamic> toJson() => {'role_id': roleId, 'role_name': roleName};
}

class RoleDetail {
  final int? userRoleId;
  final bool? isActive;
  final Role? role;
  final Department? department;
  final Section? section;
  final List<Service>? services;

  RoleDetail({
    this.userRoleId,
    this.isActive,
    this.role,
    this.department,
    this.section,
    this.services,
  });

  factory RoleDetail.fromJson(Map<String, dynamic> json) => RoleDetail(
    userRoleId: json['user_role_id'],
    isActive: json['is_active'],
    role: json['role'] != null ? Role.fromJson(json['role']) : null,
    department: json['department'] != null
        ? Department.fromJson(json['department'])
        : null,
    section: json['section'] != null ? Section.fromJson(json['section']) : null,
    services: (json['services'] as List?)
        ?.map((e) => Service.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'user_role_id': userRoleId,
    'is_active': isActive,
    'role': role?.toJson(),
    'department': department?.toJson(),
    'section': section?.toJson(),
    'services': services?.map((e) => e.toJson()).toList(),
  };
}

class Role {
  final int? id;
  final String? name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Department {
  final int? id;
  final String? departmentName;

  Department({this.id, this.departmentName});

  factory Department.fromJson(Map<String, dynamic> json) =>
      Department(id: json['id'], departmentName: json['department_name']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'department_name': departmentName,
  };
}

class Section {
  final int? id;
  final String? sectionName;

  Section({this.id, this.sectionName});

  factory Section.fromJson(Map<String, dynamic> json) =>
      Section(id: json['id'], sectionName: json['section_name']);

  Map<String, dynamic> toJson() => {'id': id, 'section_name': sectionName};
}

class Service {
  final int? id;
  final String? code;
  final String? name;
  final String? description;
  final String? arabicName;
  final String? arabicDescription;
  final String? logoUrl;
  final List<SubService>? subservices;

  Service({
    this.id,
    this.code,
    this.name,
    this.description,
    this.logoUrl,
    this.subservices,
    this.arabicName,
    this.arabicDescription,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['id'],
    code: json['code'],
    name: json['name'],
    description: json['description'],
    logoUrl: json['logo_url'],
    subservices: (json['subservices'] as List?)
        ?.map((e) => SubService.fromJson(e))
        .toList(),
    arabicName: json['arabic_name'],
    arabicDescription: json['arabic_description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'description': description,
    'logo_url': logoUrl,
    'subservices': subservices?.map((e) => e.toJson()).toList(),
    'arabic_name': arabicName,
    'arabic_description': arabicDescription,
  };
}

class SubService {
  final int? id;
  final String? code;
  final String? subServiceName;
  final String? arabicsubServiceName;
  final String? arabicSubServiceDescription;
  final String? description;
  final String? logoUrl;

  SubService({
    this.id,
    this.code,
    this.subServiceName,
    this.description,
    this.logoUrl,
    this.arabicsubServiceName,
    this.arabicSubServiceDescription,
  });

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
    id: json['id'],
    code: json['code'],
    subServiceName: json['sub_service_name'],
    description: json['description'],
    logoUrl: json['logo_url'],
    arabicsubServiceName: json['arabic_name'],
    arabicSubServiceDescription: json['arabic_description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'sub_service_name': subServiceName,
    'description': description,
    'logo_url': logoUrl,
    'arabic_sub_service_name': arabicsubServiceName,
    'arabic_sub_service_description': arabicSubServiceDescription,
  };
}
