import 'package:code_setup/presentation/models/base_request_model.dart';

class PromotionsResponse {
  final String? status;
  final List<PromotionsModel>? data;
  final int? total;

  const PromotionsResponse({this.status, this.data, this.total});

  factory PromotionsResponse.fromJson(Map<String, dynamic> json) {
    return PromotionsResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map((e) => PromotionsModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }
}

class PromotionsModel {
  final BaseRequestModel base;

  /// Employee Basic Info
  final String? employeeName;
  final String? employeeId;

  /// Current Details
  final String? currentBasicSalary;
  final String? currentJobTitle;
  final String? currentSalaryGrade;

  /// Proposed Details
  final String? proposedBasicSalary;
  final String? proposedJobTitle;
  final String? proposedSalaryGrade;

  /// Annual Increment Details
  final int? allowanceYear;
  final String? effectiveDate;
  final String? annualPeriodicAllowance;
  final String? incrementPercentage;
  final String? newBasicSalary;

  const PromotionsModel({
    required this.base,
    this.employeeName,
    this.employeeId,
    this.currentBasicSalary,
    this.currentJobTitle,
    this.currentSalaryGrade,
    this.proposedBasicSalary,
    this.proposedJobTitle,
    this.proposedSalaryGrade,
    this.allowanceYear,
    this.effectiveDate,
    this.annualPeriodicAllowance,
    this.incrementPercentage,
    this.newBasicSalary,
  });

  factory PromotionsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PromotionsModel(base: const BaseRequestModel());
    }

    return PromotionsModel(
      base: BaseRequestModel.fromJson(json),

      employeeName: json['employee_name'] as String?,
      employeeId: json['employee_id'] as String?,

      currentBasicSalary: json['current_basic_salary'] as String?,
      currentJobTitle: json['current_job_title'] as String?,
      currentSalaryGrade: json['current_salary_grade'] as String?,

      proposedBasicSalary: json['proposed_basic_salary'] as String?,
      proposedJobTitle: json['proposed_job_title'] as String?,
      proposedSalaryGrade: json['proposed_salary_grade'] as String?,

      allowanceYear: json['allowance_year'] as int?,
      effectiveDate: json['effective_date'] as String?,
      annualPeriodicAllowance: json['annual_periodic_allowance']?.toString(),
      incrementPercentage: json['increment_percentage']?.toString(),
      newBasicSalary: json['new_basic_salary']?.toString(),
    );
  }
}
