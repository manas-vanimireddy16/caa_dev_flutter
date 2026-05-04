import 'package:code_setup/presentation/models/base_request_model.dart';

class TenderServiceEnquiryModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ NEW FIELDS (FROM YOUR PAYLOAD)
  final String? titleOfEnquiry;
  final String? description;
  final String? dateOfSubmission;
  final String? phone;
  final String? status;

  final String? tenderDateOfSubmission;
  final String? tenderPhone;
  final String? budgetCode;
  final String? estimatedCost;
  final String? implementationPeriod;
  final String? requestingEntity;

  const TenderServiceEnquiryModel({
    this.base,
    this.titleOfEnquiry,
    this.description,
    this.dateOfSubmission,
    this.phone,
    this.status,
    this.tenderDateOfSubmission,
    this.tenderPhone,
    this.budgetCode,
    this.estimatedCost,
    this.implementationPeriod,
    this.requestingEntity,
  });

  /// ================= FROM JSON =================
  factory TenderServiceEnquiryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TenderServiceEnquiryModel();

    return TenderServiceEnquiryModel(
      base: BaseRequestModel.fromJson(json),

      titleOfEnquiry: json['title_of_enquiry'],
      description: json['description'],
      dateOfSubmission: json['date_of_submission'],
      phone: json['phone'],
      status: json['status'],

      tenderDateOfSubmission: json['tender_date_of_submission'],
      tenderPhone: json['tender_phone'],
      budgetCode: json['budget_code'],
      estimatedCost: json['estimated_cost'],
      implementationPeriod: json['implementation_period'],
      requestingEntity: json['requesting_entity'],
    );
  }
}
