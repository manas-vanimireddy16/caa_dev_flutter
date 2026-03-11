import 'package:code_setup/presentation/models/base_request_model.dart';

class RequiredNewResourceResponse {
  final String? status;
  final List<RequiredNewResourceRequestModel>? data;
  final int? total;

  const RequiredNewResourceResponse({this.status, this.data, this.total});

  factory RequiredNewResourceResponse.fromJson(Map<String, dynamic> json) {
    return RequiredNewResourceResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) => RequiredNewResourceRequestModel.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
    );
  }
}

class RequiredNewResourceRequestModel {
  final BaseRequestModel base;

  /// Employee / Job Info
  final String? employeeName;
  final String? employeeId;
  final String? jobTitle;
  final String? salaryGrade;
  final String? positionToBeFilled;
  final String? grade;
  final String? roleTitle;
  final String? educationRequirements;
  final String? requiredSkills;
  final String? yearsOfExperience;
  final String? location;
  final String? jobDescription;

  const RequiredNewResourceRequestModel({
    required this.base,
    this.employeeName,
    this.employeeId,
    this.jobTitle,
    this.salaryGrade,
    this.positionToBeFilled,
    this.grade,
    this.roleTitle,
    this.educationRequirements,
    this.requiredSkills,
    this.yearsOfExperience,
    this.location,
    this.jobDescription,
  });

  factory RequiredNewResourceRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RequiredNewResourceRequestModel(base: const BaseRequestModel());
    }

    return RequiredNewResourceRequestModel(
      base: BaseRequestModel.fromJson(json),

      employeeName: json['employee_name'] as String?,
      employeeId: json['employee_id'] as String?,
      jobTitle: json['job_title'] as String?,
      salaryGrade: json['salary_grade'] as String?,
      positionToBeFilled: json['position_to_be_filled'] as String?,
      grade: json['grade'] as String?,
      roleTitle: json['role_title'] as String?,
      educationRequirements: json['education_requirements'] as String?,
      requiredSkills: json['required_skills'] as String?,
      yearsOfExperience: json['years_of_experience'] as String?,
      location: json['location'] as String?,
      jobDescription: json['job_description'] as String?,
    );
  }
}
