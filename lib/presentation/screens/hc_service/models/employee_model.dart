class EmployeesResponse {
  final String? status;
  final String? message;
  final List<EmployeeSummary> data;

  EmployeesResponse({this.status, this.message, required this.data});

  factory EmployeesResponse.fromJson(Map<String, dynamic> json) {
    return EmployeesResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => EmployeeSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EmployeeSummary {
  final int? userId;
  final String? employeeName;
  // final String? employeeArabicName;
  final String? email;
  final String? mobile;

  final int? roleId;
  final String? roleName;

  final int? inProgressCount;
  final int? completedCount;
  final int? rejectedCount;

  final int? lastRequestId;
  final String? lastStatus;
  final DateTime? lastHandledAt;

  EmployeeSummary({
    this.userId,
    this.employeeName,
    this.email,
    this.mobile,
    this.roleId,
    this.roleName,
    this.inProgressCount,
    this.completedCount,
    this.rejectedCount,
    this.lastRequestId,
    this.lastStatus,
    this.lastHandledAt,
    // this.employeeArabicName,
  });

  factory EmployeeSummary.fromJson(Map<String, dynamic> json) {
    return EmployeeSummary(
      userId: json['user_id'] as int?,
      employeeName: json['employee_name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      roleId: json['role_id'] as int?,
      roleName: json['role_name'] as String?,
      inProgressCount: json['in_progress_count'] as int?,
      completedCount: json['completed_count'] as int?,
      rejectedCount: json['rejected_count'] as int?,
      lastRequestId: json['last_request_id'] as int?,
      lastStatus: json['last_status'] as String?,
      lastHandledAt: json['last_handled_at'] != null
          ? DateTime.tryParse(json['last_handled_at'])
          : null,
      // employeeArabicName: json['employee_arabic_name'] as String?,
    );
  }
}
