class NationalityResponseModel {
  final String? status;
  final List<NationalityData>? data;
  final int? total;

  NationalityResponseModel({this.status, this.data, this.total});

  factory NationalityResponseModel.fromJson(Map<String, dynamic> json) {
    return NationalityResponseModel(
      status: json['status'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => NationalityData.fromJson(e))
                .toList()
          : [],
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}

class NationalityData {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? nationalityName;
  final bool? isActive;
  final int? displayOrder;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final String? nationalityNameArabic;
  final String? countryCode;
  final String? description;

  NationalityData({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.nationalityName,
    this.isActive,
    this.displayOrder,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.nationalityNameArabic,
    this.countryCode,
    this.description,
  });

  factory NationalityData.fromJson(Map<String, dynamic> json) {
    return NationalityData(
      jsonIgnore: json['jsonIgnore'] != null
          ? List<String>.from(json['jsonIgnore'])
          : [],
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      nationalityName: json['nationality_name'] as String?,
      isActive: json['is_active'] as bool?,
      displayOrder: json['display_order'] as int?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
      nationalityNameArabic: json['nationality_name_arabic'] as String?,
      countryCode: json['country_code'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonIgnore': jsonIgnore,
      'is_deleted': isDeleted,
      'id': id,
      'nationality_name': nationalityName,
      'is_active': isActive,
      'display_order': displayOrder,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'nationality_name_arabic': nationalityNameArabic,
      'country_code': countryCode,
      'description': description,
    };
  }
}
