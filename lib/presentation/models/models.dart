class DepartmentResponse {
  final String? status;
  final List<Department>? data;
  final int? totalUsers;

  DepartmentResponse({this.status, this.data, this.totalUsers});

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalUsers: json['total_users'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
      'total_users': totalUsers,
    };
  }
}

class Department {
  final int? departmentId;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final int? userCount;

  Department({
    this.departmentId,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.userCount,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      departmentId: json['department_id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
      departmentDescription: json['department_description'] as String?,
      userCount: json['user_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'department_id': departmentId,
      'department_name': departmentName,
      'department_code': departmentCode,
      'department_description': departmentDescription,
      'user_count': userCount,
    };
  }
}

//--------------------------------------------------------------------------------------------------
class DepartmentListResponse {
  final String? status;
  final List<DepartmentData>? data;

  DepartmentListResponse({this.status, this.data});

  factory DepartmentListResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentListResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DepartmentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class DepartmentData {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? createdAt;
  final String? updatedAt;

  DepartmentData({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory DepartmentData.fromJson(Map<String, dynamic> json) {
    return DepartmentData(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
      departmentDescription: json['department_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'department_name': departmentName,
      'department_code': departmentCode,
      'department_description': departmentDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

//--------------------------------------------------------------------------------------------------
