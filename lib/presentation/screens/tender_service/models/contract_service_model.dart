import 'package:code_setup/presentation/models/base_request_model.dart';

class ContractServiceModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ PROJECT DETAILS FIELDS
  final String? titleOfProject;
  final String? description;
  final String? dateOfSubmission;
  final String? phone;
  final String? requestId;
  final String? projectOrBudgetCode;
  final String? companyName;

  const ContractServiceModel({
    this.base,
    this.titleOfProject,
    this.description,
    this.dateOfSubmission,
    this.phone,
    this.requestId,
    this.projectOrBudgetCode,
    this.companyName,
  });

  /// ================= FROM JSON =================
  factory ContractServiceModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ContractServiceModel();

    return ContractServiceModel(
      base: BaseRequestModel.fromJson(json),

      titleOfProject: json['title_of_project'],
      description: json['description'],
      dateOfSubmission: json['date_of_submission'],
      phone: json['phone'],
      requestId: json['request_id'],
      projectOrBudgetCode: json['project_or_budget_code'],
      companyName: json['company_name'],
    );
  }
}
