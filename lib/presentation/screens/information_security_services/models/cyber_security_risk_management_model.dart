import 'package:code_setup/presentation/models/base_request_model.dart';

class CyberSecurityRiskResponse {
  final String? status;
  final List<CyberSecurityRiskRequestModel>? data;
  final int? total;

  const CyberSecurityRiskResponse({this.status, this.data, this.total});

  factory CyberSecurityRiskResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CyberSecurityRiskResponse();
    }

    return CyberSecurityRiskResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) => CyberSecurityRiskRequestModel.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
    );
  }
}

class CyberSecurityRiskRequestModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ COMMON
  final String? description;

  /// ⭐ SINGLE RISK OBJECT
  final CyberSecurityRiskModel? risk;

  const CyberSecurityRiskRequestModel({this.base, this.description, this.risk});

  factory CyberSecurityRiskRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CyberSecurityRiskRequestModel();
    }

    return CyberSecurityRiskRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      /// ⭐ COMMON
      description: json['description'] as String?,

      /// ⭐ RISK (OBJECT, NOT LIST)
      risk: json['risks'] != null
          ? CyberSecurityRiskModel.fromJson(
              json['risks'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class CyberSecurityRiskModel {
  final String? riskNo;
  final String? impactedCategory;
  final String? impactArea;
  final String? threat;
  final String? vulnerability;
  final String? riskDescription;
  final String? riskOwner;

  final double? assetCiaImpact;
  final double? assetValue;
  final int? likelihood;
  final int? businessImpact;
  final double? riskValue;

  final String? existingControls;
  final String? startDate;
  final String? endDate;
  final String? isoControlReference;
  final String? riskTreatmentPlan;

  final int? confidentiality;
  final int? integrity;
  final int? availability;

  const CyberSecurityRiskModel({
    this.riskNo,
    this.impactedCategory,
    this.impactArea,
    this.threat,
    this.vulnerability,
    this.riskDescription,
    this.riskOwner,
    this.assetCiaImpact,
    this.assetValue,
    this.likelihood,
    this.businessImpact,
    this.riskValue,
    this.existingControls,
    this.startDate,
    this.endDate,
    this.isoControlReference,
    this.riskTreatmentPlan,
    this.confidentiality,
    this.integrity,
    this.availability,
  });

  factory CyberSecurityRiskModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CyberSecurityRiskModel();
    }

    return CyberSecurityRiskModel(
      riskNo: json['risk_no'] as String?,
      impactedCategory: json['impacted_category'] as String?,
      impactArea: json['impact_area'] as String?,
      threat: json['threat'] as String?,
      vulnerability: json['vulnerability'] as String?,
      riskDescription: json['risk_description'] as String?,
      riskOwner: json['risk_owner'] as String?,

      /// ⭐ HANDLE STRING → DOUBLE
      assetCiaImpact: double.tryParse(
        json['asset_cia_impact']?.toString() ?? '0',
      ),
      assetValue: double.tryParse(json['asset_value']?.toString() ?? '0'),
      likelihood: json['likelihood'] as int?,
      businessImpact: json['business_impact'] as int?,
      riskValue: double.tryParse(json['risk_value']?.toString() ?? '0'),

      existingControls: json['existing_controls'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      isoControlReference: json['iso_control_reference'] as String?,
      riskTreatmentPlan: json['risk_treatment_plan'] as String?,

      confidentiality: json['confidentiality'] as int?,
      integrity: json['integrity'] as int?,
      availability: json['availability'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "risk_no": riskNo,
      "impacted_category": impactedCategory,
      "impact_area": impactArea,
      "threat": threat,
      "vulnerability": vulnerability,
      "risk_description": riskDescription,
      "risk_owner": riskOwner,
      "asset_cia_impact": assetCiaImpact,
      "asset_value": assetValue,
      "likelihood": likelihood,
      "business_impact": businessImpact,
      "risk_value": riskValue,
      "existing_controls": existingControls,
      "start_date": startDate,
      "end_date": endDate,
      "iso_control_reference": isoControlReference,
      "risk_treatment_plan": riskTreatmentPlan,
      "confidentiality": confidentiality,
      "integrity": integrity,
      "availability": availability,
    };
  }
}
