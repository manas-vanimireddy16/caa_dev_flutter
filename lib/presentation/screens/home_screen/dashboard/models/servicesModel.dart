class ServiceModel {
  final String? success;
  final List<Service>? data;

  ServiceModel({this.success, this.data});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class Service {
  final int? id;
  final String? name;
  final String? description;
  final String? logoUrl;
  final String? code;
  final int? createdBy;
  final int? updatedBy;
  final bool? isDeleted;
  final bool? logicalDelete;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SubService>? subServices;

  Service({
    this.id,
    this.name,
    this.description,
    this.logoUrl,
    this.code,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.logicalDelete,
    this.createdAt,
    this.updatedAt,
    this.subServices,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      isDeleted: json['is_deleted'] as bool?,
      logicalDelete: json['logicalDelete'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      subServices: (json['sub_services'] as List<dynamic>?)
          ?.map((e) => SubService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo_url': logoUrl,
      'code': code,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'is_deleted': isDeleted,
      'logicalDelete': logicalDelete,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'sub_services': subServices?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubService {
  final int? id;
  final String? subServiceName;
  final String? description;
  final int? serviceId;
  final String? logoUrl;
  final String? code;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubService({
    this.id,
    this.subServiceName,
    this.description,
    this.serviceId,
    this.logoUrl,
    this.code,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'] as int?,
      subServiceName: json['sub_service_name'] as String?,
      description: json['description'] as String?,
      serviceId: json['service_id'] as int?,
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sub_service_name': subServiceName,
      'description': description,
      'service_id': serviceId,
      'logo_url': logoUrl,
      'code': code,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
