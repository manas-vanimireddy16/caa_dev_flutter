import 'package:code_setup/presentation/models/base_request_model.dart';

class AppealAgainstAdministrativeModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ FORM FIELDS
  final String? submissionDate;
  final String? titleOfComplaint;
  final String? appealAgainstDecision;
  final String? description;
  final String? decisionNumber;
  final String? decisionDate;
  final String? decisionSubject;
  final String? grievanceDetails;
  final List<String>? individualsInvolved;
  final List<String>? times;
  final String? dates;
  final String? location;
  final List<String>? requests;
  final List<String>? events;
  final String? grievantName;
  final String? grievantEmployeeNumber;
  final int? grievantDirectorateId;
  final int? grievantDepartmentId;
  final int? grievantSectionId;
  final String? grievantRelationshipToMatter;
  final bool? declarationAcknowledged;

  const AppealAgainstAdministrativeModel({
    this.base,
    this.submissionDate,
    this.titleOfComplaint,
    this.appealAgainstDecision,
    this.description,
    this.decisionNumber,
    this.decisionDate,
    this.decisionSubject,
    this.grievanceDetails,
    this.individualsInvolved,
    this.times,
    this.dates,
    this.location,
    this.requests,
    this.events,
    this.grievantName,
    this.grievantEmployeeNumber,
    this.grievantDirectorateId,
    this.grievantDepartmentId,
    this.grievantSectionId,
    this.grievantRelationshipToMatter,
    this.declarationAcknowledged,
  });

  /// ================= FROM JSON =================
  factory AppealAgainstAdministrativeModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) return const AppealAgainstAdministrativeModel();

    return AppealAgainstAdministrativeModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      submissionDate: json['submission_date'],
      titleOfComplaint: json['title_of_complaint'],
      appealAgainstDecision: json['appeal_against_decision'],
      description: json['description'],
      decisionNumber: json['decision_number'],
      decisionDate: json['decision_date'],
      decisionSubject: json['decision_subject'],
      grievanceDetails: json['grievance_details'],
      individualsInvolved: (json['individuals_involved'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      times: (json['times'] as List?)?.map((e) => e.toString()).toList(),
      dates: json['dates'],
      location: json['location'],
      requests: (json['requests'] as List?)?.map((e) => e.toString()).toList(),
      events: (json['events'] as List?)?.map((e) => e.toString()).toList(),
      grievantName: json['grievant_name'],
      grievantEmployeeNumber: json['grievant_employee_number'],
      grievantDirectorateId: json['grievant_directorate_id'],
      grievantDepartmentId: json['grievant_department_id'],
      grievantSectionId: json['grievant_section_id'],
      grievantRelationshipToMatter: json['grievant_relationship_to_matter'],
      declarationAcknowledged: json['declaration_acknowledged'],
    );
  }
}
