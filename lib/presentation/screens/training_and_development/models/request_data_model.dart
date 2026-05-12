import 'package:code_setup/presentation/models/base_request_model.dart';

class TrainingandDevelopmentRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final bool? isDeleted;
  final int? userId;
  final String? status;

  final String? purposeOfTraining;
  final String? dateOfEvent;
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

  const TrainingandDevelopmentRequestModel({
    this.base,
    this.id,
    this.isDeleted,
    this.userId,
    this.status,
    this.purposeOfTraining,
    this.dateOfEvent,
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
  });

  factory TrainingandDevelopmentRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return const TrainingandDevelopmentRequestModel();
    }

    return TrainingandDevelopmentRequestModel(
      base: json['base'] != null
          ? BaseRequestModel.fromJson(json['base'])
          : null,

      id: json['id'],
      isDeleted: json['is_deleted'],
      userId: json['user_id'],
      status: json['status'],

      purposeOfTraining: json['purpose_of_training'],
      dateOfEvent: json['date_of_event'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      roomType: json['room_type'],
      numberOfAttendees: json['number_of_attendees'],
      networkSupportRequired: json['network_support_required'],
      mealsRequired: json['meals_required'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],

      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      reqUserPositionId: json['req_user_position_id'],

      remarks: json['remarks'],
      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedAt: json['assigned_at'],
      workflowExecutionId: json['workflow_execution_id'],

      createdBy: json['created_by'],
      updatedBy: json['updated_by'],

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,

      courseName: json['course_name'],
      noOfParticipants: json['no_of_participants'],
      courseCost: json['course_cost'],
      totalCost: json['total_cost'],
      description: json['description'],
      place: json['place'],
      reason: json['reason'],
      location: json['location'],
      // employeeList: json['employee_list'],
      proposedImplementationDate: json['proposed_implementation_date'],

      typeOfTraining: json['type_of_training'],
      typeOfCategory: json['type_of_category'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      noOfAttendees: json['no_of_attendees'],
      mediaCoverageRequired: json['media_coverage_required'],

      durationOfCourse: json['duration_of_course'],
      instituteName: json['institute_name'],

      courseId: json['course_id'],

      nameOfAttendeesSelection: json['name_of_attendees_selection'],
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
