import 'package:code_setup/presentation/models/base_request_model.dart';

class PaymentOfShiftAllowanceResponse {
  final String? status;
  final List<PaymentOfShiftAllowanceRequestModel>? data;
  final int? totalCount;

  const PaymentOfShiftAllowanceResponse({
    this.status,
    this.data,
    this.totalCount,
  });

  factory PaymentOfShiftAllowanceResponse.fromJson(Map<String, dynamic> json) {
    return PaymentOfShiftAllowanceResponse(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List?)
          ?.map((e) => PaymentOfShiftAllowanceRequestModel.fromJson(e))
          .toList(),
    );
  }
}

class PaymentOfShiftAllowanceRequestModel {
  final BaseRequestModel base;

  final int? reqUserPositionId;
  final String? description;
  final String? allowanceValue;

  final int? reviewerUserId;
  final int? assignedToUserId;
  final DateTime? assignedAt;

  /// Employee info
  final String? employeeName;
  final String? employeeId;
  final String? jobTitle;
  final String? financialGrade;

  /// Shift details
  final DateTime? shiftStartDate;
  final DateTime? shiftEndDate;
  final String? startTime;
  final String? endTime;
  final String? reasonForRequest;

  const PaymentOfShiftAllowanceRequestModel({
    required this.base,
    this.reqUserPositionId,
    this.description,
    this.allowanceValue,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
    this.employeeName,
    this.employeeId,
    this.jobTitle,
    this.financialGrade,
    this.shiftStartDate,
    this.shiftEndDate,
    this.startTime,
    this.endTime,
    this.reasonForRequest,
  });

  factory PaymentOfShiftAllowanceRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return PaymentOfShiftAllowanceRequestModel(
        base: const BaseRequestModel(),
      );
    }

    return PaymentOfShiftAllowanceRequestModel(
      base: BaseRequestModel.fromJson(json),

      reqUserPositionId: json['req_user_position_id'],
      description: json['description'],
      allowanceValue: json['allowance_value'],

      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedAt: json['assigned_at'] != null
          ? DateTime.tryParse(json['assigned_at'])
          : null,

      employeeName: json['employee_name'],
      employeeId: json['employee_id'],
      jobTitle: json['job_title'],
      financialGrade: json['financial_grade'],

      shiftStartDate: json['shift_start_date'] != null
          ? DateTime.tryParse(json['shift_start_date'])
          : null,
      shiftEndDate: json['shift_end_date'] != null
          ? DateTime.tryParse(json['shift_end_date'])
          : null,

      startTime: json['start_time'],
      endTime: json['end_time'],
      reasonForRequest: json['reason_for_request'],
    );
  }
}
