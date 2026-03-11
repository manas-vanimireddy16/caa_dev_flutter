// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LogisticsForeignDetailModel welcomeFromJson(String str) =>
    LogisticsForeignDetailModel.fromJson(json.decode(str));

String welcomeToJson(LogisticsForeignDetailModel data) =>
    json.encode(data.toJson());

class LogisticsForeignDetailModel {
  String? status;
  ForeignRequestData? data;

  LogisticsForeignDetailModel({this.status, this.data});

  factory LogisticsForeignDetailModel.fromJson(Map<String, dynamic> json) =>
      LogisticsForeignDetailModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : ForeignRequestData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class ForeignRequestData {
  Request? request;
  List<WorkflowDetail>? workflowDetails;
  List<ForeignApprovalDetail>? approvalDetails;
  List<ChatMessages>? chatMessages;
  List<Attachment>? attachments;

  ForeignRequestData({
    this.request,
    this.workflowDetails,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
  });

  factory ForeignRequestData.fromJson(
    Map<String, dynamic> json,
  ) => ForeignRequestData(
    request: json["request"] == null ? null : Request.fromJson(json["request"]),
    workflowDetails: json["workflow_details"] == null
        ? []
        : List<WorkflowDetail>.from(
            json["workflow_details"]!.map((x) => WorkflowDetail.fromJson(x)),
          ),
    approvalDetails: json["approval_details"] == null
        ? []
        : List<ForeignApprovalDetail>.from(
            json["approval_details"]!.map(
              (x) => ForeignApprovalDetail.fromJson(x),
            ),
          ),
    chatMessages: json["chat_messages"] == null
        ? []
        : List<ChatMessages>.from(
            json["chat_messages"]!.map((x) => ChatMessages.fromJson(x)),
          ),
    attachments: json["attachments"] == null
        ? []
        : List<Attachment>.from(
            json["attachments"]!.map((x) => Attachment.fromJson(x)),
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

class ForeignApprovalDetail {
  List<JsonIgnore>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  int? approverRoleId;
  dynamic comment;
  String? approvalStatus;
  int? level;
  int? departmentId;
  int? sectionId;
  int? approverUserId;
  dynamic delegateUserId;
  dynamic approvedBy;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  ApproverRole? approverRole;
  User? approverUser;
  dynamic delegateUser;
  dynamic approvedByUser;

  ForeignApprovalDetail({
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

  factory ForeignApprovalDetail.fromJson(Map<String, dynamic> json) =>
      ForeignApprovalDetail(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<JsonIgnore>.from(
                json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
              ),
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
        approverUser: json["approver_user"] == null
            ? null
            : User.fromJson(json["approver_user"]),
        delegateUser: json["delegate_user"],
        approvedByUser: json["approved_by_user"],
      );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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
    "approver_user": approverUser?.toJson(),
    "delegate_user": delegateUser,
    "approved_by_user": approvedByUser,
  };
}

class ApproverRole {
  List<JsonIgnore>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  int? foreignVehicleRequestId;
  String? passengerName;

  ApproverRole({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.foreignVehicleRequestId,
    this.passengerName,
  });

  factory ApproverRole.fromJson(Map<String, dynamic> json) => ApproverRole(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
    foreignVehicleRequestId: json["foreign_vehicle_request_id"],
    passengerName: json["passenger_name"],
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
    "is_deleted": isDeleted,
    "id": id,
    "name": name,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "foreign_vehicle_request_id": foreignVehicleRequestId,
    "passenger_name": passengerName,
  };
}

enum JsonIgnore { IS_DELETED, JSON_IGNORE, LOGICAL_DELETE }

final jsonIgnoreValues = EnumValues({
  "is_deleted": JsonIgnore.IS_DELETED,
  "jsonIgnore": JsonIgnore.JSON_IGNORE,
  "logicalDelete": JsonIgnore.LOGICAL_DELETE,
});

class User {
  List<JsonIgnore>? jsonIgnore;
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
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
    "is_admin": isAdmin,
  };
}

class Attachment {
  List<JsonIgnore>? jsonIgnore;
  bool? isDeleted;
  int? id;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  String? fileUrl;
  String? fileName;
  String? fileType;
  String? fileSize;
  int? chatId;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  Attachment({
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

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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

class ChatMessages {
  List<JsonIgnore>? jsonIgnore;
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

  ChatMessages({
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

  factory ChatMessages.fromJson(Map<String, dynamic> json) => ChatMessages(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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

class Request {
  List<JsonIgnore>? jsonIgnore;
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
  String? status;
  String? workflowExecutionId;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  CreatedByUser? createdByUser;
  Department? reqDepartment;
  Section? reqSection;
  Service? service;
  Service? subService;
  List<ApproverRole>? passengers;

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
    this.passengers,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
    isDeleted: json["is_deleted"],
    id: json["id"],
    reqUserDepartmentId: json["req_user_department_id"],
    reqUserSectionId: json["req_user_section_id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],
    userId: json["user_id"],
    numberOfPassengers: json["number_of_passengers"],
    purposeOfTravel: json["purpose_of_travel"],
    vehicleRequiredLocation: json["vehicle_required_location"],
    employeeIdPassport: json["employee_id_passport"],
    contactNumber: json["contact_number"],
    requestType: json["request_type"],
    originCity: json["origin_city"],
    destinationCity: json["destination_city"],
    arrivalDepartureDatetime: json["arrival_departure_datetime"] == null
        ? null
        : DateTime.parse(json["arrival_departure_datetime"]),
    specialInstructions: json["special_instructions"],
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
        : CreatedByUser.fromJson(json["created_by_user"]),
    reqDepartment: json["req_department"] == null
        ? null
        : Department.fromJson(json["req_department"]),
    reqSection: json["req_section"] == null
        ? null
        : Section.fromJson(json["req_section"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    subService: json["sub_service"] == null
        ? null
        : Service.fromJson(json["sub_service"]),
    passengers: json["passengers"] == null
        ? []
        : List<ApproverRole>.from(
            json["passengers"]!.map((x) => ApproverRole.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
    "is_deleted": isDeleted,
    "id": id,
    "req_user_department_id": reqUserDepartmentId,
    "req_user_section_id": reqUserSectionId,
    "service_id": serviceId,
    "sub_service_id": subServiceId,
    "user_id": userId,
    "number_of_passengers": numberOfPassengers,
    "purpose_of_travel": purposeOfTravel,
    "vehicle_required_location": vehicleRequiredLocation,
    "employee_id_passport": employeeIdPassport,
    "contact_number": contactNumber,
    "request_type": requestType,
    "origin_city": originCity,
    "destination_city": destinationCity,
    "arrival_departure_datetime": arrivalDepartureDatetime?.toIso8601String(),
    "special_instructions": specialInstructions,
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
    "passengers": passengers == null
        ? []
        : List<dynamic>.from(passengers!.map((x) => x.toJson())),
  };
}

class CreatedByUser {
  List<JsonIgnore>? jsonIgnore;
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
  ApproverRole? position;
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
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : ApproverRole.fromJson(json["position"]),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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

class Department {
  List<JsonIgnore>? jsonIgnore;
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
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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
  List<JsonIgnore>? jsonIgnore;
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
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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
  List<JsonIgnore>? jsonIgnore;
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
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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

class WorkflowDetail {
  List<JsonIgnore>? jsonIgnore;
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

  WorkflowDetail({
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

  factory WorkflowDetail.fromJson(Map<String, dynamic> json) => WorkflowDetail(
    jsonIgnore: json["jsonIgnore"] == null
        ? []
        : List<JsonIgnore>.from(
            json["jsonIgnore"]!.map((x) => jsonIgnoreValues.map[x]!),
          ),
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
        : List<dynamic>.from(
            jsonIgnore!.map((x) => jsonIgnoreValues.reverse[x]),
          ),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
