class SalalahActionItem {
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
  int? delegationUserId;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  SalalahActionItemUser? approverUser;
  SalalahActionItemUser? approvedByUser;
  SalalahActionItemUser? delegationUser;
  SalalahActionItemApprovalRole? approverRole;

  SalalahActionItemDepartment? department;
  SalalahActionItemSection? section;

  SalalahActionItemRequest? request;

  SalalahActionItem({
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
    this.delegationUser,
    this.department,
    this.section,
    this.request,
  });

  factory SalalahActionItem.fromJson(Map<String, dynamic> json) =>
      SalalahActionItem(
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

        // nested objects
        approverUser: json["approver_user"] == null
            ? null
            : SalalahActionItemUser.fromJson(json["approver_user"]),

        approvedByUser: json["approved_by_user"] == null
            ? null
            : SalalahActionItemUser.fromJson(json["approved_by_user"]),

        delegationUser: json["delegation_user"] == null
            ? null
            : SalalahActionItemUser.fromJson(json["delegation_user"]),

        approverRole: json["approver_role"] == null
            ? null
            : SalalahActionItemApprovalRole.fromJson(json["approver_role"]),

        department: json["department"] == null
            ? null
            : SalalahActionItemDepartment.fromJson(json["department"]),

        section: json["section"] == null
            ? null
            : SalalahActionItemSection.fromJson(json["section"]),

        request: json["request"] == null
            ? null
            : SalalahActionItemRequest.fromJson(json["request"]),
      );
}

class SalalahActionItemUser {
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
  String? faxNumber;
  String? diplomaticName;
  String? avatar;
  String? fatherName;
  String? spouseName;
  String? children1Name;
  String? children2Name;
  String? address;
  String? religion;

  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  bool? isAdmin;

  SalalahActionItemUser({
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

  factory SalalahActionItemUser.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemUser(
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
}

class SalalahActionItemApprovalRole {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  SalalahActionItemApprovalRole({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory SalalahActionItemApprovalRole.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemApprovalRole(
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
}

class SalalahActionItemDepartment {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? departmentName;
  String? departmentCode;
  String? departmentDescription;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  SalalahActionItemDepartment({
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

  factory SalalahActionItemDepartment.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemDepartment(
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
}

class SalalahActionItemSection {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? sectionName;
  String? sectionCode;
  String? sectionDescription;
  String? departmentId;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  SalalahActionItemSection({
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

  factory SalalahActionItemSection.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemSection(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
        isDeleted: json["is_deleted"],
        id: json["id"],
        sectionName: json["section_name"],
        sectionCode: json["section_code"],
        sectionDescription: json["section_description"],
        departmentId: json["department_id"]?.toString(),
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class SalalahActionItemRequest {
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
  String? email;
  String? requestType;
  String? personName;
  String? personContactNumber;
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

  /// Nested objects
  SalalahActionItemUser? createdByUser;
  SalalahActionItemReqServiceType? serviceType;
  SalalahActionItemDepartment? reqDepartment;
  SalalahActionItemSection? reqSection;
  SalalahActionItemReqService? service;
  SalalahActionItemReqService? subService;

  SalalahActionItemRequest({
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
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
  });

  factory SalalahActionItemRequest.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemRequest(
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
            : DateTime.tryParse(json["request_date"]),
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
            : SalalahActionItemUser.fromJson(json["created_by_user"]),

        serviceType: json["service_type"] == null
            ? null
            : SalalahActionItemReqServiceType.fromJson(json["service_type"]),

        reqDepartment: json["req_department"] == null
            ? null
            : SalalahActionItemDepartment.fromJson(json["req_department"]),

        reqSection: json["req_section"] == null
            ? null
            : SalalahActionItemSection.fromJson(json["req_section"]),

        service: json["service"] == null
            ? null
            : SalalahActionItemReqService.fromJson(json["service"]),

        subService: json["sub_service"] == null
            ? null
            : SalalahActionItemReqService.fromJson(json["sub_service"]),
      );
}

class SalalahActionItemReqService {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  String? nameInArabic;
  bool? isActive;

  SalalahActionItemReqService({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.nameInArabic,
    this.isActive,
  });

  factory SalalahActionItemReqService.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemReqService(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),
        isDeleted: json["is_deleted"],
        id: json["id"],
        name: json["name"],
        nameInArabic: json["name_in_arabic"],
        isActive: json["is_active"],
      );
}

class SalalahActionItemReqServiceType {
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
  int? updatedBy;
  DateTime? updatedAt;

  SalalahActionItemReqServiceType({
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

  factory SalalahActionItemReqServiceType.fromJson(Map<String, dynamic> json) =>
      SalalahActionItemReqServiceType(
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
}
