import 'package:code_setup/presentation/models/details_models.dart';

class RequestFullResponse {
  final String? status;
  final SalalahRequestDetailData? data;

  RequestFullResponse({this.status, this.data});

  factory RequestFullResponse.fromJson(Map<String, dynamic> json) {
    return RequestFullResponse(
      status: json['status'],
      data: json['data'] != null
          ? SalalahRequestDetailData.fromJson(json['data'])
          : null,
    );
  }
}

class SalalahRequestDetailData {
  final SalalahRequestData? request;
  final List<SalalahWorkflowDetail>? workflowDetails;
  final List<SalalahApprovalDetail>? approvalDetails;
  final List<ChatMessageModel>? chatMessages;
  final List<AttachmentModel>? attachments;

  SalalahRequestDetailData({
    this.request,
    this.workflowDetails,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
  });

  factory SalalahRequestDetailData.fromJson(Map<String, dynamic> json) =>
      SalalahRequestDetailData(
        request: json['request'] != null
            ? SalalahRequestData.fromJson(json['request'])
            : null,
        workflowDetails: json['workflow_details'] != null
            ? List<SalalahWorkflowDetail>.from(
                (json['workflow_details'] as List).map(
                  (x) => SalalahWorkflowDetail.fromJson(x),
                ),
              )
            : null,
        approvalDetails: json['approval_details'] != null
            ? List<SalalahApprovalDetail>.from(
                (json['approval_details'] as List).map(
                  (x) => SalalahApprovalDetail.fromJson(x),
                ),
              )
            : null,
        chatMessages: json['chat_messages'] != null
            ? List<ChatMessageModel>.from(
                (json['chat_messages'] as List).map(
                  (x) => ChatMessageModel.fromJson(x),
                ),
              )
            : null,
        //chatMessages: json['chat_messages'] as List<dynamic>?,
        attachments: json['attachments'] != null
            ? List<AttachmentModel>.from(
                (json['attachments'] as List).map(
                  (x) => AttachmentModel.fromJson(x),
                ),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
    'request': request?.toJson(),
    'workflow_details': workflowDetails?.map((x) => x.toJson()).toList(),
    'approval_details': approvalDetails?.map((x) => x.toJson()).toList(),
    'chat_messages': chatMessages?.map((x) => x.toJson()).toList(),
    'attachments': attachments?.map((x) => x.toJson()).toList(),
  };
}

class SalalahRequestData {
  final int? id;
  final int? serviceId;
  final int? subServiceId;
  final String? problem;
  final String? requestFor;
  final String? description;
  final String? extnNum;
  final String? contactNum;
  final String? requestDate;
  final String? attachmentUrl;
  final String? reportingManager;
  final String? assignedTo;
  final String? status;
  final String? workflowExecutionId;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? serviceTypeId;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;
  final int? userId;

  final User? createdByUser;
  final ServiceType? serviceType;
  final Service? service;
  final SubService? subService;
  final User? reportingManagerUser;
  final User? assignedToUser;

  SalalahRequestData({
    this.id,
    this.serviceId,
    this.subServiceId,
    this.problem,
    this.requestFor,
    this.description,
    this.extnNum,
    this.contactNum,
    this.requestDate,
    this.attachmentUrl,
    this.reportingManager,
    this.assignedTo,
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
    this.reportingManagerUser,
    this.assignedToUser,
  });

  factory SalalahRequestData.fromJson(Map<String, dynamic> json) =>
      SalalahRequestData(
        id: json['id'] as int?,
        serviceId: json['service_id'] as int?,
        subServiceId: json['sub_service_id'] as int?,
        problem: json['problem'] as String?,
        requestFor: json['request_for'] as String?,
        description: json['description'] as String?,
        extnNum: json['extn_num'] as String?,
        contactNum: json['contact_num'] as String?,
        requestDate: json['request_date'] as String?,
        attachmentUrl: json['attachment_url'] as String?,
        reportingManager: json['reporting_manager'] as String?,
        assignedTo: json['assigned_to'] as String?,
        status: json['status'] as String?,
        workflowExecutionId: json['workflow_execution_id'] as String?,
        reqUserDepartmentId: json['req_user_department_id'] as int?,
        reqUserSectionId: json['req_user_section_id'] as int?,
        serviceTypeId: json['service_type_id'] as int?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedBy: json['updated_by'] as int?,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        userId: json['user_id'] as int?,
        createdByUser: json['created_by_user'] != null
            ? User.fromJson(json['created_by_user'])
            : null,
        serviceType: json['service_type'] != null
            ? ServiceType.fromJson(json['service_type'])
            : null,
        service: json['service'] != null
            ? Service.fromJson(json['service'])
            : null,
        subService: json['sub_service'] != null
            ? SubService.fromJson(json['sub_service'])
            : null,
        reportingManagerUser: json['reporting_manager_user'] != null
            ? User.fromJson(json['reporting_manager_user'])
            : null,
        assignedToUser: json['assigned_to_user'] != null
            ? User.fromJson(json['assigned_to_user'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'problem': problem,
    'request_for': requestFor,
    'description': description,
    'extn_num': extnNum,
    'contact_num': contactNum,
    'request_date': requestDate,
    'attachment_url': attachmentUrl,
    'reporting_manager': reportingManager,
    'assigned_to': assignedTo,
    'status': status,
    'workflow_execution_id': workflowExecutionId,
    'req_user_department_id': reqUserDepartmentId,
    'req_user_section_id': reqUserSectionId,
    'service_type_id': serviceTypeId,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
    'user_id': userId,
    'created_by_user': createdByUser?.toJson(),
    'service_type': serviceType?.toJson(),
    'service': service?.toJson(),
    'sub_service': subService?.toJson(),
    'reporting_manager_user': reportingManagerUser?.toJson(),
    'assigned_to_user': assignedToUser?.toJson(),
  };
}

// --- User ---
class User {
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
  final dynamic department;
  final String? category;
  final String? directorate;
  final dynamic section;
  final dynamic position;
  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;
  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? address;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;
  final bool? isAdmin;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    employeeId: json['employee_id'] as String?,
    civilEmployeeId: json['civil_employee_id'] as String?,
    employeeName: json['employee_name'] as String?,
    employeeArabicName: json['employee_arabic_name'] as String?,
    personType: json['person_type'] as String?,
    dateOfBirth: json['date_of_birth'] as String?,
    regionOfBirth: json['region_of_birth'] as String?,
    countryOfBirth: json['country_of_birth'] as String?,
    dateOfJoining: json['date_of_joining'] as String?,
    lastPromotionDate: json['last_promotion_date'] as String?,
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
    position: json['position'],
    arabicPosition: json['arabic_position'] as String?,
    grade: json['grade'] as int?,
    location: json['location'] as String?,
    supervisorEmpId: json['supervisor_emp_id'] as String?,
    supervisorEmpName: json['supervisor_emp_name'] as String?,
    passportNumber: json['passport_number'] as String?,
    personalEmail: json['personal_email'] as String?,
    extensionNumber: json['extension_number'] as int?,
    diplomaticName: json['diplomatic_name'] as String?,
    avatar: json['avatar'] as String?,
    fatherName: json['father_name'] as String?,
    spouseName: json['spouse_name'] as String?,
    children1Name: json['children1_name'] as String?,
    children2Name: json['children2_name'] as String?,
    address: json['address'] as String?,
    createdBy: json['created_by'] as int?,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null,
    updatedBy: json['updated_by'] as int?,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null,
    isAdmin: json['is_admin'] as bool?,
  );

  Map<String, dynamic> toJson() => {
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
    'diplomatic_name': diplomaticName,
    'avatar': avatar,
    'father_name': fatherName,
    'spouse_name': spouseName,
    'children1_name': children1Name,
    'children2_name': children2Name,
    'address': address,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
    'is_admin': isAdmin,
  };
}

// --- ServiceType ---
class ServiceType {
  final int? id;
  final String? name;
  final String? nameInArabic;
  final String? description;
  final int? serviceId;
  final int? subServiceId;
  final bool? isActive;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;

  ServiceType({
    this.id,
    this.name,
    this.nameInArabic,
    this.description,
    this.serviceId,
    this.subServiceId,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    id: json['id'] as int?,
    name: json['name'] as String?,
    nameInArabic: json['name_in_arabic'] as String?,
    description: json['description'] as String?,
    serviceId: json['service_id'] as int?,
    subServiceId: json['sub_service_id'] as int?,
    isActive: json['is_active'] as bool?,
    createdBy: json['created_by'] as int?,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null,
    updatedBy: json['updated_by'] as int?,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_in_arabic': nameInArabic,
    'description': description,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'is_active': isActive,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
  };
}

// --- Service ---
class Service {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final String? logoUrl;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;

  Service({
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

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    code: json['code'] as String?,
    logoUrl: json['logo_url'] as String?,
    createdBy: json['created_by'] as int?,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null,
    updatedBy: json['updated_by'] as int?,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'code': code,
    'logo_url': logoUrl,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
  };
}

// --- SubService ---
class SubService {
  final int? id;
  final String? subServiceName;
  final String? description;
  final int? serviceId;
  final String? logoUrl;
  final String? code;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;

  SubService({
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

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
    id: json['id'] as int?,
    subServiceName: json['sub_service_name'] as String?,
    description: json['description'] as String?,
    serviceId: json['service_id'] as int?,
    logoUrl: json['logo_url'] as String?,
    code: json['code'] as String?,
    createdBy: json['created_by'] as int?,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null,
    updatedBy: json['updated_by'] as int?,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_service_name': subServiceName,
    'description': description,
    'service_id': serviceId,
    'logo_url': logoUrl,
    'code': code,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
  };
}

// --- WorkflowDetail ---
class SalalahWorkflowDetail {
  final int? id;
  final int? requestId;
  final String? content;
  final String? status;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;

  SalalahWorkflowDetail({
    this.id,
    this.requestId,
    this.content,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory SalalahWorkflowDetail.fromJson(Map<String, dynamic> json) =>
      SalalahWorkflowDetail(
        id: json['id'] as int?,
        requestId: json['request_id'] as int?,
        content: json['content'] as String?,
        status: json['status'] as String?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedBy: json['updated_by'] as int?,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'content': content,
    'status': status,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
  };
}

// --- ApprovalDetail ---
class SalalahApprovalDetail {
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
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;
  final User? approverUser;
  final dynamic approverRole;
  final User? approvedByUser;

  SalalahApprovalDetail({
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
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approverUser,
    this.approverRole,
    this.approvedByUser,
  });

  factory SalalahApprovalDetail.fromJson(Map<String, dynamic> json) =>
      SalalahApprovalDetail(
        id: json['id'] as int?,
        requestId: json['request_id'] as int?,
        approverUserId: json['approver_user_id'] as int?,
        approverRoleId: json['approver_role_id'] as int?,
        comment: json['comment'] as String?,
        approvalStatus: json['approval_status'] as String?,
        level: json['level'] as int?,
        departmentId: json['department_id'] as int?,
        sectionId: json['section_id'] as int?,
        approvedBy: json['approved_by'] as int?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedBy: json['updated_by'] as int?,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        approverUser: json['approver_user'] != null
            ? User.fromJson(json['approver_user'])
            : null,
        approverRole: json['approver_role'],
        approvedByUser: json['approved_by_user'] != null
            ? User.fromJson(json['approved_by_user'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'approver_user_id': approverUserId,
    'approver_role_id': approverRoleId,
    'comment': comment,
    'approval_status': approvalStatus,
    'level': level,
    'department_id': departmentId,
    'section_id': sectionId,
    'approved_by': approvedBy,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
    'approver_user': approverUser?.toJson(),
    'approver_role': approverRole,
    'approved_by_user': approvedByUser?.toJson(),
  };
}

// Make sure your User class is defined as per your previous complete User model
