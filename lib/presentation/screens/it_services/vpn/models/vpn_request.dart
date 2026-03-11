import 'dart:convert';

VpnRequestModel welcomeFromJson(String str) =>
    VpnRequestModel.fromJson(json.decode(str));
String welcomeToJson(VpnRequestModel data) => json.encode(data.toJson());

class VpnRequestModel {
  String? status;
  List<VpnRequestData>? data;
  int? totalCount;

  VpnRequestModel({this.status, this.data, this.totalCount});

  factory VpnRequestModel.fromJson(Map<String, dynamic> json) =>
      VpnRequestModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<VpnRequestData>.from(
                json["data"].map((x) => VpnRequestData.fromJson(x)),
              ),
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}

// -----------------------------------------------------------------------------
// VpnRequestData
// -----------------------------------------------------------------------------
class VpnRequestData {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  String? jobTitle;
  dynamic reqUserDepartmentId;
  dynamic reqUserSectionId;
  dynamic reqUserPositionId;
  int? serviceId;
  int? subServiceId;
  int? userId;
  String? requestFor;
  String? employeeIdentifier;
  String? employeeEmail;
  String? phoneNumber;
  List<String>? reasonForRequest;
  String? description;
  List<String>? systemsToAccess;
  dynamic sourceIpType;
  dynamic sourceIpAddress;
  String? country;
  DateTime? startDate;
  DateTime? endDate;
  String? accessType;
  List<String>? deviceType;
  bool? acknowledgement;
  String? status;
  dynamic reviewerUserId;
  dynamic assignedToUserId;
  dynamic assignedAt;
  String? workflowExecutionId;
  CreatedByUser? createdByUser;
  dynamic reqDepartment;
  dynamic reqSection;
  Service? service;
  Service? subService;
  List<dynamic>? chatMessages;
  List<dynamic>? attachments;
  List<WorkflowLog>? workflowLogs;
  List<ApprovalDetail>? approvalDetails;

  VpnRequestData({
    this.jsonIgnore,
    this.isDeleted,
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
    this.workflowExecutionId,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
    this.chatMessages,
    this.attachments,
    this.workflowLogs,
    this.approvalDetails,
  });

  factory VpnRequestData.fromJson(Map<String, dynamic> json) => VpnRequestData(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
    jobTitle: json["job_title"],
    reqUserDepartmentId: json["req_user_department_id"],
    reqUserSectionId: json["req_user_section_id"],
    reqUserPositionId: json["req_user_position_id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    userId: json["user_id"],
    requestFor: json["request_for"],
    employeeIdentifier: json["employee_identifier"],
    employeeEmail: json["employee_email"],
    phoneNumber: json["phone_number"],
    reasonForRequest: json["reason_for_request"] == null
        ? []
        : List<String>.from(json["reason_for_request"].map((x) => x)),
    description: json["description"],
    systemsToAccess: json["systems_to_access"] == null
        ? []
        : List<String>.from(json["systems_to_access"].map((x) => x)),
    sourceIpType: json["source_ip_type"],
    sourceIpAddress: json["source_ip_address"],
    country: json["country"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.tryParse(json["start_date"]),
    endDate: json["end_date"] == null
        ? null
        : DateTime.tryParse(json["end_date"]),
    accessType: json["access_type"],
    deviceType: json["device_type"] == null
        ? []
        : List<String>.from(json["device_type"].map((x) => x)),
    acknowledgement: json["acknowledgement"],
    status: json["status"],
    reviewerUserId: json["reviewer_user_id"],
    assignedToUserId: json["assigned_to_user_id"],
    assignedAt: json["assigned_at"],
    workflowExecutionId: json["workflow_execution_id"],
    createdByUser: json["created_by_user"] == null
        ? null
        : CreatedByUser.fromJson(json["created_by_user"]),
    reqDepartment: json["req_department"],
    reqSection: json["req_section"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    subService: json["sub_service"] == null
        ? null
        : Service.fromJson(json["sub_service"]),
    chatMessages: json["chat_messages"] == null
        ? []
        : List<dynamic>.from(json["chat_messages"]),
    attachments: json["attachments"] == null
        ? []
        : List<dynamic>.from(json["attachments"]),
    workflowLogs: json["workflow_logs"] == null
        ? []
        : List<WorkflowLog>.from(
            json["workflow_logs"].map((x) => WorkflowLog.fromJson(x)),
          ),
    approvalDetails: json["approval_details"] == null
        ? []
        : List<ApprovalDetail>.from(
            json["approval_details"].map((x) => ApprovalDetail.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "job_title": jobTitle,
    "req_user_department_id": reqUserDepartmentId,
    "req_user_section_id": reqUserSectionId,
    "req_user_position_id": reqUserPositionId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "user_id": userId,
    "request_for": requestFor,
    "employee_identifier": employeeIdentifier,
    "employee_email": employeeEmail,
    "phone_number": phoneNumber,
    "reason_for_request": reasonForRequest == null
        ? []
        : List<dynamic>.from(reasonForRequest!),
    "description": description,
    "systems_to_access": systemsToAccess == null
        ? []
        : List<dynamic>.from(systemsToAccess!),
    "source_ip_type": sourceIpType,
    "source_ip_address": sourceIpAddress,
    "country": country,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "access_type": accessType,
    "device_type": deviceType == null ? [] : List<dynamic>.from(deviceType!),
    "acknowledgement": acknowledgement,
    "status": status,
    "reviewer_user_id": reviewerUserId,
    "assigned_to_user_id": assignedToUserId,
    "assigned_at": assignedAt,
    "workflow_execution_id": workflowExecutionId,
    "created_by_user": createdByUser?.toJson(),
    "req_department": reqDepartment,
    "req_section": reqSection,
    "service": service?.toJson(),
    "sub_service": subService?.toJson(),
    "chat_messages": chatMessages == null
        ? []
        : List<dynamic>.from(chatMessages!),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!),
    "workflow_logs": workflowLogs == null
        ? []
        : List<dynamic>.from(workflowLogs!.map((x) => x.toJson())),
    "approval_details": approvalDetails == null
        ? []
        : List<dynamic>.from(approvalDetails!.map((x) => x.toJson())),
  };
}

// -----------------------------------------------------------------------------
// Remaining Classes
// -----------------------------------------------------------------------------

class ApprovalDetail {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  dynamic approverUserId;
  int? approverRoleId;
  String? comment;
  String? approvalStatus;
  int? level;
  dynamic departmentId;
  dynamic sectionId;
  dynamic approvedBy;
  bool? isManager;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  Position? approverRole;
  dynamic approverUser;
  dynamic approvedByUser;

  ApprovalDetail({
    this.jsonIgnore,
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
    this.isManager,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approverRole,
    this.approverUser,
    this.approvedByUser,
  });

  factory ApprovalDetail.fromJson(Map<String, dynamic> json) => ApprovalDetail(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    requestId: json["request_id"],
    approverUserId: json["approver_user_id"],
    approverRoleId: json["approver_role_id"],
    comment: json["comment"],
    approvalStatus: json["approval_status"],
    level: json["level"],
    departmentId: json["department_id"],
    sectionId: json["section_id"],
    approvedBy: json["approved_by"],
    isManager: json["is_manager"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
    approverRole: json["approver_role"] == null
        ? null
        : Position.fromJson(json["approver_role"]),
    approverUser: json["approver_user"],
    approvedByUser: json["approved_by_user"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "request_id": requestId,
    "approver_user_id": approverUserId,
    "approver_role_id": approverRoleId,
    "comment": comment,
    "approval_status": approvalStatus,
    "level": level,
    "department_id": departmentId,
    "section_id": sectionId,
    "approved_by": approvedBy,
    "is_manager": isManager,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "approver_role": approverRole?.toJson(),
    "approver_user": approverUser,
    "approved_by_user": approvedByUser,
  };
}

// -----------------------------------------------------------------------------
// POSITION
// -----------------------------------------------------------------------------
class Position {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  Position({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    name: json["name"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "name": name,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

// -----------------------------------------------------------------------------
// CREATED BY USER
// -----------------------------------------------------------------------------
class CreatedByUser {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? employeeId;
  String? civilEmployeeId;
  String? employeeName;
  String? employeeArabicName;
  String? personType;
  String? dateOfBirth;
  String? regionOfBirth;
  String? countryOfBirth;
  String? dateOfJoining;
  String? lastPromotionDate;
  String? gender;
  String? qualification;
  String? maritalStatus;
  String? nationality;
  String? email;
  String? bloodType;
  String? nationalId;
  String? manpowerId;
  String? mobile;
  String? officeNumber;
  Department? department;
  String? category;
  String? directorate;
  Section? section;
  Position? position;
  String? arabicPosition;
  int? grade;
  String? location;
  String? supervisorEmpId;
  String? supervisorEmpName;
  String? passportNumber;
  String? personalEmail;
  int? extensionNumber;
  dynamic faxNumber;
  String? diplomaticName;
  String? avatar;
  String? fatherName;
  dynamic spouseName;
  dynamic children1Name;
  dynamic children2Name;
  dynamic address;
  dynamic createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  bool? isAdmin;

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
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isAdmin,
  });

  factory CreatedByUser.fromJson(Map<String, dynamic> json) => CreatedByUser(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
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
    department: json["department"] == null
        ? null
        : Department.fromJson(json["department"]),
    category: json["category"],
    directorate: json["directorate"],
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
    position: json["position"] == null
        ? null
        : Position.fromJson(json["position"]),
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
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
    isAdmin: json["is_admin"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "employee_id": employeeId,
    "civil_employee_id": civilEmployeeId,
    "employee_name": employeeName,
    "employee_arabic_name": employeeArabicName,
    "person_type": personType,
    "date_of_birth": dateOfBirth,
    "region_of_birth": regionOfBirth,
    "country_of_birth": countryOfBirth,
    "date_of_joining": dateOfJoining,
    "last_promotion_date": lastPromotionDate,
    "gender": gender,
    "qualification": qualification,
    "marital_status": maritalStatus,
    "nationality": nationality,
    "email": email,
    "blood_type": bloodType,
    "national_id": nationalId,
    "manpower_id": manpowerId,
    "mobile": mobile,
    "office_number": officeNumber,
    "department": department?.toJson(),
    "category": category,
    "directorate": directorate,
    "section": section?.toJson(),
    "position": position?.toJson(),
    "arabic_position": arabicPosition,
    "grade": grade,
    "location": location,
    "supervisor_emp_id": supervisorEmpId,
    "supervisor_emp_name": supervisorEmpName,
    "passport_number": passportNumber,
    "personal_email": personalEmail,
    "extension_number": extensionNumber,
    "fax_number": faxNumber,
    "diplomatic_name": diplomaticName,
    "avatar": avatar,
    "father_name": fatherName,
    "spouse_name": spouseName,
    "children1_name": children1Name,
    "children2_name": children2Name,
    "address": address,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "is_admin": isAdmin,
  };
}

// -----------------------------------------------------------------------------
// DEPARTMENT
// -----------------------------------------------------------------------------
class Department {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? departmentName;
  String? departmentCode;
  String? departmentDescription;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  Department({
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

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    departmentName: json["department_name"],
    departmentCode: json["department_code"],
    departmentDescription: json["department_description"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "department_name": departmentName,
    "department_code": departmentCode,
    "department_description": departmentDescription,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

// -----------------------------------------------------------------------------
// SECTION
// -----------------------------------------------------------------------------
class Section {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? sectionName;
  String? sectionCode;
  String? sectionDescription;
  String? departmentId;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  Section({
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

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    sectionName: json["section_name"],
    sectionCode: json["section_code"],
    sectionDescription: json["section_description"],
    departmentId: json["department_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "section_name": sectionName,
    "section_code": sectionCode,
    "section_description": sectionDescription,
    "department_id": departmentId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

// -----------------------------------------------------------------------------
// SERVICE
// -----------------------------------------------------------------------------
class Service {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  String? description;
  String? code;
  String? logoUrl;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  String? subServiceName;
  int? serviceId;

  Service({
    this.jsonIgnore,
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
    this.subServiceName,
    this.serviceId,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    name: json["name"],
    description: json["description"],
    code: json["code"],
    logoUrl: json["logo_url"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
    subServiceName: json["sub_service_name"],
    serviceId: json["service_id"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "name": name,
    "description": description,
    "code": code,
    "logo_url": logoUrl,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "sub_service_name": subServiceName,
    "service_id": serviceId,
  };
}

// -----------------------------------------------------------------------------
// WORKFLOW LOG
// -----------------------------------------------------------------------------
class WorkflowLog {
  List<dynamic>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  String? content;
  String? status;
  int? order;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  WorkflowLog({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.content,
    this.status,
    this.order,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory WorkflowLog.fromJson(Map<String, dynamic> json) => WorkflowLog(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<dynamic>.from(json["jsonIgnore"]),
    isDeleted: json["is_deleted"],
    id: json["id"],
    requestId: json["request_id"],
    content: json["content"],
    status: json["status"],
    order: json["order"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null ? [] : List<dynamic>.from(jsonIgnore!),
    "is_deleted": isDeleted,
    "id": id,
    "request_id": requestId,
    "content": content,
    "status": status,
    "order": order,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
