/// Response model for
/// `GET /v1/user-service/master/departments/by-dg-department/{departmentId}`
///
/// Each department belongs to a parent DG department (`dg_department`).
class RelevantDepartmentModel {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final String? departmentArabicName;
  final int? dgDepartmentId;
  final RelevantDepartmentModel? dgDepartment;

  const RelevantDepartmentModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.departmentArabicName,
    this.dgDepartmentId,
    this.dgDepartment,
  });

  factory RelevantDepartmentModel.fromJson(Map<String, dynamic> json) {
    return RelevantDepartmentModel(
      jsonIgnore: (json['jsonIgnore'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      departmentName: json['department_name']?.toString(),
      departmentCode: json['department_code']?.toString(),
      departmentDescription: json['department_description']?.toString(),
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at']?.toString(),
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at']?.toString(),
      departmentArabicName: json['department_arabic_name']?.toString(),
      dgDepartmentId: json['DG_department_id'] as int?,
      dgDepartment: json['dg_department'] is Map<String, dynamic>
          ? RelevantDepartmentModel.fromJson(
              json['dg_department'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'department_name': departmentName,
    'department_code': departmentCode,
    'department_description': departmentDescription,
    'department_arabic_name': departmentArabicName,
    'DG_department_id': dgDepartmentId,
    'dg_department': dgDepartment?.toJson(),
  };

  /// Localized display name (falls back to the English name when the Arabic
  /// name is missing).
  String displayName({required bool isArabic}) {
    final arabic = departmentArabicName?.trim() ?? '';
    if (isArabic && arabic.isNotEmpty) {
      return arabic;
    }
    return departmentName ?? '';
  }
}

/// Wrapper for the full API response envelope.
class RelevantDepartmentResponse {
  final String? status;
  final String? message;
  final List<RelevantDepartmentModel> data;
  final int? totalCount;
  final int? dgDepartmentId;

  const RelevantDepartmentResponse({
    this.status,
    this.message,
    this.data = const [],
    this.totalCount,
    this.dgDepartmentId,
  });

  factory RelevantDepartmentResponse.fromJson(Map<String, dynamic> json) {
    return RelevantDepartmentResponse(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      data: (json['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(RelevantDepartmentModel.fromJson)
          .toList(),
      totalCount: json['total_count'] as int?,
      dgDepartmentId: json['dg_department_id'] as int?,
    );
  }
}
