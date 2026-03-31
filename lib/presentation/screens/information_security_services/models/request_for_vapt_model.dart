import 'package:code_setup/presentation/models/base_request_model.dart';

class RequestForVAPTResponse {
  final String? status;
  final List<RequestForVAPTModel>? data;
  final int? total;

  const RequestForVAPTResponse({this.status, this.data, this.total});

  factory RequestForVAPTResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestForVAPTResponse();
    }

    return RequestForVAPTResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map((e) => RequestForVAPTModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }
}

class RequestForVAPTModel {
  final String? applicationUrl;
  final String? ipAddress;
  final String? link;
  final String? remarks;
  final String? submissionDate;
  final String? applicationName;
  final String? requestClassification;
  final String? typeOfRequest;

  final BaseRequestModel? base;

  const RequestForVAPTModel({
    this.applicationUrl,
    this.ipAddress,
    this.link,
    this.remarks,
    this.submissionDate,
    this.applicationName,
    this.requestClassification,
    this.typeOfRequest,
    this.base,
  });

  factory RequestForVAPTModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestForVAPTModel();
    }

    return RequestForVAPTModel(
      /// ⭐ BASE MODEL (COMMON FIELDS)
      base: BaseRequestModel.fromJson(json),

      /// ⭐ NEW FIELDS
      applicationUrl: json['application_url'] as String?,
      ipAddress: json['ip_address'] as String?,
      link: json['link'] as String?,
      remarks: json['remarks'] as String?,
      submissionDate: json['submission_date'] as String?,
      applicationName: json['application_name'] as String?,
      requestClassification: json['request_classification'] as String?,
      typeOfRequest: json['type_of_request'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application_url": applicationUrl,
      "ip_address": ipAddress,
      "link": link,
      "remarks": remarks,
      "submission_date": submissionDate,
      "application_name": applicationName,
      "request_classification": requestClassification,
      "type_of_request": typeOfRequest,
    };
  }
}
