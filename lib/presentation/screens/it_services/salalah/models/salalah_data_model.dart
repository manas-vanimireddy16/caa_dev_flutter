import 'package:code_setup/presentation/models/base_request_model.dart';
import 'package:code_setup/presentation/models/details_models.dart';

class SalalahRequestModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ SERVICE REQUEST FIELDS
  final int? subServiceId;
  final String? problem;
  final String? requestFor;
  final String? description;
  final String? extnNum;
  final String? contactNum;
  final String? email;
  final String? requestType;
  final String? personName;
  final String? personContactNumber;
  final String? requestDate;
  final ServiceTypeModel? serviceType;

  const SalalahRequestModel({
    this.base,
    this.subServiceId,
    this.problem,
    this.requestFor,
    this.description,
    this.extnNum,
    this.contactNum,
    this.email,
    this.requestType,
    this.personName,
    this.personContactNumber,
    this.requestDate,
    this.serviceType,
  });

  /// ================= FROM JSON =================
  factory SalalahRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SalalahRequestModel();

    return SalalahRequestModel(
      base: BaseRequestModel.fromJson(json),

      subServiceId: json['sub_service_id'],
      problem: json['problem'],
      requestFor: json['request_for'],
      description: json['description'],
      extnNum: json['extn_num'],
      contactNum: json['contact_num'],
      email: json['email'],
      requestType: json['request_type'],
      personName: json['person_name'],
      personContactNumber: json['person_contact_number'],
      requestDate: json['request_date'],
      serviceType: ServiceTypeModel.fromJson(json['service_type']),
    );
  }
}
