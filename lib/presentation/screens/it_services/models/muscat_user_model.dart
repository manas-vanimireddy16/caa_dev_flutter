class UsersResponseModel {
  final String? status;
  final String? message;
  final UsersData? data;

  UsersResponseModel({this.status, this.message, this.data});

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UsersData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class UsersData {
  final String? type;
  final int? departmentId;
  final int? sectionId;
  final int? roleId;
  final List<Users>? users;

  UsersData({
    this.type,
    this.departmentId,
    this.sectionId,
    this.roleId,
    this.users,
  });

  factory UsersData.fromJson(Map<String, dynamic> json) {
    return UsersData(
      type: json['type'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
      roleId: json['role_id'],
      users: json['users'] != null
          ? (json['users'] as List).map((e) => Users.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'department_id': departmentId,
      'section_id': sectionId,
      'role_id': roleId,
      'users': users?.map((e) => e.toJson()).toList(),
    };
  }
}

class Users {
  final int? userId;
  final int? roleId;
  final String? roleName;
  final String? employeeName;
  final String? employeeArabicName;
  final String? email;
  final String? mobile;

  Users({
    this.userId,
    this.roleId,
    this.roleName,
    this.employeeName,
    this.employeeArabicName,
    this.email,
    this.mobile,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'],
      roleId: json['role_id'],
      roleName: json['role_name'],
      employeeName: json['employee_name'],
      employeeArabicName: json['employee_arabic_name'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role_id': roleId,
      'role_name': roleName,
      'employee_name': employeeName,
      'employee_arabic_name': employeeArabicName,
      'email': email,
      'mobile': mobile,
    };
  }

  String displayName({required bool isArabic}) {
    if (isArabic) {
      final trimmed = employeeArabicName?.trim();
      if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    }
    return employeeName?.trim() ?? '';
  }
}
