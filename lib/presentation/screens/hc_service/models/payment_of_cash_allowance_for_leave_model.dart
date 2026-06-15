import 'package:code_setup/presentation/models/base_request_model.dart';

class PaymentOfCashAllowanceForLeaveResponse {
  final String? status;
  final List<PaymentOfCashAllowanceForLeaveRequestModel>? data;
  final int? total;

  const PaymentOfCashAllowanceForLeaveResponse({
    this.status,
    this.data,
    this.total,
  });

  factory PaymentOfCashAllowanceForLeaveResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return PaymentOfCashAllowanceForLeaveResponse(
      status: json['status'],
      total: json['total'],
      data: (json['data'] as List?)
          ?.map((e) => PaymentOfCashAllowanceForLeaveRequestModel.fromJson(e))
          .toList(),
    );
  }
}

class PaymentOfCashAllowanceForLeaveRequestModel {
  final BaseRequestModel base;

  /// Employee Info
  final String? employeeName;
  final String? employeeId;
  final String? jobTitle;
  final String? salaryGrade;

  /// Leave Calculation Fields
  final String? remainingLeaveBalance;
  final String? basicSalary;
  final String? totalSalaryDue;
  final DateTime? endOfServiceDate;
  final String? reasonForTermination;

  const PaymentOfCashAllowanceForLeaveRequestModel({
    required this.base,
    this.employeeName,
    this.employeeId,
    this.jobTitle,
    this.salaryGrade,
    this.remainingLeaveBalance,
    this.basicSalary,
    this.totalSalaryDue,
    this.endOfServiceDate,
    this.reasonForTermination,
  });

  factory PaymentOfCashAllowanceForLeaveRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return PaymentOfCashAllowanceForLeaveRequestModel(
        base: const BaseRequestModel(),
      );
    }

    return PaymentOfCashAllowanceForLeaveRequestModel(
      base: BaseRequestModel.fromJson(json),

      employeeName: json['employee_name'],
      employeeId: json['employee_id'],
      jobTitle: json['job_title'],
      salaryGrade: json['salary_grade'],

      remainingLeaveBalance: json['remaining_leave_balance'],
      basicSalary: json['basic_salary'],
      totalSalaryDue: json['total_salary_due'],

      endOfServiceDate: json['end_of_service_date'] != null
          ? DateTime.tryParse(json['end_of_service_date'])
          : null,

      reasonForTermination: json['reason_for_termination'],
    );
  }
}
