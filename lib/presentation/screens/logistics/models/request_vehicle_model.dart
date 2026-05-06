import 'package:code_setup/presentation/models/base_request_model.dart';

class LogisticsVehicleRequestModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ VEHICLE REQUEST FIELDS
  final String? category;
  final String? vehicleRequiredFor;
  final String? vehicleRequiredLocation;
  final String? title;
  final String? purposeOfTravel;
  final String? typeOfVehicleRequired;
  final String? typeOfRequest;
  final String? dateOfTravel;
  final String? timeOfTravel;
  final String? description;
  final String? status;
  final String? otherVehicleRequiredFor;

  const LogisticsVehicleRequestModel({
    this.base,
    this.category,
    this.vehicleRequiredFor,
    this.vehicleRequiredLocation,
    this.title,
    this.purposeOfTravel,
    this.typeOfVehicleRequired,
    this.typeOfRequest,
    this.dateOfTravel,
    this.timeOfTravel,
    this.description,
    this.status,
    this.otherVehicleRequiredFor,
  });

  /// ================= FROM JSON =================
  factory LogisticsVehicleRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const LogisticsVehicleRequestModel();
    }

    return LogisticsVehicleRequestModel(
      base: BaseRequestModel.fromJson(json),

      category: json['category'],
      vehicleRequiredFor: json['vehicle_required_for'],
      vehicleRequiredLocation: json['vehicle_required_location'],
      title: json['title'],
      purposeOfTravel: json['purpose_of_travel'],
      typeOfVehicleRequired: json['type_of_vehicle_required'],
      typeOfRequest: json['type_of_request'],
      dateOfTravel: json['date_of_travel'],
      timeOfTravel: json['time_of_travel'],
      description: json['description'],
      status: json['status'],
      otherVehicleRequiredFor: json['other_vehicle_required_for'],
    );
  }
}
