// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RequestDetailModel welcomeFromJson(String str) =>
    RequestDetailModel.fromJson(json.decode(str));

String welcomeToJson(RequestDetailModel data) => json.encode(data.toJson());

class RequestDetailModel {
  String? status;
  RequestDetailData? data;

  RequestDetailModel({this.status, this.data});

  factory RequestDetailModel.fromJson(Map<String, dynamic> json) =>
      RequestDetailModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : RequestDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class RequestDetailData {
  Request? request;
  List<Workflow>? workflowDetails;
  List<ApprovalDetails>? approvalDetails;
  List<ChatMessage>? chatMessages;
  List<AttachmentDetail>? attachments;

  RequestDetailData({
    this.request,
    this.workflowDetails,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
  });

  factory RequestDetailData.fromJson(
    Map<String, dynamic> json,
  ) => RequestDetailData(
    request: json["request"] == null ? null : Request.fromJson(json["request"]),
    workflowDetails: json["workflow_details"] == null
        ? []
        : List<Workflow>.from(
            json["workflow_details"]!.map((x) => Workflow.fromJson(x)),
          ),
    approvalDetails: json["approval_details"] == null
        ? []
        : List<ApprovalDetails>.from(
            json["approval_details"]!.map((x) => ApprovalDetails.fromJson(x)),
          ),
    chatMessages: json["chat_messages"] == null
        ? []
        : List<ChatMessage>.from(
            json["chat_messages"]!.map((x) => ChatMessage.fromJson(x)),
          ),
    attachments: json["attachments"] == null
        ? []
        : List<AttachmentDetail>.from(
            json["attachments"]!.map((x) => AttachmentDetail.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "request": request?.toJson(),
    "workflow_details": workflowDetails == null
        ? []
        : List<dynamic>.from(workflowDetails!.map((x) => x.toJson())),
    "approval_details": approvalDetails == null
        ? []
        : List<dynamic>.from(approvalDetails!.map((x) => x.toJson())),
    "chat_messages": chatMessages == null
        ? []
        : List<dynamic>.from(chatMessages!.map((x) => x.toJson())),
    "attachments": attachments == null
        ? []
        : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class ApprovalDetails {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  int? approverRoleId;
  String? comment;
  String? approvalStatus;
  int? level;
  int? departmentId;
  int? sectionId;
  dynamic approverUserId;
  dynamic delegateUserId;
  dynamic approvedBy;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  ApproverRole? approverRole;
  dynamic approverUser;
  dynamic delegateUser;
  dynamic approvedByUser;

  ApprovalDetails({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.approverRoleId,
    this.comment,
    this.approvalStatus,
    this.level,
    this.departmentId,
    this.sectionId,
    this.approverUserId,
    this.delegateUserId,
    this.approvedBy,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approverRole,
    this.approverUser,
    this.delegateUser,
    this.approvedByUser,
  });

  factory ApprovalDetails.fromJson(Map<String, dynamic> json) =>
      ApprovalDetails(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
        isDeleted: json["is_deleted"],
        id: json["id"],
        requestId: json["request_id"],
        serviceId: json["service_id"],
        subServiceId: json["sub_service_id"],
        approverRoleId: json["approver_role_id"],
        comment: json["comment"],
        approvalStatus: json["approval_status"],
        level: json["level"],
        departmentId: json["department_id"],
        sectionId: json["section_id"],
        approverUserId: json["approver_user_id"],
        delegateUserId: json["delegate_user_id"],
        approvedBy: json["approved_by"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        approverRole: json["approver_role"] == null
            ? null
            : ApproverRole.fromJson(json["approver_role"]),
        approverUser: json["approver_user"],
        delegateUser: json["delegate_user"],
        approvedByUser: json["approved_by_user"],
      );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,
    "request_id": requestId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "approver_role_id": approverRoleId,
    "comment": comment,
    "approval_status": approvalStatus,
    "level": level,
    "department_id": departmentId,
    "section_id": sectionId,
    "approver_user_id": approverUserId,
    "delegate_user_id": delegateUserId,
    "approved_by": approvedBy,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "approver_role": approverRole?.toJson(),
    "approver_user": approverUser,
    "delegate_user": delegateUser,
    "approved_by_user": approvedByUser,
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
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
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

class AttachmentDetail {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  String? fileUrl;
  String? fileName;
  String? fileType;
  String? fileSize;
  dynamic chatId;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  AttachmentDetail({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.fileSize,
    this.chatId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory AttachmentDetail.fromJson(Map<String, dynamic> json) =>
      AttachmentDetail(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
        isDeleted: json["is_deleted"],
        id: json["id"],
        requestId: json["request_id"],
        serviceId: json["service_id"],
        subServiceId: json["sub_service_id"],
        fileUrl: json["file_url"],
        fileName: json["file_name"],
        fileType: json["file_type"],
        fileSize: json["file_size"],
        chatId: json["chat_id"],
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
    "request_id": requestId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "file_url": fileUrl,
    "file_name": fileName,
    "file_type": fileType,
    "file_size": fileSize,
    "chat_id": chatId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class ChatMessage {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  int? userId;
  String? message;
  String? messageType;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  User? user;

  ChatMessage({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.message,
    this.messageType,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.user,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
    isDeleted: json["is_deleted"],
    id: json["id"],
    requestId: json["request_id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    userId: json["user_id"],
    message: json["message"],
    messageType: json["messageType"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,
    "request_id": requestId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "user_id": userId,
    "message": message,
    "messageType": messageType,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
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
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
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

class Request {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? reqUserDepartmentId;
  int? reqUserSectionId;
  int? serviceId;
  int? subServiceId;
  int? userId;
  int? numberOfPassengers;
  String? purposeOfTravel;
  String? vehicleRequiredLocation;
  String? employeeIdPassport;
  String? contactNumber;
  String? requestType;
  String? originCity;
  String? destinationCity;
  DateTime? arrivalDepartureDatetime;
  String? specialInstructions;
  String? category;
  String? vehicleRequiredFor;
  String? title;
  String? typeOfVehicleRequired;
  String? typeOfRequest;
  DateTime? dateOfTravel;
  String? timeOfTravel;
  int? expDurationOfUseHrs;
  int? expDurationOfUseDays;
  String? description;
  String? status;
  String? workflowExecutionId;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  User? createdByUser;
  ReqDepartment? reqDepartment;
  ReqSection? reqSection;
  Service? service;
  Service? subService;

  Request({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.numberOfPassengers,
    this.purposeOfTravel,
    this.vehicleRequiredLocation,
    this.employeeIdPassport,
    this.contactNumber,
    this.requestType,
    this.originCity,
    this.destinationCity,
    this.arrivalDepartureDatetime,
    this.specialInstructions,
    this.category,
    this.vehicleRequiredFor,
    this.title,
    this.typeOfVehicleRequired,
    this.typeOfRequest,
    this.dateOfTravel,
    this.timeOfTravel,
    this.expDurationOfUseHrs,
    this.expDurationOfUseDays,
    this.description,
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
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
    isDeleted: json["is_deleted"],
    id: json["id"],
    reqUserDepartmentId: json["req_user_department_id"],
    reqUserSectionId: json["req_user_section_id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    userId: json["user_id"],

    category: json["category"],
    vehicleRequiredFor: json["vehicle_required_for"],
    vehicleRequiredLocation: json["vehicle_required_location"],
    title: json["title"],
    purposeOfTravel: json["purpose_of_travel"],
    typeOfVehicleRequired: json["type_of_vehicle_required"],
    typeOfRequest: json["type_of_request"],
    dateOfTravel: json["date_of_travel"] == null
        ? null
        : DateTime.parse(json["date_of_travel"]),
    timeOfTravel: json["time_of_travel"],
    expDurationOfUseHrs: json["exp_duration_of_use_hrs"],
    expDurationOfUseDays: json["exp_duration_of_use_days"],
    description: json["description"],
    status: json["status"],
    workflowExecutionId: json["workflow_execution_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdByUser: json["created_by_user"] == null
        ? null
        : User.fromJson(json["created_by_user"]),
    reqDepartment: json["req_department"] == null
        ? null
        : ReqDepartment.fromJson(json["req_department"]),
    reqSection: json["req_section"] == null
        ? null
        : ReqSection.fromJson(json["req_section"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    subService: json["sub_service"] == null
        ? null
        : Service.fromJson(json["sub_service"]),
    numberOfPassengers: json["number_of_passengers"],
    employeeIdPassport: json["employee_id_passport"],
    contactNumber: json["contact_number"],
    requestType: json["request_type"],
    originCity: json["origin_city"],
    destinationCity: json["destination_city"],
    arrivalDepartureDatetime: json["arrival_departure_datetime"] == null
        ? null
        : DateTime.parse(json["arrival_departure_datetime"]),
    specialInstructions: json["special_instructions"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,
    "req_user_department_id": reqUserDepartmentId,
    "req_user_section_id": reqUserSectionId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "user_id": userId,
    "category": category,
    "vehicle_required_for": vehicleRequiredFor,
    "vehicle_required_location": vehicleRequiredLocation,
    "title": title,
    "purpose_of_travel": purposeOfTravel,
    "type_of_vehicle_required": typeOfVehicleRequired,
    "type_of_request": typeOfRequest,
    "date_of_travel":
        "${dateOfTravel!.year.toString().padLeft(4, '0')}-${dateOfTravel!.month.toString().padLeft(2, '0')}-${dateOfTravel!.day.toString().padLeft(2, '0')}",
    "time_of_travel": timeOfTravel,
    "exp_duration_of_use_hrs": expDurationOfUseHrs,
    "exp_duration_of_use_days": expDurationOfUseDays,
    "description": description,
    "status": status,
    "workflow_execution_id": workflowExecutionId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "created_by_user": createdByUser?.toJson(),
    "req_department": reqDepartment?.toJson(),
    "req_section": reqSection?.toJson(),
    "service": service?.toJson(),
    "sub_service": subService?.toJson(),
  };
}

class ReqDepartment {
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

  ReqDepartment({
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

  factory ReqDepartment.fromJson(Map<String, dynamic> json) => ReqDepartment(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
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
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
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

class ReqSection {
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

  ReqSection({
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

  factory ReqSection.fromJson(Map<String, dynamic> json) => ReqSection(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
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
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
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
  dynamic logoUrl;
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
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
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
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
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

class Workflow {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  String? content;
  String? status;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  Workflow({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.content,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Workflow.fromJson(Map<String, dynamic> json) => Workflow(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<String>.from(json["jsonIgnore"]!.map((x) => x)),
    isDeleted: json["is_deleted"],
    id: json["id"],
    requestId: json["request_id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    content: json["content"],
    status: json["status"],
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
    "request_id": requestId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "content": content,
    "status": status,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
