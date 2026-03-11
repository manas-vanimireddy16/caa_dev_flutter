// Root model – whole response object
import 'package:code_setup/presentation/models/details_models.dart';

class ThreatRequestListResponse {
  final String? status;
  final List<ThreatRequestDetail> data;
  final int? totalCount;

  ThreatRequestListResponse({
    this.status,
    this.data = const [],
    this.totalCount,
  });

  factory ThreatRequestListResponse.fromJson(Map<String, dynamic> json) {
    return ThreatRequestListResponse(
      status: json['status'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ThreatRequestDetail.fromJson(e))
              .toList() ??
          [],
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
    'total_count': totalCount,
  };
}

class ThreatRequestDetail {
  final bool? isDeleted;
  final int? id;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? serviceId;
  final int? subServiceId;
  final int? userId;
  final int? typeOfThreat;
  final String? description;
  final String? contactNumber;
  final String? priority;
  final String? status;
  final String? workflowExecutionId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final UserModel? createdByUser;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;
  final ServiceModel? service;
  final SubServiceModel? subService;
  final List<ChatMessageModel> chatMessages;
  final List<dynamic> attachments; // structure not given
  final List<WorkflowLogModel> workflowLogs;
  final List<ApprovalDetailModel> approvalDetails;

  ThreatRequestDetail({
    this.isDeleted,
    this.id,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.typeOfThreat,
    this.description,
    this.contactNumber,
    this.priority,
    this.status,
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
    this.chatMessages = const [],
    this.attachments = const [],
    this.workflowLogs = const [],
    this.approvalDetails = const [],
  });

  factory ThreatRequestDetail.fromJson(Map<String, dynamic> json) {
    return ThreatRequestDetail(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      reqUserDepartmentId: json['req_user_department_id'] as int?,
      reqUserSectionId: json['req_user_section_id'] as int?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      userId: json['user_id'] as int?,
      typeOfThreat: json['type_of_threat'] as int?,
      description: json['description'] as String?,
      contactNumber: json['contact_number'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      workflowExecutionId: json['workflow_execution_id'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
      createdByUser: json['created_by_user'] != null
          ? UserModel.fromJson(json['created_by_user'])
          : null,
      reqDepartment: json['req_department'] != null
          ? DepartmentModel.fromJson(json['req_department'])
          : null,
      reqSection: json['req_section'] != null
          ? SectionModel.fromJson(json['req_section'])
          : null,
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,
      subService: json['sub_service'] != null
          ? SubServiceModel.fromJson(json['sub_service'])
          : null,
      chatMessages:
          (json['chat_messages'] as List<dynamic>?)
              ?.map((e) => ChatMessageModel.fromJson(e))
              .toList() ??
          [],
      attachments: json['attachments'] as List<dynamic>? ?? [],
      workflowLogs:
          (json['workflow_logs'] as List<dynamic>?)
              ?.map((e) => WorkflowLogModel.fromJson(e))
              .toList() ??
          [],
      approvalDetails:
          (json['approval_details'] as List<dynamic>?)
              ?.map((e) => ApprovalDetailModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_deleted': isDeleted,
      'id': id,
      'req_user_department_id': reqUserDepartmentId,
      'req_user_section_id': reqUserSectionId,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'user_id': userId,
      'type_of_threat': typeOfThreat,
      'description': description,
      'contact_number': contactNumber,
      'priority': priority,
      'status': status,
      'workflow_execution_id': workflowExecutionId,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'created_by_user': createdByUser?.toJson(),
      'req_department': reqDepartment?.toJson(),
      'req_section': reqSection?.toJson(),
      'service': service?.toJson(),
      'sub_service': subService?.toJson(),
      'chat_messages': chatMessages.map((e) => e.toJson()).toList(),
      'attachments': attachments,
      'workflow_logs': workflowLogs.map((e) => e.toJson()).toList(),
      'approval_details': approvalDetails.map((e) => e.toJson()).toList(),
    };
  }
}

/// ---------- COMMON SMALL MODELS ----------

class DepartmentModel {
  final bool? isDeleted;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  DepartmentModel({
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

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
      departmentDescription: json['department_description'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'department_name': departmentName,
    'department_code': departmentCode,
    'department_description': departmentDescription,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}

class SectionModel {
  final bool? isDeleted;
  final int? id;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final String? departmentId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  SectionModel({
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

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      sectionName: json['section_name'] as String?,
      sectionCode: json['section_code'] as String?,
      sectionDescription: json['section_description'] as String?,
      departmentId: json['department_id']?.toString(),
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'section_name': sectionName,
    'section_code': sectionCode,
    'section_description': sectionDescription,
    'department_id': departmentId,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}

class ServiceModel {
  final bool? isDeleted;
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final String? logoUrl;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  ServiceModel({
    this.isDeleted,
    this.id,
    this.name,
    this.description,
    this.code,
    this.logoUrl,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      logoUrl: json['logo_url'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'name': name,
    'description': description,
    'code': code,
    'logo_url': logoUrl,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}

class SubServiceModel {
  final bool? isDeleted;
  final int? id;
  final String? subServiceName;
  final String? description;
  final int? serviceId;
  final String? logoUrl;
  final String? code;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  SubServiceModel({
    this.isDeleted,
    this.id,
    this.subServiceName,
    this.description,
    this.serviceId,
    this.logoUrl,
    this.code,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory SubServiceModel.fromJson(Map<String, dynamic> json) {
    return SubServiceModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      subServiceName: json['sub_service_name'] as String?,
      description: json['description'] as String?,
      serviceId: json['service_id'] as int?,
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'sub_service_name': subServiceName,
    'description': description,
    'service_id': serviceId,
    'logo_url': logoUrl,
    'code': code,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}

/// NOTE: backend is inconsistent – sometimes `department` / `section` are IDs,
/// sometimes full objects. So we keep them as `dynamic`.
class UserModel {
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
  final dynamic department; // can be int or DepartmentModel JSON
  final String? category;
  final String? directorate;
  final dynamic section; // can be int or SectionModel JSON
  final int? position;
  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;
  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final dynamic faxNumber;
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      employeeId: json['employee_id'] as String?,
      civilEmployeeId: json['civil_employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      employeeArabicName: json['employee_arabic_name'] as String?,
      personType: json['person_type'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      regionOfBirth: json['region_of_birth'] as String?,
      countryOfBirth: json['country_of_birth'] as String?,
      dateOfJoining: json['date_of_joining']?.toString(),
      lastPromotionDate: json['last_promotion_date']?.toString(),
      gender: json['gender'] as String?,
      qualification: json['qualification'] as String?,
      maritalStatus: json['marital_status'] as String?,
      nationality: json['nationality'] as String?,
      email: json['email'] as String?,
      bloodType: json['blood_type'] as String?,
      nationalId: json['national_id'] as String?,
      manpowerId: json['manpower_id'] as String?,
      mobile: json['mobile'] as String?,
      officeNumber: json['office_number'] as String?,
      department: json['department'],
      category: json['category'] as String?,
      directorate: json['directorate'] as String?,
      section: json['section'],
      position: json['position'] as int?,
      arabicPosition: json['arabic_position'] as String?,
      grade: json['grade'] as int?,
      location: json['location'] as String?,
      supervisorEmpId: json['supervisor_emp_id'] as String?,
      supervisorEmpName: json['supervisor_emp_name'] as String?,
      passportNumber: json['passport_number'] as String?,
      personalEmail: json['personal_email'] as String?,
      extensionNumber: json['extension_number'] as int?,
      faxNumber: json['fax_number'],
      diplomaticName: json['diplomatic_name'] as String?,
      avatar: json['avatar'] as String?,
      fatherName: json['father_name'] as String?,
      spouseName: json['spouse_name'] as String?,
      children1Name: json['children1_name'] as String?,
      children2Name: json['children2_name'] as String?,
      address: json['address'] as String?,
      religion: json['religion'],
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
      isAdmin: json['is_admin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'employee_id': employeeId,
    'civil_employee_id': civilEmployeeId,
    'employee_name': employeeName,
    'employee_arabic_name': employeeArabicName,
    'person_type': personType,
    'date_of_birth': dateOfBirth,
    'region_of_birth': regionOfBirth,
    'country_of_birth': countryOfBirth,
    'date_of_joining': dateOfJoining,
    'last_promotion_date': lastPromotionDate,
    'gender': gender,
    'qualification': qualification,
    'marital_status': maritalStatus,
    'nationality': nationality,
    'email': email,
    'blood_type': bloodType,
    'national_id': nationalId,
    'manpower_id': manpowerId,
    'mobile': mobile,
    'office_number': officeNumber,
    'department': department,
    'category': category,
    'directorate': directorate,
    'section': section,
    'position': position,
    'arabic_position': arabicPosition,
    'grade': grade,
    'location': location,
    'supervisor_emp_id': supervisorEmpId,
    'supervisor_emp_name': supervisorEmpName,
    'passport_number': passportNumber,
    'personal_email': personalEmail,
    'extension_number': extensionNumber,
    'fax_number': faxNumber,
    'diplomatic_name': diplomaticName,
    'avatar': avatar,
    'father_name': fatherName,
    'spouse_name': spouseName,
    'children1_name': children1Name,
    'children2_name': children2Name,
    'address': address,
    'religion': religion,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'is_admin': isAdmin,
  };
}

/// ---------- CHAT ----------

class ChatMessageModel {
  final bool? isDeleted;
  final int? id;
  final int? requestId;
  final int? serviceId;
  final int? subServiceId;
  final int? userId;
  final int? roleId;
  final String? message;
  final String? messageType;
  final String? status;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final UserModel? user;

  ChatMessageModel({
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.roleId,
    this.message,
    this.messageType,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.user,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      requestId: json['request_id'] as int?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      userId: json['user_id'] as int?,
      roleId: json['role_id'] as int?,
      message: json['message'] as String?,
      messageType: json['messageType'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'user_id': userId,
    'role_id': roleId,
    'message': message,
    'messageType': messageType,
    'status': status,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'user': user?.toJson(),
  };
}

/// ---------- WORKFLOW LOGS ----------

class WorkflowLogModel {
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
  final UserModel? user;
  final RoleModel? role;
  final DepartmentModel? department;
  final SectionModel? section;

  WorkflowLogModel({
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

  factory WorkflowLogModel.fromJson(Map<String, dynamic> json) {
    return WorkflowLogModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      requestId: json['request_id'] as int?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      content: json['content'] as String?,
      status: json['status'] as String?,
      userId: json['user_id'] as int?,
      roleId: json['role_id'] as int?,
      departmentId: json['department_id'] as int?,
      sectionId: json['section_id'] as int?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      department: json['department'] != null
          ? DepartmentModel.fromJson(json['department'])
          : null,
      section: json['section'] != null
          ? SectionModel.fromJson(json['section'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'content': content,
    'status': status,
    'user_id': userId,
    'role_id': roleId,
    'department_id': departmentId,
    'section_id': sectionId,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'user': user?.toJson(),
    'role': role?.toJson(),
    'department': department?.toJson(),
    'section': section?.toJson(),
  };
}

class RoleModel {
  final bool? isDeleted;
  final int? id;
  final String? name;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  RoleModel({
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'name': name,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}

/// ---------- APPROVAL DETAILS ----------
