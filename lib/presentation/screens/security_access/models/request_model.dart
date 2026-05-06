import 'package:code_setup/presentation/models/base_request_model.dart';

class AccessCardRequest {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ ACCESS CARD REQUEST FIELDS
  final int? id;
  final String? requestFor;
  final String? name;
  final String? idNumber;
  final String? phoneNumber;
  final String? emailId;
  final String? requestType;
  final String? category;
  final String? organization;
  final String? reason;
  final String? requestDate;
  final int? userId;
  final String? status;
  final String? approvalRoute;
  final int? serviceId;
  final int? subServiceId;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final String? accessCardNo;
  final String? workflowExecutionId;
  final int? createdBy;
  final String? createdAt;

  const AccessCardRequest({
    this.base,
    this.id,
    this.requestFor,
    this.name,
    this.idNumber,
    this.phoneNumber,
    this.emailId,
    this.requestType,
    this.category,
    this.organization,
    this.reason,
    this.requestDate,
    this.userId,
    this.status,
    this.approvalRoute,
    this.serviceId,
    this.subServiceId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.accessCardNo,
    this.workflowExecutionId,
    this.createdBy,
    this.createdAt,
  });

  /// ================= FROM JSON =================
  factory AccessCardRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const AccessCardRequest();

    return AccessCardRequest(
      base: BaseRequestModel.fromJson(json),

      id: json['id'],
      requestFor: json['request_for'],
      name: json['name'],
      idNumber: json['id_number'],
      phoneNumber: json['phone_number'],
      emailId: json['email_id'],
      requestType: json['request_type'],
      category: json['category'],
      organization: json['organization'],
      reason: json['reason'],
      requestDate: json['request_date'],
      userId: json['user_id'],
      status: json['status'],
      approvalRoute: json['approval_route'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      accessCardNo: json['access_card_no'],
      workflowExecutionId: json['workflow_execution_id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }
}
