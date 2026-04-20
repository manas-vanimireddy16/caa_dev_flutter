import 'package:code_setup/modules/domain/models/roles_model.dart';

class SelectedUserRole {
  final int roleId;
  final String roleName;
  final int departmentId;
  final int sectionId;
  final List<Service> services;

  SelectedUserRole({
    required this.roleId,
    required this.roleName,
    required this.departmentId,
    required this.sectionId,
    required this.services,
  });

  factory SelectedUserRole.fromJson(Map<String, dynamic> json) {
    return SelectedUserRole(
      roleId: json['role_id'],
      roleName: json['role_name'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
      services:
          (json['services'] as List?)
              ?.map((e) => Service.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role_id": roleId,
      "role_name": roleName,
      "department_id": departmentId,
      "section_id": sectionId,
      "services": services.map((e) => e.toJson()).toList(),
    };
  }
}
