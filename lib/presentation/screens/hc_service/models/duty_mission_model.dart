import 'package:code_setup/presentation/models/details_models.dart';

/// ─────────────────────────────
/// RESPONSE MODEL
/// ─────────────────────────────
class DutyMissionResponse {
  final String? status;
  final List<DutyMissionModel> data;
  final int? totalCount;

  const DutyMissionResponse({this.status, required this.data, this.totalCount});

  factory DutyMissionResponse.fromJson(Map<String, dynamic> json) {
    return DutyMissionResponse(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List? ?? [])
          .map((e) => DutyMissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// ─────────────────────────────
/// DUTY MISSION MODEL
/// ─────────────────────────────
class DutyMissionModel {
  final int? id;
  final bool? isDeleted;
  final int? userId;

  final String? tripType;
  final String? chooseType;
  final String? missionSponsoredBy;
  final String? missionPurpose;
  final String? missionNumber;
  final String? missionStartDate;
  final String? missionEndDate;
  final String? travellingAreaFrom;
  final String? travellingAreaTo;
  final String? fromCountry;
  final String? toCountry;
  final String? travelPlace;
  final String? travelStartDate;
  final String? travelReturnDate;
  final String? status;
  final String? requestId;
  final String? missionId;
  final int? missionDays;
  final String? distance;
  final String? ifSponsored;
  final String? allowancePercentage;
  final String? airTicketRequired;
  final String? vehicleRequired;
  final String? remarks;

  final int? serviceId;
  final int? subServiceId;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;

  final String? workflowExecutionId;

  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// existing models
  final UserModel? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final ServiceModel? service;
  final SubServiceModel? subService;

  final List<ChatMessageModel>? chatMessages;
  final List<AttachmentModel>? attachments;
  final List<EmployeeDetailModel>? employeesDetails;
  final List<AirTicketDetailModel>? airTicketDetails;
  final List<WorkflowDetailModel>? workflowLogs;
  final List<ApprovalDetailModel>? approvalDetails;

  const DutyMissionModel({
    this.id,
    this.isDeleted,
    this.userId,
    this.tripType,
    this.chooseType,
    this.missionSponsoredBy,
    this.missionPurpose,
    this.missionNumber,
    this.missionStartDate,
    this.missionEndDate,
    this.travellingAreaFrom,
    this.travellingAreaTo,
    this.fromCountry,
    this.toCountry,
    this.travelPlace,
    this.travelStartDate,
    this.travelReturnDate,
    this.status,
    this.requestId,
    this.missionId,
    this.missionDays,
    this.distance,
    this.ifSponsored,
    this.allowancePercentage,
    this.airTicketRequired,
    this.vehicleRequired,
    this.remarks,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
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
    this.employeesDetails,
    this.airTicketDetails,
    this.workflowLogs,
    this.approvalDetails,
  });

  factory DutyMissionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DutyMissionModel();

    return DutyMissionModel(
      id: json['id'],
      isDeleted: json['is_deleted'],
      userId: json['user_id'],

      tripType: json['trip_type'],
      chooseType: json['choose_type'],
      missionSponsoredBy: json['mission_sponsored_by'],
      missionPurpose: json['mission_purpose'],
      missionNumber: json['mission_number'],
      missionStartDate: json['mission_start_date'],
      missionEndDate: json['mission_end_date'],
      travellingAreaFrom: json['travelling_area_from'],
      travellingAreaTo: json['travelling_area_to'],
      fromCountry: json['from_country'],
      toCountry: json['to_country'],
      travelPlace: json['travel_place'],
      travelStartDate: json['travel_start_date'],
      travelReturnDate: json['travel_return_date'],
      status: json['status'],
      requestId: json['request_id'],
      missionId: json['mission_id'],
      missionDays: json['mission_days'],
      distance: json['distance'],
      ifSponsored: json['if_sponsored'],
      allowancePercentage: json['allowance_percentage'],
      airTicketRequired: json['air_ticket_required'],
      vehicleRequired: json['vehicle_required'],
      remarks: json['remarks'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],

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

      employeesDetails: (json['employees_details'] as List?)
          ?.map((e) => EmployeeDetailModel.fromJson(e))
          .toList(),

      airTicketDetails: (json['air_ticket_details'] as List?)
          ?.map((e) => AirTicketDetailModel.fromJson(e))
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
