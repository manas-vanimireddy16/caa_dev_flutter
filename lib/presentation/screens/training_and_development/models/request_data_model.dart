import 'package:code_setup/presentation/models/base_request_model.dart';

class TrainingandDevelopmentRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final bool? isDeleted;
  final int? userId;
  final String? status;

  final String? purposeOfTraining;
  final String? dateOfEvent;
  final String? endDateOfEvent;
  final String? startTime;
  final String? endTime;
  final String? roomType;
  final int? numberOfAttendees;
  final bool? networkSupportRequired;
  final bool? mealsRequired;

  final int? serviceId;
  final int? subServiceId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final dynamic reqUserPositionId;

  final String? remarks;
  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedAt;
  final String? workflowExecutionId;

  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? courseName;
  final int? noOfParticipants;
  final String? courseCost;
  final String? totalCost;
  final String? description;
  final String? place;
  final String? reason;
  final String? location;
  final String? proposedImplementationDate;

  // final List<dynamic>? employeeList;

  final String? typeOfTraining;
  final String? typeOfCategory;
  final String? startDate;
  final String? endDate;
  final int? noOfAttendees;
  final String? mediaCoverageRequired;

  final String? durationOfCourse;
  final String? instituteName;

  final int? courseId;
  final String? nameOfAttendeesSelection;
  final List<String>? nameOfParticipants;

  const TrainingandDevelopmentRequestModel({
    this.base,
    this.id,
    this.isDeleted,
    this.userId,
    this.status,
    this.purposeOfTraining,
    this.dateOfEvent,
    this.endDateOfEvent,
    this.startTime,
    this.endTime,
    this.roomType,
    this.numberOfAttendees,
    this.networkSupportRequired,
    this.mealsRequired,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqUserPositionId,
    this.remarks,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
    this.workflowExecutionId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.courseName,
    this.noOfParticipants,
    this.courseCost,
    this.totalCost,
    this.description,
    this.place,
    this.reason,
    this.location,
    this.proposedImplementationDate,
    // this.employeeList,
    this.typeOfTraining,
    this.typeOfCategory,
    this.startDate,
    this.endDate,
    this.noOfAttendees,
    this.mediaCoverageRequired,
    this.durationOfCourse,
    this.instituteName,
    this.courseId,
    this.nameOfAttendeesSelection,
    this.nameOfParticipants,
  });

  static Map<String, dynamic> _resolveSource(Map<String, dynamic> json) {
    final source = Map<String, dynamic>.from(json);

    if (json['request'] is Map) {
      source.addAll(Map<String, dynamic>.from(json['request'] as Map));
    }
    if (json['base'] is Map) {
      source.addAll(Map<String, dynamic>.from(json['base'] as Map));
    }

    return source;
  }

  factory TrainingandDevelopmentRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return const TrainingandDevelopmentRequestModel();
    }

    final source = _resolveSource(json);

    return TrainingandDevelopmentRequestModel(
      base: BaseRequestModel.fromJson(source),

      id: source['id'],
      isDeleted: source['is_deleted'],
      userId: source['user_id'],
      status: source['status'],

      purposeOfTraining: source['purpose_of_training'],
      dateOfEvent: source['date_of_event'],
      endDateOfEvent: source['end_date_of_event'],
      startTime: source['start_time'],
      endTime: source['end_time'],
      roomType: source['room_type'],
      numberOfAttendees: source['number_of_attendees'],
      networkSupportRequired: source['network_support_required'],
      mealsRequired: source['meals_required'],

      serviceId: source['service_id'],
      subServiceId: source['sub_service_id'],

      reqUserDepartmentId: source['req_user_department_id'],
      reqUserSectionId: source['req_user_section_id'],
      reqUserPositionId: source['req_user_position_id'],

      remarks: source['remarks'],
      reviewerUserId: source['reviewer_user_id'],
      assignedToUserId: source['assigned_to_user_id'],
      assignedAt: source['assigned_at'],
      workflowExecutionId: source['workflow_execution_id'],

      createdBy: source['created_by'],
      updatedBy: source['updated_by'],

      createdAt: source['created_at'] != null
          ? DateTime.tryParse(source['created_at'].toString())
          : null,

      updatedAt: source['updated_at'] != null
          ? DateTime.tryParse(source['updated_at'].toString())
          : null,

      courseName: source['course_name'],
      noOfParticipants: source['no_of_participants'],
      courseCost: source['course_cost'],
      totalCost: source['total_cost'],
      description: source['description'],
      place: source['place'],
      reason: source['reason'],
      location: source['location'],
      proposedImplementationDate: source['proposed_implementation_date'],

      typeOfTraining: source['type_of_training'],
      typeOfCategory: source['type_of_category'],
      startDate: source['start_date'],
      endDate: source['end_date'],
      noOfAttendees: source['no_of_attendees'],
      mediaCoverageRequired: source['media_coverage_required'],

      durationOfCourse: source['duration_of_course'],
      instituteName: source['institute_name'],

      courseId: source['course_id'],

      nameOfAttendeesSelection: source['name_of_attendees_selection'],
      nameOfParticipants: (source['name_of_participants'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "base": base?.toJson(),
      "id": id,
      "is_deleted": isDeleted,
      "user_id": userId,
      "status": status,

      "purpose_of_training": purposeOfTraining,
      "date_of_event": dateOfEvent,
      "end_date_of_event": endDateOfEvent,
      "start_time": startTime,
      "end_time": endTime,
      "room_type": roomType,
      "number_of_attendees": numberOfAttendees,
      "network_support_required": networkSupportRequired,
      "meals_required": mealsRequired,

      "service_id": serviceId,
      "sub_service_id": subServiceId,

      "req_user_department_id": reqUserDepartmentId,

      "req_user_section_id": reqUserSectionId,

      "req_user_position_id": reqUserPositionId,

      "remarks": remarks,
      "reviewer_user_id": reviewerUserId,
      "assigned_to_user_id": assignedToUserId,
      "assigned_at": assignedAt,
      "workflow_execution_id": workflowExecutionId,

      "created_by": createdBy,
      "updated_by": updatedBy,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),

      "course_name": courseName,
      "no_of_participants": noOfParticipants,
      "course_cost": courseCost,
      "total_cost": totalCost,
      "description": description,
      "place": place,
      "reason": reason,
      "location": location,

      // "employee_list": employeeList,
      "proposed_implementation_date": proposedImplementationDate,

      "type_of_training": typeOfTraining,
      "type_of_category": typeOfCategory,
      "start_date": startDate,
      "end_date": endDate,
      "no_of_attendees": noOfAttendees,

      "media_coverage_required": mediaCoverageRequired,

      "duration_of_course": durationOfCourse,

      "institute_name": instituteName,

      "course_id": courseId,

      "name_of_attendees_selection": nameOfAttendeesSelection,
    };
  }
}
