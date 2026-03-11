// department_model.dart

class DepartmentResponse {
  final String? status;
  final List<Department>? data;
  final int? totalCount;

  DepartmentResponse({this.status, this.data, this.totalCount});

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
      'total_count': totalCount,
    };
  }
}

class Department {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;

  Department({
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
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      jsonIgnore: (json['jsonIgnore'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
      departmentDescription: json['department_description'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonIgnore': jsonIgnore,
      'is_deleted': isDeleted,
      'id': id,
      'department_name': departmentName,
      'department_code': departmentCode,
      'department_description': departmentDescription,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_by': updatedBy,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
