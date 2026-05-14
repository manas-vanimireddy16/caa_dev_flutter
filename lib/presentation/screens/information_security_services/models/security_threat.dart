import 'package:code_setup/presentation/models/base_request_model.dart';

class SecurityThreatRequestModel {
  final BaseRequestModel? base;

  final int? userId;

  final int? typeOfThreat;

  final String? description;

  final String? contactNumber;

  final String? priority;

  final String? status;

  final String? workflowExecutionId;

  final String? ticketName;

  final String? sourceOfIncident;

  final List<String>? typeOfIncidentDetected;

  final List<String>? incidentNotificationInCaa;

  final String? identificationMeasures;

  final String? evidenceCollected;

  final String? eradicationMitigationMeasures;

  final String? recoveryMeasures;

  final String? otherMitigationMeasures;

  const SecurityThreatRequestModel({
    this.base,

    this.userId,

    this.typeOfThreat,

    this.description,

    this.contactNumber,

    this.priority,

    this.status,

    this.workflowExecutionId,

    this.ticketName,

    this.sourceOfIncident,

    this.typeOfIncidentDetected,

    this.incidentNotificationInCaa,

    this.identificationMeasures,

    this.evidenceCollected,

    this.eradicationMitigationMeasures,

    this.recoveryMeasures,

    this.otherMitigationMeasures,
  });

  /// ================= FROM JSON =================

  factory SecurityThreatRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const SecurityThreatRequestModel();
    }

    return SecurityThreatRequestModel(
      base: BaseRequestModel.fromJson(json),

      userId: json['user_id'],

      typeOfThreat: json['type_of_threat'],

      description: json['description'],

      contactNumber: json['contact_number'],

      priority: json['priority'],

      status: json['status'],

      workflowExecutionId: json['workflow_execution_id'],

      ticketName: json['ticket_name'],

      sourceOfIncident: json['source_of_incident'],

      typeOfIncidentDetected: (json['type_of_incident_detected'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      incidentNotificationInCaa: (json['type_of_incident_detected'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      identificationMeasures: json['identification_measures'],

      evidenceCollected: json['evidence_collected'],

      eradicationMitigationMeasures: json['eradication_mitigation_measures'],

      recoveryMeasures: json['recovery_measures'],

      otherMitigationMeasures: json['other_mitigation_measures'],
    );
  }

  /// ================= TO JSON =================
}
