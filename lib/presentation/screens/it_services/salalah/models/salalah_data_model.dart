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

    final serviceTypeJson = json['service_type'];

    return SalalahRequestModel(
      base: BaseRequestModel.fromJson(json),

      subServiceId: int.tryParse(json['sub_service_id']?.toString() ?? ''),
      problem: json['problem']?.toString(),
      requestFor: json['request_for']?.toString(),
      description: json['description']?.toString(),
      extnNum: json['extn_num']?.toString(),
      contactNum: json['contact_num']?.toString(),
      email: json['email']?.toString(),
      requestType: json['request_type']?.toString(),
      personName: json['person_name']?.toString(),
      personContactNumber: json['person_contact_number']?.toString(),
      requestDate: json['request_date']?.toString(),
      serviceType: serviceTypeJson is Map<String, dynamic>
          ? ServiceTypeModel.fromJson(serviceTypeJson)
          : null,
    );
  }
}
