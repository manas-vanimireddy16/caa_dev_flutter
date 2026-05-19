class ApprovalResponseModel {
  final String? status;
  final List<ApprovalData>? data;

  const ApprovalResponseModel({this.status, this.data});

  factory ApprovalResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ApprovalResponseModel();
    }

    return ApprovalResponseModel(
      status: json['status'],
      data: json['data'] != null
          ? List<ApprovalData>.from(
              json['data'].map((x) => ApprovalData.fromJson(x)),
            )
          : [],
    );
  }
}

class ApprovalData {
  final bool? isDeleted;
  final int? id;
  final int? requestId;
  final int? approverUserId;
  final int? approverRoleId;
  final String? comment;
  final String? approvalStatus;
  final int? level;
  final int? departmentId;
  final int? sectionId;
  final int? approvedBy;
  final int? serviceId;
  final int? subServiceId;
  final dynamic delegationUserId;
  final bool? isAllowed;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final RequestModel? request;

  const ApprovalData({
    this.isDeleted,
    this.id,
    this.requestId,
    this.approverUserId,
    this.approverRoleId,
    this.comment,
    this.approvalStatus,
    this.level,
    this.departmentId,
    this.sectionId,
    this.approvedBy,
    this.serviceId,
    this.subServiceId,
    this.delegationUserId,
    this.isAllowed,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.request,
  });

  factory ApprovalData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ApprovalData();
    }

    return ApprovalData(
      isDeleted: json['is_deleted'],
      id: json['id'],
      requestId: json['request_id'],
      approverUserId: json['approver_user_id'],
      approverRoleId: json['approver_role_id'],
      comment: json['comment'],
      approvalStatus: json['approval_status'],
      level: json['level'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
      approvedBy: json['approved_by'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      delegationUserId: json['delegation_user_id'],
      isAllowed: json['is_allowed'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      request: json['request'] != null
          ? RequestModel.fromJson(json['request'])
          : null,
    );
  }
}

class RequestModel {
  final bool? isDeleted;
  final int? id;
  final int? serviceId;
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
  final String? status;
  final String? workflowExecutionId;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? serviceTypeId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final int? userId;

  final CreatedByUser? createdByUser;

  const RequestModel({
    this.isDeleted,
    this.id,
    this.serviceId,
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
    this.status,
    this.workflowExecutionId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceTypeId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.userId,
    this.createdByUser,
  });

  factory RequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestModel();
    }

    return RequestModel(
      isDeleted: json['is_deleted'],
      id: json['id'],
      serviceId: json['service_id'],
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
      status: json['status'],
      workflowExecutionId: json['workflow_execution_id'],
      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],
      serviceTypeId: json['service_type_id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      userId: json['user_id'],
      createdByUser: json['created_by_user'] != null
          ? CreatedByUser.fromJson(json['created_by_user'])
          : null,
    );
  }
}

class CreatedByUser {
  final bool? isDeleted;
  final int? id;
  final String? employeeId;
  final String? civilEmployeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? personType;
  final String? dateOfBirth;
  final String? regionOfBirth;
  final String? countryOfBirth;
  final String? dateOfJoining;
  final String? lastPromotionDate;
  final String? gender;
  final String? qualification;
  final String? maritalStatus;

  const CreatedByUser({
    this.isDeleted,
    this.id,
    this.employeeId,
    this.civilEmployeeId,
    this.employeeName,
    this.employeeArabicName,
    this.personType,
    this.dateOfBirth,
    this.regionOfBirth,
    this.countryOfBirth,
    this.dateOfJoining,
    this.lastPromotionDate,
    this.gender,
    this.qualification,
    this.maritalStatus,
  });

  factory CreatedByUser.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CreatedByUser();
    }

    return CreatedByUser(
      isDeleted: json['is_deleted'],
      id: json['id'],
      employeeId: json['employee_id'],
      civilEmployeeId: json['civil_employee_id'],
      employeeName: json['employee_name'],
      employeeArabicName: json['employee_arabic_name'],
      personType: json['person_type'],
      dateOfBirth: json['date_of_birth'],
      regionOfBirth: json['region_of_birth'],
      countryOfBirth: json['country_of_birth'],
      dateOfJoining: json['date_of_joining'],
      lastPromotionDate: json['last_promotion_date'],
      gender: json['gender'],
      qualification: json['qualification'],
      maritalStatus: json['marital_status'],
    );
  }
}
