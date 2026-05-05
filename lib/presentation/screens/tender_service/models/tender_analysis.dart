import 'package:code_setup/presentation/models/base_request_model.dart';

class TenderAnalysisModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ PROJECT FIELDS
  final String? titleOfProject;
  final String? description;
  final String? dateOfSubmission;
  final String? phone;
  final String? projectCodeBudgetCode;
  final String? status;

  const TenderAnalysisModel({
    this.base,
    this.titleOfProject,
    this.description,
    this.dateOfSubmission,
    this.phone,
    this.projectCodeBudgetCode,
    this.status,
  });

  /// ================= FROM JSON =================
  factory TenderAnalysisModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TenderAnalysisModel();

    return TenderAnalysisModel(
      base: BaseRequestModel.fromJson(json),

      titleOfProject: json['title_of_project'],
      description: json['description'],
      dateOfSubmission: json['date_of_submission'],
      phone: json['phone'],
      projectCodeBudgetCode: json['project_code_budget_code'],
      status: json['status'],
    );
  }
}
