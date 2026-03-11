import 'package:code_setup/presentation/models/details_models.dart';

class AccessCardRequestResponse {
  final String status;
  final int totalCount;
  final List<AccessCardRequest> data;

  AccessCardRequestResponse({
    required this.status,
    required this.totalCount,
    required this.data,
  });

  factory AccessCardRequestResponse.fromJson(Map<String, dynamic> json) {
    return AccessCardRequestResponse(
      status: json['status'] ?? '',
      totalCount: json['total_count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => AccessCardRequest.fromJson(e))
          .toList(),
    );
  }
}

class AccessCardRequest {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
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
  final int? updatedBy;
  final String? updatedAt;

  final CreatedByUser? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final ServiceModel? service;
  final SubServiceModel? subService;

  final List<ApprovalDetail>? approvalDetails;
  final List<WorkflowLog>? workflowLogs;
  final List<AttachmentModel>? attachments;
  final List<ChatMessageModel>? chatMessages;

  AccessCardRequest({
    this.jsonIgnore,
    this.isDeleted,
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
    this.updatedBy,
    this.updatedAt,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
    this.approvalDetails,
    this.workflowLogs,
    this.attachments,
    this.chatMessages,
  });

  factory AccessCardRequest.fromJson(Map<String, dynamic> json) {
    return AccessCardRequest(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      requestFor: json["request_for"],
      name: json["name"],
      idNumber: json["id_number"],
      phoneNumber: json["phone_number"],
      emailId: json["email_id"],
      requestType: json["request_type"],
      category: json["category"],
      organization: json["organization"],
      reason: json["reason"],
      requestDate: json["request_date"],
      userId: json["user_id"],
      status: json["status"],
      approvalRoute: json["approval_route"],
      serviceId: json["service_id"],
      subServiceId: json["sub_service_id"],
      reqUserDepartmentId: json["req_user_department_id"],
      reqUserSectionId: json["req_user_section_id"],
      accessCardNo: json["access_card_no"],
      workflowExecutionId: json["workflow_execution_id"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],

      createdByUser: json["created_by_user"] != null
          ? CreatedByUser.fromJson(json["created_by_user"])
          : null,

      reqDepartment: json["req_department"] != null
          ? DepartmentModel.fromJson(json["req_department"])
          : null,

      reqSection: json["req_section"] != null
          ? SectionModel.fromJson(json["req_section"])
          : null,

      service: json["service"] != null
          ? ServiceModel.fromJson(json["service"])
          : null,

      subService: json["sub_service"] != null
          ? SubServiceModel.fromJson(json["sub_service"])
          : null,

      approvalDetails: (json["approval_details"] as List<dynamic>?)
          ?.map((e) => ApprovalDetail.fromJson(e))
          .toList(),

      workflowLogs: (json["workflow_logs"] as List<dynamic>?)
          ?.map((e) => WorkflowLog.fromJson(e))
          .toList(),

      attachments: (json["attachments"] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e))
          .toList(),

      chatMessages: (json["chat_messages"] as List<dynamic>?)
          ?.map((e) => ChatMessageModel.fromJson(e))
          .toList(),
    );
  }
}

class CreatedByUser {
  final List<String>? jsonIgnore;
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
  final String? nationality;
  final String? email;
  final String? bloodType;
  final String? nationalId;
  final String? manpowerId;
  final String? mobile;
  final String? officeNumber;

  final DepartmentModel? department;
  final String? category;
  final String? directorate;

  final SectionModel? section;
  final int? position;
  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;
  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? address;
  final String? religion;

  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final bool? isAdmin;

  CreatedByUser({
    this.jsonIgnore,
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
    this.nationality,
    this.email,
    this.bloodType,
    this.nationalId,
    this.manpowerId,
    this.mobile,
    this.officeNumber,
    this.department,
    this.category,
    this.directorate,
    this.section,
    this.position,
    this.arabicPosition,
    this.grade,
    this.location,
    this.supervisorEmpId,
    this.supervisorEmpName,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    this.diplomaticName,
    this.avatar,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.address,
    this.religion,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isAdmin,
  });

  factory CreatedByUser.fromJson(Map<String, dynamic> json) {
    return CreatedByUser(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      employeeId: json["employee_id"],
      civilEmployeeId: json["civil_employee_id"],
      employeeName: json["employee_name"],
      employeeArabicName: json["employee_arabic_name"],
      personType: json["person_type"],
      dateOfBirth: json["date_of_birth"],
      regionOfBirth: json["region_of_birth"],
      countryOfBirth: json["country_of_birth"],
      dateOfJoining: json["date_of_joining"],
      lastPromotionDate: json["last_promotion_date"],
      gender: json["gender"],
      qualification: json["qualification"],
      maritalStatus: json["marital_status"],
      nationality: json["nationality"],
      email: json["email"],
      bloodType: json["blood_type"],
      nationalId: json["national_id"],
      manpowerId: json["manpower_id"],
      mobile: json["mobile"],
      officeNumber: json["office_number"],

      department: json["department"] is Map
          ? DepartmentModel.fromJson(json["department"])
          : null,

      category: json["category"],
      directorate: json["directorate"],

      section: json["section"] is Map
          ? SectionModel.fromJson(json["section"])
          : null,

      position: json["position"],
      arabicPosition: json["arabic_position"],
      grade: json["grade"],
      location: json["location"],
      supervisorEmpId: json["supervisor_emp_id"],
      supervisorEmpName: json["supervisor_emp_name"],
      passportNumber: json["passport_number"],
      personalEmail: json["personal_email"],
      extensionNumber: json["extension_number"],
      faxNumber: json["fax_number"],
      diplomaticName: json["diplomatic_name"],
      avatar: json["avatar"],
      fatherName: json["father_name"],
      spouseName: json["spouse_name"],
      children1Name: json["children1_name"],
      children2Name: json["children2_name"],
      address: json["address"],
      religion: json["religion"],

      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
      isAdmin: json["is_admin"],
    );
  }
}

class ApprovalDetail {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final int? requestId;
  final int? serviceId;
  final int? subServiceId;
  final int? level;
  final int? approverRoleId;
  final int? departmentId;
  final int? sectionId;
  final int? approverUserId;
  final int? delegateUserId;
  final int? approvedBy;
  final String? comment;
  final String? approvalStatus;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final ApproverRole? approverRole;
  final ApproverUser? approverUser;
  final DelegateUser? delegateUser;
  final ApprovedByUser? approvedByUser;

  ApprovalDetail({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.level,
    this.approverRoleId,
    this.departmentId,
    this.sectionId,
    this.approverUserId,
    this.delegateUserId,
    this.approvedBy,
    this.comment,
    this.approvalStatus,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approverRole,
    this.approverUser,
    this.delegateUser,
    this.approvedByUser,
  });

  factory ApprovalDetail.fromJson(Map<String, dynamic> json) {
    return ApprovalDetail(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),

      isDeleted: json["is_deleted"],
      id: json["id"],
      requestId: json["request_id"],
      serviceId: json["service_id"],
      subServiceId: json["sub_service_id"],
      level: json["level"],
      approverRoleId: json["approver_role_id"],
      departmentId: json["department_id"],
      sectionId: json["section_id"],
      approverUserId: json["approver_user_id"],
      delegateUserId: json["delegate_user_id"],
      approvedBy: json["approved_by"],
      comment: json["comment"],
      approvalStatus: json["approval_status"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],

      approverRole: json["approver_role"] != null
          ? ApproverRole.fromJson(json["approver_role"])
          : null,

      approverUser: json["approver_user"] != null
          ? ApproverUser.fromJson(json["approver_user"])
          : null,

      delegateUser: json["delegate_user"] != null
          ? DelegateUser.fromJson(json["delegate_user"])
          : null,

      approvedByUser: json["approved_by_user"] != null
          ? ApprovedByUser.fromJson(json["approved_by_user"])
          : null,
    );
  }
}

class ApproverRole {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? name;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  ApproverRole({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ApproverRole.fromJson(Map<String, dynamic> json) {
    return ApproverRole(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      name: json["name"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
    );
  }
}

class ApproverUser {
  final List<String>? jsonIgnore;
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
  final String? nationality;
  final String? email;
  final String? bloodType;
  final String? nationalId;
  final String? manpowerId;
  final String? mobile;
  final String? officeNumber;

  /// Here department & section come as INT (115, 282).
  /// Not objects (your JSON shows this difference).
  final int? department;
  final String? category;
  final String? directorate;
  final int? section;
  final int? position;
  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;
  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final String? avatar;

  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? address;
  final String? religion;

  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final bool? isAdmin;

  ApproverUser({
    this.jsonIgnore,
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
    this.nationality,
    this.email,
    this.bloodType,
    this.nationalId,
    this.manpowerId,
    this.mobile,
    this.officeNumber,
    this.department,
    this.category,
    this.directorate,
    this.section,
    this.position,
    this.arabicPosition,
    this.grade,
    this.location,
    this.supervisorEmpId,
    this.supervisorEmpName,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    this.diplomaticName,
    this.avatar,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.address,
    this.religion,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isAdmin,
  });

  factory ApproverUser.fromJson(Map<String, dynamic> json) {
    return ApproverUser(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),

      isDeleted: json["is_deleted"],
      id: json["id"],
      employeeId: json["employee_id"],
      civilEmployeeId: json["civil_employee_id"],
      employeeName: json["employee_name"],
      employeeArabicName: json["employee_arabic_name"],
      personType: json["person_type"],
      dateOfBirth: json["date_of_birth"],
      regionOfBirth: json["region_of_birth"],
      countryOfBirth: json["country_of_birth"],
      dateOfJoining: json["date_of_joining"],
      lastPromotionDate: json["last_promotion_date"],
      gender: json["gender"],
      qualification: json["qualification"],
      maritalStatus: json["marital_status"],
      nationality: json["nationality"],
      email: json["email"],
      bloodType: json["blood_type"],
      nationalId: json["national_id"],
      manpowerId: json["manpower_id"],
      mobile: json["mobile"],
      officeNumber: json["office_number"],

      department: json["department"],
      category: json["category"],
      directorate: json["directorate"],
      section: json["section"],
      position: json["position"],
      arabicPosition: json["arabic_position"],
      grade: json["grade"],
      location: json["location"],
      supervisorEmpId: json["supervisor_emp_id"],
      supervisorEmpName: json["supervisor_emp_name"],
      passportNumber: json["passport_number"],
      personalEmail: json["personal_email"],
      extensionNumber: json["extension_number"],
      faxNumber: json["fax_number"],
      diplomaticName: json["diplomatic_name"],
      avatar: json["avatar"],

      fatherName: json["father_name"],
      spouseName: json["spouse_name"],
      children1Name: json["children1_name"],
      children2Name: json["children2_name"],
      address: json["address"],
      religion: json["religion"],

      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
      isAdmin: json["is_admin"],
    );
  }
}

class DelegateUser {
  DelegateUser();

  factory DelegateUser.fromJson(Map<String, dynamic> json) {
    return DelegateUser();
  }
}

class ApprovedByUser {
  ApprovedByUser();

  factory ApprovedByUser.fromJson(Map<String, dynamic> json) {
    return ApprovedByUser();
  }
}

class WorkflowLog {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final int? requestId;
  final int? serviceId;
  final int? subServiceId;
  final String? content;
  final String? status;
  final int? userId;
  final int? roleId;
  final int? departmentId;
  final int? sectionId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final WorkflowUser? user;
  final WorkflowRole? role;
  final WorkflowDepartment? department;
  final WorkflowSection? section;

  WorkflowLog({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.content,
    this.status,
    this.userId,
    this.roleId,
    this.departmentId,
    this.sectionId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.user,
    this.role,
    this.department,
    this.section,
  });

  factory WorkflowLog.fromJson(Map<String, dynamic> json) {
    return WorkflowLog(
      jsonIgnore: (json["jsonIgnore"] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      requestId: json["request_id"],
      serviceId: json["service_id"],
      subServiceId: json["sub_service_id"],
      content: json["content"],
      status: json["status"],
      userId: json["user_id"],
      roleId: json["role_id"],
      departmentId: json["department_id"],
      sectionId: json["section_id"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],

      user: json["user"] != null ? WorkflowUser.fromJson(json["user"]) : null,
      role: json["role"] != null ? WorkflowRole.fromJson(json["role"]) : null,
      department: json["department"] != null
          ? WorkflowDepartment.fromJson(json["department"])
          : null,
      section: json["section"] != null
          ? WorkflowSection.fromJson(json["section"])
          : null,
    );
  }
}

class WorkflowUser {
  final List<String>? jsonIgnore;
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
  final String? nationality;
  final String? email;
  final String? bloodType;
  final String? nationalId;
  final String? manpowerId;
  final String? mobile;
  final String? officeNumber;

  final int? department;
  final String? category;
  final String? directorate;
  final int? section;
  final int? position;
  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;
  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? address;
  final String? religion;

  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final bool? isAdmin;

  WorkflowUser({
    this.jsonIgnore,
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
    this.nationality,
    this.email,
    this.bloodType,
    this.nationalId,
    this.manpowerId,
    this.mobile,
    this.officeNumber,
    this.department,
    this.category,
    this.directorate,
    this.section,
    this.position,
    this.arabicPosition,
    this.grade,
    this.location,
    this.supervisorEmpId,
    this.supervisorEmpName,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    this.diplomaticName,
    this.avatar,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.address,
    this.religion,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isAdmin,
  });

  factory WorkflowUser.fromJson(Map<String, dynamic> json) {
    return WorkflowUser(
      jsonIgnore: (json["jsonIgnore"] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      employeeId: json["employee_id"],
      civilEmployeeId: json["civil_employee_id"],
      employeeName: json["employee_name"],
      employeeArabicName: json["employee_arabic_name"],
      personType: json["person_type"],
      dateOfBirth: json["date_of_birth"],
      regionOfBirth: json["region_of_birth"],
      countryOfBirth: json["country_of_birth"],
      dateOfJoining: json["date_of_joining"],
      lastPromotionDate: json["last_promotion_date"],
      gender: json["gender"],
      qualification: json["qualification"],
      maritalStatus: json["marital_status"],
      nationality: json["nationality"],
      email: json["email"],
      bloodType: json["blood_type"],
      nationalId: json["national_id"],
      manpowerId: json["manpower_id"],
      mobile: json["mobile"],
      officeNumber: json["office_number"],

      department: json["department"],
      category: json["category"],
      directorate: json["directorate"],
      section: json["section"],
      position: json["position"],
      arabicPosition: json["arabic_position"],
      grade: json["grade"],
      location: json["location"],
      supervisorEmpId: json["supervisor_emp_id"],
      supervisorEmpName: json["supervisor_emp_name"],
      passportNumber: json["passport_number"],
      personalEmail: json["personal_email"],
      extensionNumber: json["extension_number"],
      faxNumber: json["fax_number"],
      diplomaticName: json["diplomatic_name"],
      avatar: json["avatar"],
      fatherName: json["father_name"],
      spouseName: json["spouse_name"],
      children1Name: json["children1_name"],
      children2Name: json["children2_name"],
      address: json["address"],
      religion: json["religion"],

      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
      isAdmin: json["is_admin"],
    );
  }
}

class WorkflowRole {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? name;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  WorkflowRole({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory WorkflowRole.fromJson(Map<String, dynamic> json) {
    return WorkflowRole(
      jsonIgnore: (json["jsonIgnore"] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      name: json["name"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
    );
  }
}

class WorkflowDepartment {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  WorkflowDepartment({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory WorkflowDepartment.fromJson(Map<String, dynamic> json) {
    return WorkflowDepartment(
      jsonIgnore: (json["jsonIgnore"] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      departmentName: json["department_name"],
      departmentCode: json["department_code"],
      departmentDescription: json["department_description"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
    );
  }
}

class WorkflowSection {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final int? departmentId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  WorkflowSection({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.sectionName,
    this.sectionCode,
    this.sectionDescription,
    this.departmentId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory WorkflowSection.fromJson(Map<String, dynamic> json) {
    return WorkflowSection(
      jsonIgnore: (json["jsonIgnore"] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      sectionName: json["section_name"],
      sectionCode: json["section_code"],
      sectionDescription: json["section_description"],
      departmentId: json["department_id"] is int
          ? json["department_id"]
          : int.tryParse(json["department_id"] ?? "0"),
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
    );
  }
}
