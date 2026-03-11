// lib/repository/services/models/emodel.dart

class BookmarksmodelSubService {
  final int? id;
  final String? subServiceName;
  final String? description;
  final String? logoUrl;
  final String? code;
  final int? serviceId;

  BookmarksmodelSubService({
    this.id,
    this.subServiceName,
    this.description,
    this.logoUrl,
    this.code,
    this.serviceId,
  });

  factory BookmarksmodelSubService.fromJson(Map<String, dynamic> json) {
    return BookmarksmodelSubService(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? ''),
      subServiceName: json['sub_service_name']?.toString(),
      description: json['description']?.toString(),
      logoUrl: json['logo_url']?.toString(),
      code: json['code']?.toString(),
      serviceId: json['service_id'] is int
          ? json['service_id'] as int
          : int.tryParse(json['service_id']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_service_name': subServiceName,
    'description': description,
    'logo_url': logoUrl,
    'code': code,
    'service_id': serviceId,
  };
}

class Bookmarksmodel {
  final int? id;
  final String? userId;
  final String? serviceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? serviceTableId;
  final String? serviceName;
  final String? serviceDescription;
  final String? serviceLogoUrl;
  final String? serviceCode;
  final List<BookmarksmodelSubService>? subServices;

  Bookmarksmodel({
    this.id,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.serviceTableId,
    this.serviceName,
    this.serviceDescription,
    this.serviceLogoUrl,
    this.serviceCode,
    this.subServices,
  });

  factory Bookmarksmodel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic val) {
      try {
        if (val == null) return null;
        return DateTime.parse(val.toString());
      } catch (_) {
        return null;
      }
    }

    return Bookmarksmodel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? ''),
      userId: json['user_id']?.toString(),
      serviceId: json['service_id']?.toString(),
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      serviceTableId: json['service_table_id'] is int
          ? json['service_table_id'] as int
          : int.tryParse(json['service_table_id']?.toString() ?? ''),
      serviceName: json['service_name']?.toString(),
      serviceDescription: json['service_description']?.toString(),
      serviceLogoUrl: json['service_logo_url']?.toString(),
      serviceCode: json['service_code']?.toString(),
      subServices: (json['sub_services'] as List<dynamic>?)
          ?.map(
            (e) => BookmarksmodelSubService.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'service_id': serviceId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'service_table_id': serviceTableId,
    'service_name': serviceName,
    'service_description': serviceDescription,
    'service_logo_url': serviceLogoUrl,
    'service_code': serviceCode,
    'sub_services': subServices?.map((s) => s.toJson()).toList(),
  };
}
