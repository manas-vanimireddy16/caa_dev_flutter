import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/models/base_request_model.dart';

class DashboardRequestModel {
  final BaseRequestModel? base;
  final bool? isDeleted;
  final int? id;
  final String? requestId;
  final Service? service;
  final SubService? subService;
  final String? subServiceCode;

  DashboardRequestModel({
    this.base,
    this.isDeleted,
    this.id,
    this.requestId,
    this.service,
    this.subService,
    this.subServiceCode,
  });

  factory DashboardRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DashboardRequestModel();
    }

    final serviceJson = json['service'] is Map<String, dynamic>
        ? json['service'] as Map<String, dynamic>
        : null;
    final subServiceJson = json['sub_service'] is Map<String, dynamic>
        ? json['sub_service'] as Map<String, dynamic>
        : null;

    return DashboardRequestModel(
      base: BaseRequestModel.fromJson(json),
      isDeleted: json['is_deleted'],
      id: json['id'],
      requestId: json['request_id']?.toString(),
      service: serviceJson != null
          ? Service.fromJson(serviceJson)
          : Service(id: json['service_id'] ?? json['serviceId']),
      subService: subServiceJson != null
          ? SubService.fromJson(subServiceJson)
          : SubService(
              id: json['sub_service_id'] ?? json['subServiceId'],
              code:
                  json['sub_service_code']?.toString() ??
                  json['subServiceCode']?.toString(),
            ),
      subServiceCode:
          json['sub_service_code']?.toString() ??
          json['subServiceCode']?.toString() ??
          subServiceJson?['code']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_deleted': isDeleted,
      'id': id,
      'request_id': requestId,
      'service': service?.toJson(),
      'sub_service': subService?.toJson(),
      'sub_service_code': subServiceCode,
    };
  }
}
