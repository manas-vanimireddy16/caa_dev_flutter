import 'package:code_setup/presentation/models/base_request_model.dart';

class LegalRequestModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ FORM FIELDS
  final bool? acknowledgement;
  final String? hosOrDepartmentName;
  final int? departmentId;
  final String? requestType;
  final String? requestTitle;
  final String? description;

  const LegalRequestModel({
    this.base,
    this.acknowledgement,
    this.hosOrDepartmentName,
    this.departmentId,
    this.requestType,
    this.requestTitle,
    this.description,
  });

  /// ================= FROM JSON =================
  factory LegalRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const LegalRequestModel();
    }

    return LegalRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      /// ⭐ FIELDS
      acknowledgement: json['acknowledgement'] as bool?,
      hosOrDepartmentName: json['hos_or_department_name'] as String?,
      departmentId: json['department_id'] as int?,
      requestType: json['request_type'] as String?,
      requestTitle: json['request_title'] as String?,
      description: json['description'] as String?,
    );
  }

  /// ================= TO JSON =================
}
