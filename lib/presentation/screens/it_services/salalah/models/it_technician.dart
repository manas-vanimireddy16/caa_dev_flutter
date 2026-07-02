import 'package:code_setup/utils/helper/localized_display_name.dart';

class ITTechnicianListModel {
  final String? status;
  final List<UserItem>? data;
  final int? totalCount;
  final Filters? filters;

  ITTechnicianListModel({
    this.status,
    this.data,
    this.totalCount,
    this.filters,
  });

  factory ITTechnicianListModel.fromJson(
    Map<String, dynamic> json,
  ) => ITTechnicianListModel(
    status: json["status"],
    data: json["data"] == null
        ? []
        : List<UserItem>.from(json["data"].map((x) => UserItem.fromJson(x))),
    totalCount: json["total_count"],
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.map((x) => x.toJson()).toList(),
    "total_count": totalCount,
    "filters": filters?.toJson(),
  };
}

class UserItem {
  final int? userId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? email;
  final String? mobile;
  final int? roleId;
  final String? roleName;
  final int? departmentId;
  final String? departmentName;
  final int? sectionId;
  final String? sectionName;

  UserItem({
    this.userId,
    this.employeeName,
    this.employeeArabicName,
    this.email,
    this.mobile,
    this.roleId,
    this.roleName,
    this.departmentId,
    this.departmentName,
    this.sectionId,
    this.sectionName,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
    userId: json["user_id"],
    employeeName: json["employee_name"],
    employeeArabicName: json["employee_arabic_name"],
    email: json["email"],
    mobile: json["mobile"],
    roleId: json["role_id"],
    roleName: json["role_name"],
    departmentId: json["department_id"],
    departmentName: json["department_name"],
    sectionId: json["section_id"],
    sectionName: json["section_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "employee_name": employeeName,
    "employee_arabic_name": employeeArabicName,
    "email": email,
    "mobile": mobile,
    "role_id": roleId,
    "role_name": roleName,
    "department_id": departmentId,
    "department_name": departmentName,
    "section_id": sectionId,
    "section_name": sectionName,
  };

  String displayName({required bool isArabic}) => localizedDisplayName(
    isArabic: isArabic,
    english: employeeName,
    arabic: employeeArabicName,
  );
}

class Filters {
  final String? roleName;
  final int? departmentId;
  final int? sectionId;

  Filters({this.roleName, this.departmentId, this.sectionId});

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    roleName: json["role_name"],
    departmentId: json["department_id"],
    sectionId: json["section_id"],
  );

  Map<String, dynamic> toJson() => {
    "role_name": roleName,
    "department_id": departmentId,
    "section_id": sectionId,
  };
}
