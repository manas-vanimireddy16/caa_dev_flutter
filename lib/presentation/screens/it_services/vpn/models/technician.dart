import 'dart:convert';

TechniciansResponse techniciansResponseFromJson(String str) =>
    TechniciansResponse.fromJson(json.decode(str));

String techniciansResponseToJson(TechniciansResponse data) =>
    json.encode(data.toJson());

class TechniciansResponse {
  final String? status;
  final String? message;
  final List<Technician>? data;

  TechniciansResponse({this.status, this.message, this.data});

  factory TechniciansResponse.fromJson(Map<String, dynamic> json) =>
      TechniciansResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? []
            : List<Technician>.from(
                (json['data'] as List<dynamic>).map(
                  (x) => Technician.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Technician {
  final int? userId;
  final String? employeeName;
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

  Technician({
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
  });

  factory Technician.fromJson(Map<String, dynamic> json) => Technician(
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
    lastHandledAt: json['last_handled_at'] == null
        ? null
        : DateTime.tryParse(json['last_handled_at']),
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'employee_name': employeeName,
    'email': email,
    'mobile': mobile,
    'role_id': roleId,
    'role_name': roleName,
    'in_progress_count': inProgressCount,
    'completed_count': completedCount,
    'rejected_count': rejectedCount,
    'last_request_id': lastRequestId,
    'last_status': lastStatus,
    'last_handled_at': lastHandledAt?.toIso8601String(),
  };
}
