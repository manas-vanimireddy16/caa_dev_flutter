import 'package:code_setup/presentation/models/base_request_model.dart';

class RequestForInternalAuditResponse {
  final String? status;
  final List<RequestForInternalAuditModel>? data;
  final int? total;

  const RequestForInternalAuditResponse({this.status, this.data, this.total});

  factory RequestForInternalAuditResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestForInternalAuditResponse();
    }

    return RequestForInternalAuditResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) => RequestForInternalAuditModel.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
    );
  }
}

class RequestForInternalAuditModel {
  final String? applicationToBeAudited;
  final String? applicationToBeAuditedOther;
  final String? description;
  final String? submissionDate;
  final String? requestClassification;

  final BaseRequestModel? base;

  const RequestForInternalAuditModel({
    this.applicationToBeAudited,
    this.applicationToBeAuditedOther,
    this.description,
    this.submissionDate,
    this.requestClassification,
    this.base,
  });

  factory RequestForInternalAuditModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestForInternalAuditModel();
    }

    return RequestForInternalAuditModel(
      /// ⭐ BASE MODEL (COMMON FIELDS)
      base: BaseRequestModel.fromJson(json),

      /// ⭐ REQUIRED FIELDS ONLY
      applicationToBeAudited: json['application_to_be_audited'] as String?,
      applicationToBeAuditedOther:
          json['application_to_be_audited_other'] as String?,
      description: json['description'] as String?,
      submissionDate: json['submission_date'] as String?,
      requestClassification: json['request_classification'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application_to_be_audited": applicationToBeAudited,
      "application_to_be_audited_other": applicationToBeAuditedOther,
      "description": description,
      "submission_date": submissionDate,
      "request_classification": requestClassification,
    };
  }
}
