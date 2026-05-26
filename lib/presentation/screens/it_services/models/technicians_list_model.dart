class TechnicianResponseModel {
  final String? status;
  final String? message;
  final List<TechnicianData>? data;

  TechnicianResponseModel({this.status, this.message, this.data});

  factory TechnicianResponseModel.fromJson(Map<String, dynamic> json) {
    return TechnicianResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<TechnicianData>.from(
              json['data'].map((x) => TechnicianData.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class TechnicianData {
  final int? userId;
  final String? employeeName;
  final String? email;
  final String? mobile;
  final int? roleId;
  final String? roleName;
  final String? roleArabicName;
  final int? inProgressCount;
  final int? completedCount;
  final int? rejectedCount;
  final int? lastRequestId;
  final String? lastStatus;
  final DateTime? lastHandledAt;

  TechnicianData({
    this.userId,
    this.employeeName,
    this.email,
    this.mobile,
    this.roleId,
    this.roleName,
    this.roleArabicName,
    this.inProgressCount,
    this.completedCount,
    this.rejectedCount,
    this.lastRequestId,
    this.lastStatus,
    this.lastHandledAt,
  });

  factory TechnicianData.fromJson(Map<String, dynamic> json) {
    return TechnicianData(
      userId: json['user_id'],
      employeeName: json['employee_name'],
      email: json['email'],
      mobile: json['mobile'],
      roleId: json['role_id'],
      roleName: json['role_name'],
      roleArabicName: json['role_arabic_name'],
      inProgressCount: json['in_progress_count'],
      completedCount: json['completed_count'],
      rejectedCount: json['rejected_count'],
      lastRequestId: json['last_request_id'],
      lastStatus: json['last_status'],
      lastHandledAt: json['last_handled_at'] != null
          ? DateTime.parse(json['last_handled_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'employee_name': employeeName,
      'email': email,
      'mobile': mobile,
      'role_id': roleId,
      'role_name': roleName,
      'role_arabic_name': roleArabicName,
      'in_progress_count': inProgressCount,
      'completed_count': completedCount,
      'rejected_count': rejectedCount,
      'last_request_id': lastRequestId,
      'last_status': lastStatus,
      'last_handled_at': lastHandledAt?.toIso8601String(),
    };
  }
}
