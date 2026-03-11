class LocationListResponseModel {
  final String? status;
  final List<LocationModel>? data;
  final int? total;

  const LocationListResponseModel({this.status, this.data, this.total});

  factory LocationListResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LocationListResponseModel();

    return LocationListResponseModel(
      status: json['status'],
      total: json['total'],
      data: (json['data'] as List?)
          ?.map((e) => LocationModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total': total,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class LocationModel {
  final int? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final bool? isDeleted;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const LocationModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LocationModel();

    return LocationModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
