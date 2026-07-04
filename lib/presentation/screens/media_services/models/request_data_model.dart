import 'package:code_setup/presentation/models/details_models.dart';

/// ─────────────────────────────
/// RESPONSE MODEL
/// ─────────────────────────────
class MediaRequestResponse {
  final String? status;
  final List<MediaRequestModel> data;
  final int? totalCount;

  const MediaRequestResponse({
    this.status,
    required this.data,
    this.totalCount,
  });

  factory MediaRequestResponse.fromJson(Map<String, dynamic> json) {
    return MediaRequestResponse(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List? ?? [])
          .map((e) => MediaRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MediaRequestModel {
  final int? id;
  final bool? isDeleted;
  final int? userId;

  final String? eventDate;
  final String? eventTime;
  final String? eventLocation;
  final String? eventDetails;
  final String? importanceOfPublishing;
  final String? directorateName;
  final bool? requiredForPresident;
  final String? status;

  final int? serviceId;
  final int? subServiceId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;
  final int? departmentId;

  final String? extensionNumber;
  final String? suggestedPhotography;
  final String? newsSize;
  final String? eventObjective;
  final String? organizingEntity;
  final String? hostedPerson;
  final String? audience;
  final String? eventFromDate;
  final String? eventToDate;
  final String? eventName;
  final String? tags;

  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedAt;

  final String? workflowExecutionId;
  final String? rejectionReason;

  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final UserModel? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final DepartmentModel? department;
  final ServiceModel? service;
  final SubServiceModel? subService;

  final List<ChatMessageModel>? chatMessages;
  final List<AttachmentModel>? attachments;
  final List<WorkflowDetailModel>? workflowLogs;
  final List<ApprovalDetailModel>? approvalDetails;

  const MediaRequestModel({
    this.id,
    this.isDeleted,
    this.userId,
    this.eventDate,
    this.eventTime,
    this.eventLocation,
    this.eventDetails,
    this.importanceOfPublishing,
    this.directorateName,
    this.requiredForPresident,
    this.status,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqUserPositionId,
    this.departmentId,
    this.extensionNumber,
    this.suggestedPhotography,
    this.newsSize,
    this.eventObjective,
    this.organizingEntity,
    this.hostedPerson,
    this.audience,
    this.eventFromDate,
    this.eventToDate,
    this.eventName,
    this.tags,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
    this.workflowExecutionId,
    this.rejectionReason,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.department,
    this.service,
    this.subService,
    this.chatMessages,
    this.attachments,
    this.workflowLogs,
    this.approvalDetails,
  });

  factory MediaRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const MediaRequestModel();

    return MediaRequestModel(
      id: json['id'],
      isDeleted: json['is_deleted'],
      userId: json['user_id'],

      eventDate: json['event_date'],
      eventTime: json['event_time'],
      eventLocation: json['event_location'],
      eventDetails: json['event_details'],
      importanceOfPublishing: json['importance_of_publishing'],
      directorateName: json['directorate_name'],
      requiredForPresident: json['required_for_president'],
      status: json['status'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],

      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      reqUserPositionId: json['req_user_position_id'],
      departmentId: json['department_id'],

      extensionNumber: json['extension_number'],
      suggestedPhotography: json['suggested_photography'],
      newsSize: json['news_size'],
      eventObjective: json['event_objective'],
      organizingEntity: json['organizing_entity'],
      hostedPerson: json['hosted_person'],
      audience: json['audience'],
      eventFromDate: json['event_from_date'],
      eventToDate: json['event_to_date'],
      eventName: json['event_name'],
      tags: json['tags']?.toString(),

      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedAt: json['assigned_at'],

      workflowExecutionId: json['workflow_execution_id'],
      rejectionReason: json['rejection_reason'],

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

      department: json['department'] != null
          ? DepartmentModel.fromJson(json['department'])
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
    );
  }
}
