import 'package:code_setup/presentation/models/details_models.dart';

/// ─────────────────────────────
/// RESPONSE MODEL
/// ─────────────────────────────

class AssignmentDecisionResponse {
  final String? status;
  final List<AssignmentDecision> data;
  final int? totalCount;

  const AssignmentDecisionResponse({
    this.status,
    required this.data,
    this.totalCount,
  });

  factory AssignmentDecisionResponse.fromJson(Map<String, dynamic> json) {
    return AssignmentDecisionResponse(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List? ?? [])
          .map((e) => AssignmentDecision.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AssignmentDecision {
  // ───────── CORE FIELDS ─────────
  final int? id;
  final int? userId;
  final String? status;

  final int? serviceId;
  final int? subServiceId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;

  final String? description;

  // ───────── ASSIGNMENT INFO ─────────
  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedAt;
  final String? workflowExecutionId;

  // ───────── EMPLOYEE INFO ─────────
  final String? assignedEmployeeName;
  final String? civilIdCardNumber;
  final String? employeeId;
  final String? currentJobPosition;
  final String? assignedJobPosition;

  // ───────── DATE INFO ─────────
  final String? startDate;
  final String? endDate;

  // ───────── REQUEST INFO ─────────
  final String? assignmentAllowance;
  final String? phoneNumber;
  final String? reasonForRequest;

  // ───────── REPLACEMENT INFO ─────────
  final bool? isReplaced;
  final String? replacementEmployeeName;
  final String? replacementEmployeeId;
  final String? replacementCivilIdCardNumber;
  final String? replacementReason;

  final int? replacedByUserId;
  final String? replacedAt;

  // ───────── AUDIT ─────────
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  // ───────── NESTED OBJECTS ─────────
  final UserModel? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final ServiceModel? service;
  final SubServiceModel? subService;

  // ───────── SECONDMENT DECISION ─────────
  final bool? isDeleted;
  final List<dynamic>? jsonIgnore;

  final int? originalDepartmentId;
  final int? assignedDepartmentId;

  final String? entity;

  // ───────── LISTS ─────────
  final List<ChatMessageModel> chatMessages;
  final List<AttachmentModel> attachments;
  final List<WorkflowDetailModel> workflowLogs;
  final List<ApprovalDetailModel> approvalDetails;

  final dynamic assignedToRole;

  const AssignmentDecision({
    this.id,
    this.userId,
    this.status,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqUserPositionId,
    this.description,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
    this.workflowExecutionId,
    this.assignedEmployeeName,
    this.civilIdCardNumber,
    this.employeeId,
    this.currentJobPosition,
    this.assignedJobPosition,
    this.startDate,
    this.endDate,
    this.assignmentAllowance,
    this.phoneNumber,
    this.reasonForRequest,
    this.isReplaced,
    this.replacementEmployeeName,
    this.replacementEmployeeId,
    this.replacementCivilIdCardNumber,
    this.replacementReason,
    this.replacedByUserId,
    this.replacedAt,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
    this.chatMessages = const [],
    this.attachments = const [],
    this.workflowLogs = const [],
    this.approvalDetails = const [],
    this.assignedToRole,
    this.isDeleted,
    this.jsonIgnore,
    this.originalDepartmentId,
    this.assignedDepartmentId,
    this.entity,
  });

  // ─────────────────────────────
  // FROM JSON
  // ─────────────────────────────

  factory AssignmentDecision.fromJson(Map<String, dynamic> json) {
    return AssignmentDecision(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],

      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      reqUserPositionId: json['req_user_position_id'],

      description: json['description'],

      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedAt: json['assigned_at'],
      workflowExecutionId: json['workflow_execution_id'],

      assignedEmployeeName: json['assigned_employee_name'],
      civilIdCardNumber: json['civil_id_card_number'],
      employeeId: json['employee_id'],
      currentJobPosition: json['current_job_position'],
      assignedJobPosition: json['assigned_job_position'],

      startDate: json['start_date'],
      endDate: json['end_date'],

      assignmentAllowance: json['assignment_allowance']?.toString(),
      phoneNumber: json['phone_number'],
      reasonForRequest: json['reason_for_request'],

      isReplaced: json['is_replaced'],
      replacementEmployeeName: json['replacement_employee_name'],
      replacementEmployeeId: json['replacement_employee_id'],
      replacementCivilIdCardNumber: json['replacement_civil_id_card_number'],
      replacementReason: json['replacement_reason'],

      replacedByUserId: json['replaced_by_user_id'],
      replacedAt: json['replaced_at'],

      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],

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

      chatMessages: (json['chat_messages'] as List? ?? [])
          .map((e) => ChatMessageModel.fromJson(e))
          .toList(),

      attachments: (json['attachments'] as List? ?? [])
          .map((e) => AttachmentModel.fromJson(e))
          .toList(),

      workflowLogs: (json['workflow_logs'] as List? ?? [])
          .map((e) => WorkflowDetailModel.fromJson(e))
          .toList(),

      approvalDetails: (json['approval_details'] as List? ?? [])
          .map((e) => ApprovalDetailModel.fromJson(e))
          .toList(),

      assignedToRole: json['assigned_to_role'],
      isDeleted: json['is_deleted'],
      jsonIgnore: json['jsonIgnore'] as List?,

      originalDepartmentId: json['original_department_id'],
      assignedDepartmentId: json['assigned_department_id'],

      entity: json['entity'],
    );
  }
}
