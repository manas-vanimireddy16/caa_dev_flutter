import 'package:code_setup/presentation/models/base_request_model.dart';

class ForeignEmployeeVehicleRequestModel {
  final BaseRequestModel? base;

  final int? numberOfPassengers;

  final String? purposeOfTravel;
  final String? vehicleRequiredLocation;
  final String? employeeIdPassport;
  final String? contactNumber;
  final String? requestType;

  final String? vehicleNumber;
  final String? fuelCard;

  final String? expectedVehicleReturnTime;
  final String? expectedReturnDate;

  final String? actualVehicleReturnTime;
  final String? actualReturnDate;

  final String? vehicleCondition;
  final String? reason;

  final String? originCity;
  final String? destinationCity;

  final String? arrivalDepartureDatetime;
  final String? driverName;

  final String? specialInstructions;
  final String? status;
  final List<PassengerModel>? passengers;

  const ForeignEmployeeVehicleRequestModel({
    this.base,
    this.numberOfPassengers,
    this.purposeOfTravel,
    this.vehicleRequiredLocation,
    this.employeeIdPassport,
    this.contactNumber,
    this.requestType,
    this.vehicleNumber,
    this.fuelCard,
    this.expectedVehicleReturnTime,
    this.expectedReturnDate,
    this.actualVehicleReturnTime,
    this.actualReturnDate,
    this.vehicleCondition,
    this.reason,
    this.originCity,
    this.destinationCity,
    this.arrivalDepartureDatetime,
    this.driverName,
    this.specialInstructions,
    this.status,
    this.passengers,
  });

  /// ================= FROM JSON =================
  factory ForeignEmployeeVehicleRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return const ForeignEmployeeVehicleRequestModel();
    }

    return ForeignEmployeeVehicleRequestModel(
      base: BaseRequestModel.fromJson(json),

      numberOfPassengers: json['number_of_passengers'],

      purposeOfTravel: json['purpose_of_travel'],
      vehicleRequiredLocation: json['vehicle_required_location'],
      employeeIdPassport: json['employee_id_passport'],
      contactNumber: json['contact_number'],
      requestType: json['request_type'],

      vehicleNumber: json['vehicle_number'],
      fuelCard: json['fuel_card'],

      expectedVehicleReturnTime: json['expected_vehicle_return_time'],

      expectedReturnDate: json['expected_return_date'],

      actualVehicleReturnTime: json['actual_vehicle_return_time'],

      actualReturnDate: json['actual_return_date'],

      vehicleCondition: json['vehicle_condition'],

      reason: json['reason'],

      originCity: json['origin_city'],
      destinationCity: json['destination_city'],

      arrivalDepartureDatetime: json['arrival_departure_datetime'],

      driverName: json['driver_name'],

      specialInstructions: json['special_instructions'],
      passengers: (json['passengers'] as List?)
          ?.map((e) => PassengerModel.fromJson(e))
          .toList(),
      status: json['status'],
    );
  }
}

class PassengerModel {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final int? foreignVehicleRequestId;
  final String? passengerName;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  const PassengerModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.foreignVehicleRequestId,
    this.passengerName,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory PassengerModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const PassengerModel();
    }

    return PassengerModel(
      jsonIgnore: (json['jsonIgnore'] as List?)?.cast<String>(),
      isDeleted: json['is_deleted'],
      id: json['id'],
      foreignVehicleRequestId: json['foreign_vehicle_request_id'],
      passengerName: json['passenger_name'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }
}
