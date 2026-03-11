class ServiceResponse {
  final String? status;
  final List<ServiceData>? data;
  final int? count;
  final Filters? filters;

  ServiceResponse({this.status, this.data, this.count, this.filters});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      status: json['status'],
      data: json['data'] != null
          ? List<ServiceData>.from(
              json['data'].map((x) => ServiceData.fromJson(x)),
            )
          : null,
      count: json['count'],
      filters: json['filters'] != null
          ? Filters.fromJson(json['filters'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data != null ? data!.map((x) => x.toJson()).toList() : null,
      'count': count,
      'filters': filters?.toJson(),
    };
  }
}

class ServiceData {
  final int? id;
  final String? name;
  final String? nameInArabic;
  final int? serviceId;
  final int? subServiceId;
  final String? description;
  final bool? isActive;
  final Service? service;
  final SubService? subService;

  ServiceData({
    this.id,
    this.name,
    this.nameInArabic,
    this.serviceId,
    this.subServiceId,
    this.description,
    this.isActive,
    this.service,
    this.subService,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'],
      name: json['name'],
      nameInArabic: json['name_in_arabic'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      description: json['description'],
      isActive: json['is_active'],
      service: json['service'] != null
          ? Service.fromJson(json['service'])
          : null,
      subService: json['sub_service'] != null
          ? SubService.fromJson(json['sub_service'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_in_arabic': nameInArabic,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'description': description,
      'is_active': isActive,
      'service': service?.toJson(),
      'sub_service': subService?.toJson(),
    };
  }
}

class Service {
  final int? id;
  final String? name;
  final String? code;

  Service({this.id, this.name, this.code});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(id: json['id'], name: json['name'], code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }
}

class SubService {
  final int? id;
  final String? subServiceName;
  final String? code;

  SubService({this.id, this.subServiceName, this.code});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      subServiceName: json['sub_service_name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'sub_service_name': subServiceName, 'code': code};
  }
}

class Filters {
  final int? serviceId;
  final int? subServiceId;

  Filters({this.serviceId, this.subServiceId});

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'service_id': serviceId, 'sub_service_id': subServiceId};
  }
}
