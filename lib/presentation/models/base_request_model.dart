import 'package:code_setup/presentation/models/details_models.dart';

class BaseRequestModel {
  final int? id;
  final bool? isDeleted;
  final int? userId;
  final String? status;

  /// Service Info
  final int? serviceId;
  final int? subServiceId;
  final ServiceModel? service;
  final SubServiceModel? subService;

  /// Department Info
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;

  /// Workflow
  final String? workflowExecutionId;
  final List<WorkflowDetailModel>? workflowLogs;
  final List<ApprovalDetailModel>? approvalDetails;

  /// Communication
  final List<ChatMessageModel>? chatMessages;
  final List<AttachmentModel>? attachments;

  /// Audit
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final UserModel? createdByUser;

  /// Assignment
  final int? reqUserPositionId;
  final int? reviewerUserId;
  final int? assignedToUserId;
  final DateTime? assignedAt;
  final dynamic assignedToRole;

  const BaseRequestModel({
    this.id,
    this.isDeleted,
    this.userId,
    this.status,
    this.serviceId,
    this.subServiceId,
    this.service,
    this.subService,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqDepartment,
    this.reqSection,
    this.workflowExecutionId,
    this.workflowLogs,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.createdByUser,
    this.reqUserPositionId,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
    this.assignedToRole,
  });

  factory BaseRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const BaseRequestModel();

    return BaseRequestModel(
      id: json['id'],
      isDeleted: json['is_deleted'],
      userId: json['user_id'],
      status: json['status'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,
      subService: json['sub_service'] != null
          ? SubServiceModel.fromJson(json['sub_service'])
          : null,

      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      reqDepartment: json['req_department'] != null
          ? DepartmentModel.fromJson(json['req_department'])
          : null,
      reqSection: json['req_section'] != null
          ? SectionModel.fromJson(json['req_section'])
          : null,

      workflowExecutionId: json['workflow_execution_id'],

      workflowLogs: (json['workflow_logs'] as List?)
          ?.map((e) => WorkflowDetailModel.fromJson(e))
          .toList(),

      approvalDetails: (json['approval_details'] as List?)
          ?.map((e) => ApprovalDetailModel.fromJson(e))
          .toList(),

      chatMessages: (json['chat_messages'] as List?)
          ?.map((e) => ChatMessageModel.fromJson(e))
          .toList(),

      attachments: (json['attachments'] as List?)
          ?.map((e) => AttachmentModel.fromJson(e))
          .toList(),

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
      reqUserPositionId: json['req_user_position_id'],
      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedAt: json['assigned_at'] != null
          ? DateTime.tryParse(json['assigned_at'])
          : null,
      assignedToRole: json['assigned_to_role'],
    );
  }
}
