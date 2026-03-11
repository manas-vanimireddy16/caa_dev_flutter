class GradeResponse {
  final String? status;
  final List<Grade>? data;
  final int? total;

  const GradeResponse({this.status, this.data, this.total});

  factory GradeResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const GradeResponse();
    }

    return GradeResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map((e) => Grade.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'total': total,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Grade {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final int? financialGrade;
  final String? dailyAllowance;
  final String? travelClass;
  final String? currency;
  final bool? isActive;
  final int? createdBy;
  final String? createdAt; // ✅ String instead of DateTime
  final int? updatedBy;
  final String? updatedAt; // ✅ String instead of DateTime

  const Grade({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.financialGrade,
    this.dailyAllowance,
    this.travelClass,
    this.currency,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Grade.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const Grade();
    }

    return Grade(
      jsonIgnore: (json['jsonIgnore'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      financialGrade: json['financial_grade'] as int?,
      dailyAllowance: json['daily_allowance']?.toString(),
      travelClass: json['travel_class'] as String?,
      currency: json['currency'] as String?,
      isActive: json['is_active'] as bool?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at']?.toString(),
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'jsonIgnore': jsonIgnore,
    'is_deleted': isDeleted,
    'id': id,
    'financial_grade': financialGrade,
    'daily_allowance': dailyAllowance,
    'travel_class': travelClass,
    'currency': currency,
    'is_active': isActive,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}
