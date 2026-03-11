class SelectedUserRole {
  final int roleId;
  final String roleName;
  final int departmentId;
  final int sectionId;

  SelectedUserRole({
    required this.roleId,
    required this.roleName,
    required this.departmentId,
    required this.sectionId,
  });

  factory SelectedUserRole.fromJson(Map<String, dynamic> json) {
    return SelectedUserRole(
      roleId: json['role_id'],
      roleName: json['role_name'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role_id": roleId,
      "role_name": roleName,
      "department_id": departmentId,
      "section_id": sectionId,
    };
  }
}
