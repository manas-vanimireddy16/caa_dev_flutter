class CountryResponseModel {
  final String? status;
  final List<CountryModel>? data;
  final int? total;

  const CountryResponseModel({this.status, this.data, this.total});

  factory CountryResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CountryResponseModel();
    }

    return CountryResponseModel(
      status: json['status'],

      data: (json['data'] as List?)
          ?.map((e) => CountryModel.fromJson(e))
          .toList(),

      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,

      "data": data?.map((e) => e.toJson()).toList(),

      "total": total,
    };
  }
}

/// =======================================================
/// ⭐ COUNTRY MODEL
/// =======================================================

class CountryModel {
  final List<String>? jsonIgnore;

  final bool? isDeleted;

  final int? id;

  final String? countryName;

  final bool? isActive;

  final int? displayOrder;

  final int? createdBy;

  final String? createdAt;

  final int? updatedBy;

  final String? updatedAt;

  final String? countryNameArabic;

  final String? countryCode;

  final String? phoneCode;

  final String? description;

  const CountryModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.countryName,
    this.isActive,
    this.displayOrder,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.countryNameArabic,
    this.countryCode,
    this.phoneCode,
    this.description,
  });

  factory CountryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CountryModel();
    }

    return CountryModel(
      jsonIgnore: (json['jsonIgnore'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      isDeleted: json['is_deleted'],

      id: json['id'],

      countryName: json['country_name'],

      isActive: json['is_active'],

      displayOrder: json['display_order'],

      createdBy: json['created_by'],

      createdAt: json['created_at'],

      updatedBy: json['updated_by'],

      updatedAt: json['updated_at'],

      countryNameArabic: json['country_name_arabic'],

      countryCode: json['country_code'],

      phoneCode: json['phone_code'],

      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "jsonIgnore": jsonIgnore,

      "is_deleted": isDeleted,

      "id": id,

      "country_name": countryName,

      "is_active": isActive,

      "display_order": displayOrder,

      "created_by": createdBy,

      "created_at": createdAt,

      "updated_by": updatedBy,

      "updated_at": updatedAt,

      "country_name_arabic": countryNameArabic,

      "country_code": countryCode,

      "phone_code": phoneCode,

      "description": description,
    };
  }
}
