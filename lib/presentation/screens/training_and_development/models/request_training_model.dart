import 'package:code_setup/presentation/models/base_request_model.dart';

class RequestTrainingModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ TRAINING REQUEST FIELDS
  final int? userId;

  final String? typeOfTraining;
  final String? description;

  final String? place;

  final String? courseName;
  final int? courseId;

  final List<AttendeeModel>? nameOfAttendeesSelection;

  final int? noOfAttendees;

  final String? mediaCoverageRequired;

  final String? status;

  final int? serviceId;
  final int? subServiceId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;

  final String? typeOfCategory;

  final String? startDate;
  final String? endDate;

  const RequestTrainingModel({
    this.base,
    this.userId,
    this.typeOfTraining,
    this.description,
    this.place,
    this.courseName,
    this.courseId,
    this.nameOfAttendeesSelection,
    this.noOfAttendees,
    this.mediaCoverageRequired,
    this.status,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqUserPositionId,
    this.typeOfCategory,
    this.startDate,
    this.endDate,
  });

  /// ================= FROM JSON =================
  factory RequestTrainingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestTrainingModel();
    }

    return RequestTrainingModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      /// ⭐ USER
      userId: json['user_id'],

      /// ⭐ TRAINING INFO
      typeOfTraining: json['type_of_training'],

      description: json['description'],

      place: json['place'],

      courseName: json['course_name'],

      courseId: json['course_id'],

      /// ⭐ ATTENDEES
      nameOfAttendeesSelection: (json['name_of_attendees_selection'] as List?)
          ?.map((e) => AttendeeModel.fromJson(e))
          .toList(),

      noOfAttendees: json['no_of_attendees'],

      /// ⭐ MEDIA
      mediaCoverageRequired: json['media_coverage_required'],

      /// ⭐ STATUS
      status: json['status'],

      /// ⭐ SERVICE
      serviceId: json['service_id'],

      subServiceId: json['sub_service_id'],

      /// ⭐ USER DETAILS
      reqUserDepartmentId: json['req_user_department_id'],

      reqUserSectionId: json['req_user_section_id'],

      reqUserPositionId: json['req_user_position_id'],

      /// ⭐ CATEGORY
      typeOfCategory: json['type_of_category'],

      /// ⭐ DATES
      startDate: json['start_date'],

      endDate: json['end_date'],
    );
  }
}

/// =======================================================
/// ⭐ ATTENDEE MODEL
/// =======================================================

class AttendeeModel {
  final int? userId;
  final String? name;

  const AttendeeModel({this.userId, this.name});

  factory AttendeeModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const AttendeeModel();
    }

    return AttendeeModel(userId: json['user_id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {"user_id": userId, "name": name};
  }
}
