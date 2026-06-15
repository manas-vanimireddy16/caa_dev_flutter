import 'package:code_setup/presentation/models/base_request_model.dart';

class SkillsEnhancementResponse {
  final String? status;
  final List<SkillsEnhancementModel>? data;
  final int? total;

  const SkillsEnhancementResponse({this.status, this.data, this.total});

  factory SkillsEnhancementResponse.fromJson(Map<String, dynamic> json) {
    return SkillsEnhancementResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) => SkillsEnhancementModel.fromJson(e as Map<String, dynamic>?),
          )
          .toList(),
    );
  }
}

class SkillsEnhancementModel {
  final BaseRequestModel base;

  /// Skills Enhancement Fields
  final String? certificationTitle;
  final String? skillCategory;
  final String? issuingAuthority;
  final String? completionDate;
  final String? skillSummary;
  final String? additionalInfoRequested;

  const SkillsEnhancementModel({
    required this.base,
    this.certificationTitle,
    this.skillCategory,
    this.issuingAuthority,
    this.completionDate,
    this.skillSummary,
    this.additionalInfoRequested,
  });

  factory SkillsEnhancementModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SkillsEnhancementModel(base: const BaseRequestModel());
    }

    return SkillsEnhancementModel(
      base: BaseRequestModel.fromJson(json),

      certificationTitle: json['certification_title'] as String?,
      skillCategory: json['skill_category'] as String?,
      issuingAuthority: json['issuing_authority'] as String?,
      completionDate: json['completion_date'] as String?,
      skillSummary: json['skill_summary'] as String?,
      additionalInfoRequested: json['additional_info_requested'] as String?,
    );
  }
}
