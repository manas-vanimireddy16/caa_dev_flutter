class HallResponseModel {
  final String? status;
  final List<HallData>? data;

  HallResponseModel({this.status, this.data});

  factory HallResponseModel.fromJson(Map<String, dynamic> json) {
    return HallResponseModel(
      status: json['status'],
      data: json['data'] != null
          ? List<HallData>.from(json['data'].map((x) => HallData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((x) => x.toJson()).toList()};
  }
}

class HallData {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final String? name;
  final String? location;
  final int? departmentId;
  final String? locationNameInArabic;
  final String? hallNameInArabic;
  final String? hallType;

  HallData({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.name,
    this.location,
    this.departmentId,
    this.locationNameInArabic,
    this.hallNameInArabic,
    this.hallType,
  });

  factory HallData.fromJson(Map<String, dynamic> json) {
    return HallData(
      jsonIgnore: json['jsonIgnore'] != null
          ? List<String>.from(json['jsonIgnore'])
          : [],
      isDeleted: json['is_deleted'],
      id: json['id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      name: json['name'],
      location: json['location'],
      departmentId: json['department_id'],
      locationNameInArabic: json['location_name_in_arabic'],
      hallNameInArabic: json['hall_name_in_arabic'],
      hallType: json['hall_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonIgnore': jsonIgnore,
      'is_deleted': isDeleted,
      'id': id,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'name': name,
      'location': location,
      'department_id': departmentId,
      'location_name_in_arabic': locationNameInArabic,
      'hall_name_in_arabic': hallNameInArabic,
      'hall_type': hallType,
    };
  }
}
