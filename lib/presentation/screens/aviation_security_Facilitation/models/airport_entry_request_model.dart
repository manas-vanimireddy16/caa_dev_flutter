import 'package:code_setup/presentation/models/base_request_model.dart';

class AirportPermitRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final String? nameFullFamilyName;
  final String? nationality;
  final String? dob;
  final String? place;
  final String? passportIdCardNo;
  final String? categoryOfPermit;
  final String? dateOfSubmission;
  final String? phoneNumber;
  final String? location;
  final String? typeOfPermit;
  final List<PermissionToRequiredAreas>? permissionToRequiredAreas;
  final String? details;
  final String? occupationStaff;
  final String? requestedBy;
  final int? userId;
  final String? status;
  final int? serviceId;
  final int? subServiceId;
  final dynamic serviceType;
  final String? workflowExecutionId;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final dynamic attachmentUrl;
  final String? temporaryStartTime;
  final String? temporaryDuration;
  final dynamic forVisitor;
  final List<String>? additionalServices;
  final bool? acknowledgeSecurityPolicies;
  final bool? acknowledgeDisciplinaryAction;
  final bool? consentApproveToIssuePermit;
  final bool? consentDoNotApproveToIssuePermit;
  final dynamic consentJustification;
  final String? requestId;
  final dynamic expirationDate;
  final int? createdBy;
  final String? createdAt;
  final dynamic updatedBy;
  final String? updatedAt;
  final String? endDate;
  final dynamic deviceSerialNumber;
  final dynamic newPermitIssuanceFile;
  final dynamic formsAttachmentFile;
  final dynamic permitRenewalFile;

  AirportPermitRequestModel({
    this.base,
    this.id,
    this.nameFullFamilyName,
    this.nationality,
    this.dob,
    this.place,
    this.passportIdCardNo,
    this.categoryOfPermit,
    this.dateOfSubmission,
    this.phoneNumber,
    this.location,
    this.typeOfPermit,
    this.permissionToRequiredAreas,
    this.details,
    this.occupationStaff,
    this.requestedBy,
    this.userId,
    this.status,
    this.serviceId,
    this.subServiceId,
    this.serviceType,
    this.workflowExecutionId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.attachmentUrl,
    this.temporaryStartTime,
    this.temporaryDuration,
    this.forVisitor,
    this.additionalServices,
    this.acknowledgeSecurityPolicies,
    this.acknowledgeDisciplinaryAction,
    this.consentApproveToIssuePermit,
    this.consentDoNotApproveToIssuePermit,
    this.consentJustification,
    this.requestId,
    this.expirationDate,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.endDate,
    this.deviceSerialNumber,
    this.newPermitIssuanceFile,
    this.formsAttachmentFile,
    this.permitRenewalFile,
  });

  factory AirportPermitRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AirportPermitRequestModel();
    }

    return AirportPermitRequestModel(
      base: BaseRequestModel.fromJson(json),

      id: json['id'] as int?,
      nameFullFamilyName: json['name_full_family_name'] as String?,
      nationality: json['nationality'] as String?,
      dob: json['dob'] as String?,
      place: json['place'] as String?,
      passportIdCardNo: json['passport_id_card_no'] as String?,
      categoryOfPermit: json['category_of_permit'] as String?,
      dateOfSubmission: json['date_of_submission'] as String?,
      phoneNumber: json['phone_number'] as String?,
      location: json['location'] as String?,
      typeOfPermit: json['type_of_permit'] as String?,
      permissionToRequiredAreas: json['permission_to_required_areas'] != null
          ? (json['permission_to_required_areas'] as List)
                .map((e) => PermissionToRequiredAreas.fromJson(e))
                .toList()
          : [],
      details: json['details'] as String?,
      occupationStaff: json['occupation_staff'] as String?,
      requestedBy: json['requested_by'] as String?,
      userId: json['user_id'] as int?,
      status: json['status'] as String?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      serviceType: json['service_type'],
      workflowExecutionId: json['workflow_execution_id'] as String?,
      reqUserDepartmentId: json['req_user_department_id'] as int?,
      reqUserSectionId: json['req_user_section_id'] as int?,
      attachmentUrl: json['attachment_url'],
      temporaryStartTime: json['temporary_start_time'] as String?,
      temporaryDuration: json['temporary_duration'] as String?,
      forVisitor: json['for_visitor'],
      additionalServices: json['additional_services'] != null
          ? List<String>.from(json['additional_services'])
          : [],
      acknowledgeSecurityPolicies:
          json['acknowledge_security_policies'] as bool?,
      acknowledgeDisciplinaryAction:
          json['acknowledge_disciplinary_action'] as bool?,
      consentApproveToIssuePermit:
          json['consent_approve_to_issue_permit'] as bool?,
      consentDoNotApproveToIssuePermit:
          json['consent_do_not_approve_to_issue_permit'] as bool?,
      consentJustification: json['consent_justification'],
      requestId: json['request_id'] as String?,
      expirationDate: json['expiration_date'],
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'] as String?,
      endDate: json['end_date'] as String?,
      deviceSerialNumber: json['device_serial_number'],
      newPermitIssuanceFile: json['new_permit_issuance_file'],
      formsAttachmentFile: json['forms_attachment_file'],
      permitRenewalFile: json['permit_renewal_file'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_full_family_name': nameFullFamilyName,
      'nationality': nationality,
      'dob': dob,
      'place': place,
      'passport_id_card_no': passportIdCardNo,
      'category_of_permit': categoryOfPermit,
      'date_of_submission': dateOfSubmission,
      'phone_number': phoneNumber,
      'location': location,
      'type_of_permit': typeOfPermit,
      'permission_to_required_areas': permissionToRequiredAreas
          ?.map((e) => e.toJson())
          .toList(),
      'details': details,
      'occupation_staff': occupationStaff,
      'requested_by': requestedBy,
      'user_id': userId,
      'status': status,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'service_type': serviceType,
      'workflow_execution_id': workflowExecutionId,
      'req_user_department_id': reqUserDepartmentId,
      'req_user_section_id': reqUserSectionId,
      'attachment_url': attachmentUrl,
      'temporary_start_time': temporaryStartTime,
      'temporary_duration': temporaryDuration,
      'for_visitor': forVisitor,
      'additional_services': additionalServices,
      'acknowledge_security_policies': acknowledgeSecurityPolicies,
      'acknowledge_disciplinary_action': acknowledgeDisciplinaryAction,
      'consent_approve_to_issue_permit': consentApproveToIssuePermit,
      'consent_do_not_approve_to_issue_permit':
          consentDoNotApproveToIssuePermit,
      'consent_justification': consentJustification,
      'request_id': requestId,
      'expiration_date': expirationDate,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'end_date': endDate,
      'device_serial_number': deviceSerialNumber,
      'new_permit_issuance_file': newPermitIssuanceFile,
      'forms_attachment_file': formsAttachmentFile,
      'permit_renewal_file': permitRenewalFile,
    };
  }
}

class PermissionToRequiredAreas {
  final String? text;
  final String? permit;

  PermissionToRequiredAreas({this.text, this.permit});

  factory PermissionToRequiredAreas.fromJson(Map<String, dynamic> json) {
    return PermissionToRequiredAreas(
      text: json['text'] as String?,
      permit: json['permit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'permit': permit};
  }
}
