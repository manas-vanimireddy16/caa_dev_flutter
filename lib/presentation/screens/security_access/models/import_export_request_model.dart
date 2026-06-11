import 'package:code_setup/presentation/models/base_request_model.dart';

class ImportExportMaterialModel {
  final BaseRequestModel? base;

  final int? id;
  final int? userId;

  final String? requestDate;
  final String? requestType;

  final String? materialMovementDate;
  final String? hazardousDetails;
  final String? purpose;
  final String? materialDescription;
  final String? transportMode;
  final String? vehicleNumber;
  final String? description;
  final String? referenceNumber;

  final String? status;

  ImportExportMaterialModel({
    this.base,
    this.id,
    this.userId,
    this.requestDate,
    this.requestType,
    this.materialMovementDate,
    this.hazardousDetails,
    this.purpose,
    this.materialDescription,
    this.transportMode,
    this.vehicleNumber,
    this.description,
    this.referenceNumber,
    this.status,
  });

  factory ImportExportMaterialModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ImportExportMaterialModel();
    }

    return ImportExportMaterialModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      id: json['id'],
      userId: json['user_id'],

      requestDate: json['request_date'],
      requestType: json['request_type'],

      materialMovementDate: json['material_movement_date'],
      hazardousDetails: json['hazardous_details'],
      purpose: json['purpose'],
      materialDescription: json['material_description'],
      transportMode: json['transport_mode'],
      vehicleNumber: json['vehicle_number'],
      description: json['description'],
      referenceNumber: json['reference_number'],

      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,

      'request_date': requestDate,
      'request_type': requestType,

      'material_movement_date': materialMovementDate,
      'hazardous_details': hazardousDetails,
      'purpose': purpose,
      'material_description': materialDescription,
      'transport_mode': transportMode,
      'vehicle_number': vehicleNumber,
      'description': description,
      'reference_number': referenceNumber,

      'status': status,
    };
  }
}
