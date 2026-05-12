import 'package:code_setup/presentation/models/base_request_model.dart';

class RequestStudyLeaveModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ USER
  final int? userId;

  /// ⭐ COURSE INFO
  final String? courseName;
  final String? instituteName;

  /// ⭐ DATES
  final String? courseStartDate;
  final String? courseEndDate;

  /// ⭐ LOCATION
  final String? location;

  /// ⭐ DESCRIPTION
  final String? description;

  /// ⭐ STATUS
  final String? status;

  /// ⭐ SERVICE
  final int? serviceId;
  final int? subServiceId;

  /// ⭐ REQUEST USER INFO
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;

  /// ⭐ COURSE DURATION
  final String? durationOfCourse;

  /// ⭐ WORKFLOW
  final int? reviewerUserId;
  final int? assignedToUserId;

  final String? assignedAt;
  final String? workflowExecutionId;

  /// ⭐ MINISTRY
  final bool? alreadySubmittedInMinistryOfEducationSystem;

  /// ⭐ LOCATION DETAILS
  final String? areaName;
  final String? countryName;

  /// ⭐ QUALIFICATION
  final String? qualificationRequired;

  /// ⭐ AUTHORITY
  final bool? haveYouEverReceivedAuthority;

  const RequestStudyLeaveModel({
    this.base,
    this.userId,
    this.courseName,
    this.instituteName,
    this.courseStartDate,
    this.courseEndDate,
    this.location,
    this.description,
    this.status,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqUserPositionId,
    this.durationOfCourse,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
    this.workflowExecutionId,
    this.alreadySubmittedInMinistryOfEducationSystem,
    this.areaName,
    this.countryName,
    this.qualificationRequired,
    this.haveYouEverReceivedAuthority,
  });

  /// ================= FROM JSON =================
  factory RequestStudyLeaveModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestStudyLeaveModel();
    }

    return RequestStudyLeaveModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      /// ⭐ USER
      userId: json['user_id'],

      /// ⭐ COURSE INFO
      courseName: json['course_name'],

      instituteName: json['institute_name'],

      /// ⭐ DATES
      courseStartDate: json['course_start_date'],

      courseEndDate: json['course_end_date'],

      /// ⭐ LOCATION
      location: json['location'],

      /// ⭐ DESCRIPTION
      description: json['description'],

      /// ⭐ STATUS
      status: json['status'],

      /// ⭐ SERVICE
      serviceId: json['service_id'],

      subServiceId: json['sub_service_id'],

      /// ⭐ REQUEST USER INFO
      reqUserDepartmentId: json['req_user_department_id'],

      reqUserSectionId: json['req_user_section_id'],

      reqUserPositionId: json['req_user_position_id'],

      /// ⭐ DURATION
      durationOfCourse: json['duration_of_course'],

      /// ⭐ WORKFLOW
      reviewerUserId: json['reviewer_user_id'],

      assignedToUserId: json['assigned_to_user_id'],

      assignedAt: json['assigned_at'],

      workflowExecutionId: json['workflow_execution_id'],

      /// ⭐ MINISTRY
      alreadySubmittedInMinistryOfEducationSystem:
          json['already_submitted_in_ministry_of_education_system'],

      /// ⭐ LOCATION DETAILS
      areaName: json['area_name'],

      countryName: json['country_name'],

      /// ⭐ QUALIFICATION
      qualificationRequired: json['qualification_required'],

      /// ⭐ AUTHORITY
      haveYouEverReceivedAuthority: json['have_you_ever_received_authority'],
    );
  }
}
