import 'package:code_setup/presentation/models/base_request_model.dart';

class JobTransferRequestResponse {
  final String? status;
  final List<JobTransferRequestModel>? data;
  final int? totalCount;

  const JobTransferRequestResponse({this.status, this.data, this.totalCount});

  factory JobTransferRequestResponse.fromJson(Map<String, dynamic> json) {
    return JobTransferRequestResponse(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List?)
          ?.map((e) => JobTransferRequestModel.fromJson(e))
          .toList(),
    );
  }
}

class JobTransferRequestModel {
  final BaseRequestModel base;

  /// Transfer specific fields only
  final int? reqUserPositionId;
  final String? description;
  final String? reasonForRequest;

  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedEmployeeName;
  final DateTime? assignedAt;

  final String? civilIdCardNumber;
  final String? employeeId;
  final String? currentJobPosition;
  final String? positionToBeTransferred;
  final String? effectiveFromDate;
  final String? decisionNumber;

  const JobTransferRequestModel({
    required this.base,
    this.reqUserPositionId,
    this.description,
    this.reasonForRequest,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedEmployeeName,
    this.assignedAt,
    this.civilIdCardNumber,
    this.employeeId,
    this.currentJobPosition,
    this.positionToBeTransferred,
    this.effectiveFromDate,
    this.decisionNumber,
  });

  factory JobTransferRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return JobTransferRequestModel(base: const BaseRequestModel());
    }

    return JobTransferRequestModel(
      /// ✅ parse base once
      base: BaseRequestModel.fromJson(json),

      /// ✅ transfer fields
      reqUserPositionId: json['req_user_position_id'],
      description: json['description'],
      reasonForRequest: json['reason_for_request'],

      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedEmployeeName: json['assigned_employee_name'],
      assignedAt: json['assigned_at'] != null
          ? DateTime.tryParse(json['assigned_at'])
          : null,

      civilIdCardNumber: json['civil_id_card_number'],
      employeeId: json['employee_id'],
      currentJobPosition: json['current_job_position'],
      positionToBeTransferred: json['position_to_be_transferred'],
      effectiveFromDate: json['effective_from_date'],
      decisionNumber: json['decision_number'],
    );
  }
}
