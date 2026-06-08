import 'package:code_setup/presentation/models/base_request_model.dart';

class MaintenanceRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final int? userId;

  final String? category;
  final String? subCategory;

  final bool? emergencyMaintenanceSupport;

  final String? location;
  final String? reasonForMaintenance;
  final String? description;

  final String? ifStationSelected;
  final String? buildingSiteClassification;

  final String? status;

  MaintenanceRequestModel({
    this.base,
    this.id,
    this.userId,
    this.category,
    this.subCategory,
    this.emergencyMaintenanceSupport,
    this.location,
    this.reasonForMaintenance,
    this.description,
    this.ifStationSelected,
    this.buildingSiteClassification,
    this.status,
  });

  factory MaintenanceRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MaintenanceRequestModel();
    }

    return MaintenanceRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      id: json['id'],
      userId: json['user_id'],

      category: json['category'],
      subCategory: json['sub_category'],

      emergencyMaintenanceSupport: json['emergency_maintenance_support'],

      location: json['location'],
      reasonForMaintenance: json['reason_for_maintenance'],

      description: json['description'],

      ifStationSelected: json['if_station_selected'],

      buildingSiteClassification: json['building_site_classification'],

      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,

      'category': category,
      'sub_category': subCategory,

      'emergency_maintenance_support': emergencyMaintenanceSupport,

      'location': location,

      'reason_for_maintenance': reasonForMaintenance,

      'description': description,

      'if_station_selected': ifStationSelected,

      'building_site_classification': buildingSiteClassification,

      'status': status,
    };
  }
}
