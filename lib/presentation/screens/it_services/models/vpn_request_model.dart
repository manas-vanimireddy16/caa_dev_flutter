import 'package:code_setup/presentation/models/base_request_model.dart';

class AccessRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final String? jobTitle;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? reqUserPositionId;
  final int? serviceId;
  final int? subServiceId;
  final int? userId;
  final String? requestFor;
  final String? employeeIdentifier;
  final String? employeeEmail;
  final String? phoneNumber;
  final List<String>? reasonForRequest;
  final String? description;
  final List<String>? systemsToAccess;
  final String? sourceIpType;
  final String? sourceIpAddress;
  final String? country;
  final String? startDate;
  final String? endDate;
  final String? accessType;
  final List<String>? deviceType;
  final bool? acknowledgement;
  final String? status;
  final int? reviewerUserId;
  final int? assignedToUserId;
  final String? assignedAt;

  AccessRequestModel({
    this.base,
    this.id,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.jobTitle,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.reqUserPositionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.requestFor,
    this.employeeIdentifier,
    this.employeeEmail,
    this.phoneNumber,
    this.reasonForRequest,
    this.description,
    this.systemsToAccess,
    this.sourceIpType,
    this.sourceIpAddress,
    this.country,
    this.startDate,
    this.endDate,
    this.accessType,
    this.deviceType,
    this.acknowledgement,
    this.status,
    this.reviewerUserId,
    this.assignedToUserId,
    this.assignedAt,
  });

  factory AccessRequestModel.fromJson(Map<String, dynamic> json) {
    return AccessRequestModel(
      base: json['base'] != null
          ? BaseRequestModel.fromJson(json['base'])
          : null,
      id: json['id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      jobTitle: json['job_title'],
      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      reqUserPositionId: json['req_user_position_id'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      userId: json['user_id'],
      requestFor: json['request_for'],
      employeeIdentifier: json['employee_identifier'],
      employeeEmail: json['employee_email'],
      phoneNumber: json['phone_number'],
      reasonForRequest: json['reason_for_request'] != null
          ? List<String>.from(json['reason_for_request'])
          : [],
      description: json['description'],
      systemsToAccess: json['systems_to_access'] != null
          ? List<String>.from(json['systems_to_access'])
          : [],
      sourceIpType: json['source_ip_type'],
      sourceIpAddress: json['source_ip_address'],
      country: json['country'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      accessType: json['access_type'],
      deviceType: json['device_type'] != null
          ? List<String>.from(json['device_type'])
          : [],
      acknowledgement: json['acknowledgement'],
      status: json['status'],
      reviewerUserId: json['reviewer_user_id'],
      assignedToUserId: json['assigned_to_user_id'],
      assignedAt: json['assigned_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'job_title': jobTitle,
      'req_user_department_id': reqUserDepartmentId,
      'req_user_section_id': reqUserSectionId,
      'req_user_position_id': reqUserPositionId,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'user_id': userId,
      'request_for': requestFor,
      'employee_identifier': employeeIdentifier,
      'employee_email': employeeEmail,
      'phone_number': phoneNumber,
      'reason_for_request': reasonForRequest,
      'description': description,
      'systems_to_access': systemsToAccess,
      'source_ip_type': sourceIpType,
      'source_ip_address': sourceIpAddress,
      'country': country,
      'start_date': startDate,
      'end_date': endDate,
      'access_type': accessType,
      'device_type': deviceType,
      'acknowledgement': acknowledgement,
      'status': status,
      'reviewer_user_id': reviewerUserId,
      'assigned_to_user_id': assignedToUserId,
      'assigned_at': assignedAt,
    };
  }
}
