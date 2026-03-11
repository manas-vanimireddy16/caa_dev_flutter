import 'package:code_setup/presentation/models/details_models.dart';

import 'dart:convert';

OrganizeSecurityAwarenessRequestModel welcomeFromJson(String str) =>
    OrganizeSecurityAwarenessRequestModel.fromJson(json.decode(str));

String welcomeToJson(OrganizeSecurityAwarenessRequestModel data) =>
    json.encode(data.toJson());

class OrganizeSecurityAwarenessRequestModel {
  String? status;
  List<OrganizeSecurityAwarenessRequestData>? data;
  int? totalCount;

  OrganizeSecurityAwarenessRequestModel({
    this.status,
    this.data,
    this.totalCount,
  });

  factory OrganizeSecurityAwarenessRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => OrganizeSecurityAwarenessRequestModel(
    status: json["status"],
    data: json["data"] == null
        ? []
        : List<OrganizeSecurityAwarenessRequestData>.from(
            json["data"]!.map(
              (x) => OrganizeSecurityAwarenessRequestData.fromJson(x),
            ),
          ),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}

class OrganizeSecurityAwarenessRequestData {
  bool? isDeleted;
  int? id;
  int? reqUserDepartmentId;
  int? reqUserSectionId;
  int? serviceId;
  int? subServiceId;
  int? userId;
  String? title;
  DateTime? dateOfSubmission;
  String? phoneNumber;
  String? place;
  String? description;
  DateTime? eventDate;
  String? eventTime;
  String? mediaCoverageRequired;
  String? status;
  String? workflowExecutionId;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  UserModel? createdByUser;
  DepartmentModel? reqDepartment;
  SectionModel? reqSection;
  ServiceModel? service;
  SubServiceModel? subService;
  List<ChatMessageModel>? chatMessages;
  List<AttachmentModel>? attachments;
  List<WorkflowDetailModel>? workflowLogs;
  List<ApprovalDetailModel>? approvalDetails;

  OrganizeSecurityAwarenessRequestData({
    this.isDeleted,
    this.id,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.title,
    this.dateOfSubmission,
    this.phoneNumber,
    this.place,
    this.description,
    this.eventDate,
    this.eventTime,
    this.mediaCoverageRequired,
    this.status,
    this.workflowExecutionId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
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
  });

  factory OrganizeSecurityAwarenessRequestData.fromJson(
    Map<String, dynamic> json,
  ) => OrganizeSecurityAwarenessRequestData(
    isDeleted: json["is_deleted"],
    id: json["id"],
    reqUserDepartmentId: json["req_user_department_id"],
    reqUserSectionId: json["req_user_section_id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    userId: json["user_id"],
    title: json["title"],
    dateOfSubmission: json["date_of_submission"] == null
        ? null
        : DateTime.parse(json["date_of_submission"]),
    phoneNumber: json["phone_number"],
    place: json["place"],
    description: json["description"],
    eventDate: json["event_date"] == null
        ? null
        : DateTime.parse(json["event_date"]),
    eventTime: json["event_time"],
    mediaCoverageRequired: json["media_coverage_required"],
    status: json["status"],
    workflowExecutionId: json["workflow_execution_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdByUser: json["created_by_user"] == null
        ? null
        : UserModel.fromJson(json["created_by_user"]),
    reqDepartment: json["req_department"] == null
        ? null
        : DepartmentModel.fromJson(json["req_department"]),
    reqSection: json["req_section"] == null
        ? null
        : SectionModel.fromJson(json["req_section"]),
    service: json["service"] == null
        ? null
        : ServiceModel.fromJson(json["service"]),
    subService: json["sub_service"] == null
        ? null
        : SubServiceModel.fromJson(json["sub_service"]),
    chatMessages: json["chat_messages"] == null
        ? []
        : List<ChatMessageModel>.from(
            json["chat_messages"]!.map((x) => ChatMessageModel.fromJson(x)),
          ),
    attachments: json["attachments"] == null
        ? []
        : List<AttachmentModel>.from(
            json["attachments"]!.map((x) => AttachmentModel.fromJson(x)),
          ),
    workflowLogs: json["workflow_logs"] == null
        ? []
        : List<WorkflowDetailModel>.from(
            json["workflow_logs"]!.map((x) => WorkflowDetailModel.fromJson(x)),
          ),
    approvalDetails: json["approval_details"] == null
        ? []
        : List<ApprovalDetailModel>.from(
            json["approval_details"]!.map(
              (x) => ApprovalDetailModel.fromJson(x),
            ),
          ),
  );

  Map<String, dynamic> toJson() => {
    "is_deleted": isDeleted,
    "id": id,
    "req_user_department_id": reqUserDepartmentId,
    "req_user_section_id": reqUserSectionId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "user_id": userId,
    "title": title,
    "date_of_submission": dateOfSubmission == null
        ? null
        : dateOfSubmission!.toIso8601String(),
    "phone_number": phoneNumber,
    "place": place,
    "description": description,
    "event_date": eventDate == null ? null : eventDate!.toIso8601String(),
    "event_time": eventTime,
    "media_coverage_required": mediaCoverageRequired,
    "status": status,
    "workflow_execution_id": workflowExecutionId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "created_by_user": createdByUser?.toJson(),
    "req_department": reqDepartment?.toJson(),
    "req_section": reqSection?.toJson(),
    "service": service?.toJson(),
    "sub_service": subService?.toJson(),
    "chat_messages": chatMessages == null
        ? []
        : List<dynamic>.from(chatMessages!.map((x) => x.toJson())),
    "attachments": attachments == null
        ? []
        : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "workflow_logs": workflowLogs == null
        ? []
        : List<dynamic>.from(workflowLogs!.map((x) => x.toJson())),
    "approval_details": approvalDetails == null
        ? []
        : List<dynamic>.from(approvalDetails!.map((x) => x.toJson())),
  };
}
