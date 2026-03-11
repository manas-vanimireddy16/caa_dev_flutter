import 'package:code_setup/presentation/models/details_models.dart';

class PendingApprovalUsersResponse {
  final String? status;
  final String? message;
  final List<PendingApprovalUser>? data;
  final int? totalUsers;

  PendingApprovalUsersResponse({
    this.status,
    this.message,
    this.data,
    this.totalUsers,
  });

  factory PendingApprovalUsersResponse.fromJson(Map<String, dynamic> json) {
    return PendingApprovalUsersResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PendingApprovalUser.fromJson(e))
          .toList(),
      totalUsers: json['total_users'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.map((e) => e.toJson()).toList(),
      "total_users": totalUsers,
    };
  }
}

class PendingApprovalUser {
  final int? userId;
  final String? employeeId;
  final String? employeeName;
  final String? email;
  final Department? department;
  final Department? section;
  final int? pendingApprovalCount;

  PendingApprovalUser({
    this.userId,
    this.employeeId,
    this.employeeName,
    this.email,
    this.department,
    this.section,
    this.pendingApprovalCount,
  });

  factory PendingApprovalUser.fromJson(Map<String, dynamic> json) {
    return PendingApprovalUser(
      userId: json['user_id'] as int?,
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      email: json['email'] as String?,
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      section: json['section'] != null
          ? Department.fromJson(json['section'])
          : null,
      pendingApprovalCount: json['pending_approval_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "employee_id": employeeId,
      "employee_name": employeeName,
      "email": email,
      "department": department?.toJson(),
      "section": section?.toJson(),
      "pending_approval_count": pendingApprovalCount,
    };
  }
}

class Department {
  final int? id;
  final String? name;

  Department({this.id, this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(id: json['id'] as int?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
