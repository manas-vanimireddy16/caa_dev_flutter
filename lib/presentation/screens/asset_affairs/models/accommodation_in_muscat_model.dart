import 'package:code_setup/presentation/models/base_request_model.dart';

class AccommodationRequestResponse {
  final String? status;
  final List<AccommodationRequestModel>? data;
  final int? total;

  const AccommodationRequestResponse({this.status, this.data, this.total});

  factory AccommodationRequestResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const AccommodationRequestResponse();
    }

    return AccommodationRequestResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) =>
                AccommodationRequestModel.fromJson(e as Map<String, dynamic>?),
          )
          .toList(),
    );
  }
}

class AccommodationRequestModel {
  final BaseRequestModel? base;

  final int? durationOfDays;
  final String? travellingFromRegion;
  final String? travelFrom;
  final String? travelTo;
  final String? timeOfArrival;
  final String? startDateOfStay;
  final String? referenceNumber;
  final String? otherPurposeSpecification;
  final String? officialPurposeOfTravel;
  final int? numberOfEmployeesTravelling;
  final List<AccommodationEmployeeDetails>? employeeDetails;

  const AccommodationRequestModel({
    this.base,
    this.durationOfDays,
    this.travellingFromRegion,
    this.travelFrom,
    this.travelTo,
    this.timeOfArrival,
    this.startDateOfStay,
    this.referenceNumber,
    this.otherPurposeSpecification,
    this.officialPurposeOfTravel,
    this.numberOfEmployeesTravelling,
    this.employeeDetails,
  });

  factory AccommodationRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const AccommodationRequestModel();
    }

    return AccommodationRequestModel(
      base: BaseRequestModel.fromJson(json),
      durationOfDays: json['duration_of_days'] as int?,
      travellingFromRegion: json['travelling_from_region'] as String?,
      travelFrom: json['travel_from'] as String?,
      travelTo: json['travel_to'] as String?,
      timeOfArrival: json['time_of_arrival'] as String?,
      startDateOfStay: json['start_date_of_stay'] as String?,
      referenceNumber: json['reference_number'] as String?,
      otherPurposeSpecification: json['other_purpose_specification'] as String?,
      officialPurposeOfTravel: json['official_purpose_of_travel'] as String?,
      numberOfEmployeesTravelling:
          json['number_of_employees_travelling'] as int?,
      employeeDetails: (json['employee_details'] as List?)
          ?.map(
            (e) => AccommodationEmployeeDetails.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "duration_of_days": durationOfDays,
      "travelling_from_region": travellingFromRegion,
      "travel_from": travelFrom,
      "travel_to": travelTo,
      "time_of_arrival": timeOfArrival,
      "start_date_of_stay": startDateOfStay,
      "reference_number": referenceNumber,
      "other_purpose_specification": otherPurposeSpecification,
      "official_purpose_of_travel": officialPurposeOfTravel,
      "number_of_employees_travelling": numberOfEmployeesTravelling,
      "employee_details": employeeDetails?.map((e) => e.toJson()).toList(),
    };
  }
}

class AccommodationEmployeeDetails {
  final String? employeeId;
  final String? employeeName;
  final String? designation;
  final String? grade;
  final String? contactNumber;

  const AccommodationEmployeeDetails({
    this.employeeId,
    this.employeeName,
    this.designation,
    this.grade,
    this.contactNumber,
  });

  factory AccommodationEmployeeDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const AccommodationEmployeeDetails();
    }

    return AccommodationEmployeeDetails(
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      designation: json['designation'] as String?,
      grade: json['grade'] as String?,
      contactNumber: json['contact_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employee_id": employeeId,
      "employee_name": employeeName,
      "designation": designation,
      "grade": grade,
      "contact_number": contactNumber,
    };
  }
}
