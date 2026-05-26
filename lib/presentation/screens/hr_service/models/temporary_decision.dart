import 'package:code_setup/presentation/models/base_request_model.dart';

class TemporaryDecision {
  final BaseRequestModel? base;

  final int? id;
  final int? userId;
  final String? status;
  final int? serviceId;
  final int? subServiceId;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;
  final String? description;
  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedAt;
  final String? workflowExecutionId;
  final String? assignedEmployeeName;
  final String? civilIdCardNumber;
  final String? employeeId;
  final String? currentJobPosition;
  final String? assignedJobPosition;
  final int? originalDepartmentId;
  final int? assignedDepartmentId;
  final String? fromEntity;
  final String? toEntity;
  final String? startDate;
  final String? endDate;
  final String? phoneNumber;
  final String? reasonForRequest;
  final String? requestType;
  final String? salaryPaymentSource;
  final String? socialServiceFundContribution;
  final bool? isReplaced;
  final String? replacementEmployeeName;
  final String? replacementEmployeeId;
  final String? replacementCivilIdCardNumber;
  final String? replacementReason;
  final int? replacedByUserId;
  final String? replacedAt;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  TemporaryDecision({
    this.base,

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
    this.originalDepartmentId,
    this.assignedDepartmentId,
    this.fromEntity,
    this.toEntity,
    this.startDate,
    this.endDate,
    this.phoneNumber,
    this.reasonForRequest,
    this.requestType,
    this.salaryPaymentSource,
    this.socialServiceFundContribution,
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
  });

  factory TemporaryDecision.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TemporaryDecision();
    }

    return TemporaryDecision(
      base: BaseRequestModel.fromJson(json),

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
      originalDepartmentId: json['original_department_id'],
      assignedDepartmentId: json['assigned_department_id'],
      fromEntity: json['from_entity'],
      toEntity: json['to_entity'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      phoneNumber: json['phone_number'],
      reasonForRequest: json['reason_for_request'],
      requestType: json['request_type'],
      salaryPaymentSource: json['salary_payment_source'],
      socialServiceFundContribution: json['social_service_fund_contribution'],
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'req_user_department_id': reqUserDepartmentId,
      'req_user_section_id': reqUserSectionId,
      'req_user_position_id': reqUserPositionId,
      'description': description,
      'reviewer_user_id': reviewerUserId,
      'assigned_to_user_id': assignedToUserId,
      'assigned_at': assignedAt,
      'workflow_execution_id': workflowExecutionId,
      'assigned_employee_name': assignedEmployeeName,
      'civil_id_card_number': civilIdCardNumber,
      'employee_id': employeeId,
      'current_job_position': currentJobPosition,
      'assigned_job_position': assignedJobPosition,
      'original_department_id': originalDepartmentId,
      'assigned_department_id': assignedDepartmentId,
      'from_entity': fromEntity,
      'to_entity': toEntity,
      'start_date': startDate,
      'end_date': endDate,
      'phone_number': phoneNumber,
      'reason_for_request': reasonForRequest,
      'request_type': requestType,
      'salary_payment_source': salaryPaymentSource,
      'social_service_fund_contribution': socialServiceFundContribution,
      'is_replaced': isReplaced,
      'replacement_employee_name': replacementEmployeeName,
      'replacement_employee_id': replacementEmployeeId,
      'replacement_civil_id_card_number': replacementCivilIdCardNumber,
      'replacement_reason': replacementReason,
      'replaced_by_user_id': replacedByUserId,
      'replaced_at': replacedAt,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
    };
  }
}
