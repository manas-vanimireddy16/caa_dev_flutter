import 'package:code_setup/presentation/models/details_models.dart';

class TaskListResponse {
  final String? status;
  final List<TaskItem> data;

  const TaskListResponse({this.status, required this.data});

  factory TaskListResponse.fromJson(Map<String, dynamic> json) {
    return TaskListResponse(
      status: json['status'],
      data: (json['data'] as List? ?? [])
          .map((e) => TaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TaskItem {
  /// ───────── CORE ─────────
  final int? id;
  final bool? isDeleted;
  final int? userId;

  final int? serviceId;
  final int? subServiceId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;

  final String? status;
  final String? workflowExecutionId;

  /// ───────── TASK INFO ─────────
  final String? taskTitle;
  final String? taskDescription;
  final String? priority;
  final String? completionDate;

  /// ───────── AUDIT ─────────
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  /// ───────── NESTED OBJECTS ─────────
  final UserModel? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final ServiceModel? service;
  final SubServiceModel? subService;

  /// ───────── LISTS ─────────
  final List<ChatMessageModel> chatMessages;
  final List<AttachmentModel> attachments;
  final List<WorkflowDetailModel> workflowLogs;
  final List<ApprovalDetailModel> approvalDetails;

  const TaskItem({
    this.id,
    this.isDeleted,
    this.userId,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.status,
    this.workflowExecutionId,
    this.taskTitle,
    this.taskDescription,
    this.priority,
    this.completionDate,
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
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'],
      isDeleted: json['is_deleted'],
      userId: json['user_id'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],

      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],

      status: json['status'],
      workflowExecutionId: json['workflow_execution_id'],

      taskTitle: json['task_title'],
      taskDescription: json['task_description'],
      priority: json['priority'],
      completionDate: json['completion_date'],

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
    );
  }
}
