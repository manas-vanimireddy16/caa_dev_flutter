import 'package:code_setup/presentation/models/base_request_model.dart';

class VehicleMaintenanceRequestModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ VEHICLE MAINTENANCE FIELDS
  final int? userId;
  final String? vehicleNumber;
  final String? typeOfMaintenanceRequired;
  final String? issueDescription;
  final String? preferredMaintenanceDate;
  final String? requestSubmissionDate;
  final String? status;

  const VehicleMaintenanceRequestModel({
    this.base,
    this.userId,
    this.vehicleNumber,
    this.typeOfMaintenanceRequired,
    this.issueDescription,
    this.preferredMaintenanceDate,
    this.requestSubmissionDate,
    this.status,
  });

  /// ================= FROM JSON =================
  factory VehicleMaintenanceRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const VehicleMaintenanceRequestModel();
    }

    return VehicleMaintenanceRequestModel(
      base: BaseRequestModel.fromJson(json),

      userId: json['user_id'],

      vehicleNumber: json['vehicle_number'],

      typeOfMaintenanceRequired: json['type_of_maintenance_required'],

      issueDescription: json['issue_description'],

      preferredMaintenanceDate: json['preferred_maintenance_date'],

      requestSubmissionDate: json['request_submission_date'],

      status: json['status'],
    );
  }
}
