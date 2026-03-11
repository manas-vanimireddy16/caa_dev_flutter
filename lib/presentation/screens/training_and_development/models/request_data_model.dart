import 'package:code_setup/presentation/models/details_models.dart';

/// ─────────────────────────────
/// RESPONSE MODEL
/// ─────────────────────────────
class TrainingandDevelopmentResponse {
  final String? status;
  final List<TrainingandDevelopmentRequestModel> data;
  final int? totalCount;

  const TrainingandDevelopmentResponse({
    this.status,
    required this.data,
    this.totalCount,
  });

  factory TrainingandDevelopmentResponse.fromJson(Map<String, dynamic> json) {
    return TrainingandDevelopmentResponse(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List? ?? [])
          .map(
            (e) => TrainingandDevelopmentRequestModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

class TrainingandDevelopmentRequestModel {
  /// ─────────────────────────────
  /// BASIC INFO
  /// ─────────────────────────────
  final int? id;
  final bool? isDeleted;
  final int? userId;
  final String? status;

  /// ─────────────────────────────
  /// TRAINING ROOM FIELDS
  /// ─────────────────────────────
  final String? purposeOfTraining;
  final String? dateOfEvent;
  final String? startTime;
  final String? endTime;
  final String? roomType;
  final int? numberOfAttendees;
  final bool? networkSupportRequired;
  final bool? mealsRequired;

  /// ─────────────────────────────
  /// SERVICE INFO
  /// ─────────────────────────────
  final int? serviceId;
  final int? subServiceId;

  /// ─────────────────────────────
  /// REQUEST USER INFO
  /// ─────────────────────────────
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;

  /// ─────────────────────────────
  /// WORKFLOW / ASSIGNMENT
  /// ─────────────────────────────
  final String? remarks;
  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedAt;
  final String? workflowExecutionId;

  /// ─────────────────────────────
  /// AUDIT
  /// ─────────────────────────────
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// ─────────────────────────────
  /// NESTED OBJECTS
  /// ─────────────────────────────
  final UserModel? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final ServiceModel? service;
  final SubServiceModel? subService;

  /// ─────────────────────────────
  /// TRAINING DETAILS (MISSING FIELDS ADDED)
  /// ─────────────────────────────
  final String? courseName;
  final int? noOfParticipants;
  final String? courseCost;
  final String? totalCost;
  final String? description;
  final String? place;
  final String? reason;
  final String? location;
  final String? proposedImplementationDate;
  final List<dynamic>? employeeList;

  /// ─────────────────────────────
  /// COMMUNICATION & WORKFLOW
  /// ─────────────────────────────
  final List<ChatMessageModel>? chatMessages;
  final List<AttachmentModel>? attachments;
  final List<WorkflowDetailModel>? workflowLogs;
  final List<ApprovalDetailModel>? approvalDetails;

  /// ─────────────────────────────
  /// TRAINING REQUEST (CAA015) FIELDS
  /// ─────────────────────────────
  final String? typeOfTraining;
  final String? typeOfCategory;
  final String? startDate;
  final String? endDate;
  final int? noOfAttendees;
  final String? mediaCoverageRequired;

  final String? durationOfCourse;
  final String? instituteName;

  const TrainingandDevelopmentRequestModel({
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
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
    this.chatMessages,
    this.attachments,
    this.workflowLogs,
    this.approvalDetails,
    this.courseName,
    this.noOfParticipants,
    this.courseCost,
    this.totalCost,
    this.description,
    this.place,
    this.reason,
    this.location,
    this.proposedImplementationDate,
    this.employeeList,
    this.typeOfTraining,
    this.typeOfCategory,
    this.startDate,
    this.endDate,
    this.noOfAttendees,
    this.mediaCoverageRequired,
    this.durationOfCourse,
    this.instituteName,
  });

  factory TrainingandDevelopmentRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) return const TrainingandDevelopmentRequestModel();

    return TrainingandDevelopmentRequestModel(
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

      createdByUser: json['created_by_user'] != null
          ? UserModel.fromJson(json['created_by_user'])
          : null,

      reqDepartment: json['req_department'] != null
          ? DepartmentModel.fromJson(json['req_department'])
          : null,

      reqSection: json['req_section'] != null
          ? SectionModel.fromJson(json['req_section'])
          : null,

      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,

      subService: json['sub_service'] != null
          ? SubServiceModel.fromJson(json['sub_service'])
          : null,

      chatMessages: (json['chat_messages'] as List?)
          ?.map((e) => ChatMessageModel.fromJson(e))
          .toList(),

      attachments: (json['attachments'] as List?)
          ?.map((e) => AttachmentModel.fromJson(e))
          .toList(),

      workflowLogs: (json['workflow_logs'] as List?)
          ?.map((e) => WorkflowDetailModel.fromJson(e))
          .toList(),

      approvalDetails: (json['approval_details'] as List?)
          ?.map((e) => ApprovalDetailModel.fromJson(e))
          .toList(),
      courseName: json['course_name'],
      noOfParticipants: json['no_of_participants'],
      courseCost: json['course_cost'],
      totalCost: json['total_cost'],
      description: json['description'],
      place: json['place'],
      reason: json['reason'],
      location: json['location'],
      employeeList: json['employee_list'],
      proposedImplementationDate: json['proposed_implementation_date'],
      typeOfTraining: json['type_of_training'],
      typeOfCategory: json['type_of_category'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      noOfAttendees: json['no_of_attendees'],
      mediaCoverageRequired: json['media_coverage_required'],
      durationOfCourse: json['duration_of_course'],
      instituteName: json['institute_name'],
    );
  }
}
