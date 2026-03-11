import 'dart:convert';

import 'package:code_setup/presentation/models/details_models.dart';

RequestResponse welcomeFromJson(String str) =>
    RequestResponse.fromJson(json.decode(str));

String welcomeToJson(RequestResponse data) => json.encode(data.toJson());

class RequestResponse {
  String? status;
  List<RequestsData>? data;
  int? totalCount;

  RequestResponse({this.status, this.data, this.totalCount});

  factory RequestResponse.fromJson(Map<String, dynamic> json) =>
      RequestResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<RequestsData>.from(
                json["data"].map((x) => RequestsData.fromJson(x)),
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

class RequestsData {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? serviceId;
  int? subServiceId;
  String? problem;
  String? requestFor;
  String? description;
  String? extnNum;
  String? contactNum;
  dynamic email;
  String? requestType;
  dynamic personName;
  dynamic personContactNumber;
  DateTime? requestDate;
  String? status;
  String? workflowExecutionId;
  int? reqUserDepartmentId;
  int? reqUserSectionId;
  int? serviceTypeId;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;
  int? userId;

  User? createdByUser;
  ServiceType? serviceType;
  Service? service;
  Service? subService;
  Department? reqDepartment;
  Section? reqSection;
  List<ApprovalDetailModel>? approvalDetails;

  RequestsData({
    this.jsonIgnore,
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
    this.serviceType,
    this.service,
    this.subService,
    this.reqDepartment,
    this.reqSection,
    this.approvalDetails,
  });

  factory RequestsData.fromJson(Map<String, dynamic> json) => RequestsData(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
    isDeleted: json["is_deleted"],
    id: json["id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    problem: json["problem"],
    requestFor: json["request_for"],
    description: json["description"],
    extnNum: json["extn_num"],
    contactNum: json["contact_num"],
    email: json["email"],
    requestType: json["request_type"],
    personName: json["person_name"],
    personContactNumber: json["person_contact_number"],
    requestDate: json["request_date"] == null
        ? null
        : DateTime.parse(json["request_date"]),
    status: json["status"],
    workflowExecutionId: json["workflow_execution_id"],
    reqUserDepartmentId: json["req_user_department_id"],
    reqUserSectionId: json["req_user_section_id"],
    serviceTypeId: json["service_type_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    createdByUser: json["created_by_user"] == null
        ? null
        : User.fromJson(json["created_by_user"]),
    serviceType: json["service_type"] == null
        ? null
        : ServiceType.fromJson(json["service_type"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    subService: json["sub_service"] == null
        ? null
        : Service.fromJson(json["sub_service"]),
    reqDepartment: json["req_department"] == null
        ? null
        : Department.fromJson(json["req_department"]),
    reqSection: json["req_section"] == null
        ? null
        : Section.fromJson(json["req_section"]),
    approvalDetails: json["approval_details"] == null
        ? []
        : List<ApprovalDetailModel>.from(
            json["approval_details"].map(
              (x) => ApprovalDetailModel.fromJson(x),
            ),
          ),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "problem": problem,
    "request_for": requestFor,
    "description": description,
    "extn_num": extnNum,
    "contact_num": contactNum,
    "email": email,
    "request_type": requestType,
    "person_name": personName,
    "person_contact_number": personContactNumber,
    "request_date": requestDate?.toIso8601String(),
    "status": status,
    "workflow_execution_id": workflowExecutionId,
    "req_user_department_id": reqUserDepartmentId,
    "req_user_section_id": reqUserSectionId,
    "service_type_id": serviceTypeId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "user_id": userId,
    "created_by_user": createdByUser?.toJson(),
    "service_type": serviceType?.toJson(),
    "service": service?.toJson(),
    "sub_service": subService?.toJson(),
    "req_department": reqDepartment?.toJson(),
    "req_section": reqSection?.toJson(),
    "approval_details": approvalDetails == null
        ? []
        : List<dynamic>.from(approvalDetails!.map((x) => x.toJson())),
  };
}

class ApprovalDetail {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? approverUserId;
  int? approverRoleId;
  String? comment;
  String? approvalStatus;
  int? level;
  int? departmentId;
  int? sectionId;
  int? approvedBy;
  int? serviceId;
  int? subServiceId;
  dynamic delegationUserId;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  User? approverUser;
  ApproverRole? approverRole;
  User? approvedByUser;
  Department? department;
  Section? section;

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
    this.serviceId,
    this.subServiceId,
    this.delegationUserId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approverUser,
    this.approverRole,
    this.approvedByUser,
    this.department,
    this.section,
  });

  factory ApprovalDetail.fromJson(Map<String, dynamic> json) => ApprovalDetail(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
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
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    delegationUserId: json["delegation_user_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    approverUser: json["approver_user"] == null
        ? null
        : User.fromJson(json["approver_user"]),
    approverRole: json["approver_role"] == null
        ? null
        : ApproverRole.fromJson(json["approver_role"]),
    approvedByUser: json["approved_by_user"] == null
        ? null
        : User.fromJson(json["approved_by_user"]),
    department: json["department"] == null
        ? null
        : Department.fromJson(json["department"]),
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
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
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "delegation_user_id": delegationUserId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "approver_user": approverUser?.toJson(),
    "approver_role": approverRole?.toJson(),
    "approved_by_user": approvedByUser?.toJson(),
    "department": department?.toJson(),
    "section": section?.toJson(),
  };
}

class ApproverRole {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

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

  factory ApproverRole.fromJson(Map<String, dynamic> json) => ApproverRole(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
    isDeleted: json["is_deleted"],
    id: json["id"],
    name: json["name"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,
    "name": name,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class User {
  List<String>? jsonIgnore;
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

  int? department;
  String? category;
  String? directorate;
  int? section;
  int? position;
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
  String? spouseName;
  String? children1Name;
  String? children2Name;
  String? address;
  String? religion;

  dynamic createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;
  bool? isAdmin;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
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
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    isAdmin: json["is_admin"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
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

    "department": department,
    "category": category,
    "directorate": directorate,
    "section": section,
    "position": position,
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
    "religion": religion,

    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "is_admin": isAdmin,
  };
}

class Department {
  List<String>? jsonIgnore;
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
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
    isDeleted: json["is_deleted"],
    id: json["id"],
    departmentName: json["department_name"],
    departmentCode: json["department_code"],
    departmentDescription: json["department_description"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<String>.from(jsonIgnore!.map((x) => x)),
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

class Section {
  List<String>? jsonIgnore;
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
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
    isDeleted: json["is_deleted"],
    id: json["id"],
    sectionName: json["section_name"],
    sectionCode: json["section_code"],
    sectionDescription: json["section_description"],
    departmentId: json["department_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<String>.from(jsonIgnore!.map((x) => x)),
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

class Service {
  List<String>? jsonIgnore;
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
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
    isDeleted: json["is_deleted"],
    id: json["id"],

    name: json["name"],
    description: json["description"],
    code: json["code"],
    logoUrl: json["logo_url"],

    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),

    subServiceName: json["sub_service_name"],
    serviceId: json["service_id"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<String>.from(jsonIgnore!.map((x) => x)),
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

class ServiceType {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;

  String? name;
  String? nameInArabic;
  int? serviceId;
  int? subServiceId;
  String? description;
  bool? isActive;

  int? departmentId;
  int? sectionId;

  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  ServiceType({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.nameInArabic,
    this.serviceId,
    this.subServiceId,
    this.description,
    this.isActive,
    this.departmentId,
    this.sectionId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
    isDeleted: json["is_deleted"],
    id: json["id"],

    name: json["name"],
    nameInArabic: json["name_in_arabic"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    description: json["description"],
    isActive: json["is_active"],

    departmentId: json["department_id"],
    sectionId: json["section_id"],

    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<String>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,

    "name": name,
    "name_in_arabic": nameInArabic,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "description": description,
    "is_active": isActive,

    "department_id": departmentId,
    "section_id": sectionId,

    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
