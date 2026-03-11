import 'dart:convert';

AllRequestsDashboardModel welcomeFromJson(String str) =>
    AllRequestsDashboardModel.fromJson(json.decode(str));
String welcomeToJson(AllRequestsDashboardModel data) =>
    json.encode(data.toJson());

class AllRequestsDashboardModel {
  String? status;
  List<AllRequestsDashboardData>? data;
  int? totalCount;

  AllRequestsDashboardModel({this.status, this.data, this.totalCount});

  factory AllRequestsDashboardModel.fromJson(Map<String, dynamic> json) =>
      AllRequestsDashboardModel(
        status: json["status"],
        data: (json["data"] as List?)
            ?.map((x) => AllRequestsDashboardData.fromJson(x))
            .toList(),
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.map((x) => x.toJson()).toList(),
    "total_count": totalCount,
  };
}

class AllRequestsDashboardData {
  bool? isDeleted;
  int? id;
  int? reqUserDepartmentId;
  int? reqUserSectionId;
  int? serviceId;
  int? subServiceId;
  int? userId;
  String? category;
  String? vehicleRequiredFor;
  String? vehicleRequiredLocation;
  String? title;
  String? purposeOfTravel;
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
  CreatedByUser? createdByUser;
  Department? reqDepartment;
  Section? reqSection;
  Service? service;
  Service? subService;
  List<ChatMessage>? chatMessages;
  List<Attachment>? attachments;
  List<WorkflowLog>? workflowLogs;
  List<ApprovalDetail>? approvalDetails;
  int? numberOfPassengers;
  String? employeeIdPassport;
  String? contactNumber;
  String? requestType;
  String? originCity;
  String? destinationCity;
  DateTime? arrivalDepartureDatetime;
  String? specialInstructions;
  List<Passenger>? passengers;

  AllRequestsDashboardData({
    this.isDeleted,
    this.id,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.category,
    this.vehicleRequiredFor,
    this.vehicleRequiredLocation,
    this.title,
    this.purposeOfTravel,
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
    this.chatMessages,
    this.attachments,
    this.workflowLogs,
    this.approvalDetails,
    this.numberOfPassengers,
    this.employeeIdPassport,
    this.contactNumber,
    this.requestType,
    this.originCity,
    this.destinationCity,
    this.arrivalDepartureDatetime,
    this.specialInstructions,
    this.passengers,
  });

  factory AllRequestsDashboardData.fromJson(Map<String, dynamic> json) =>
      AllRequestsDashboardData(
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
        dateOfTravel: json["date_of_travel"] != null
            ? DateTime.tryParse(json["date_of_travel"])
            : null,
        timeOfTravel: json["time_of_travel"],
        expDurationOfUseHrs: json["exp_duration_of_use_hrs"],
        expDurationOfUseDays: json["exp_duration_of_use_days"],
        description: json["description"],
        status: json["status"],
        workflowExecutionId: json["workflow_execution_id"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        createdByUser: json["created_by_user"] != null
            ? CreatedByUser.fromJson(json["created_by_user"])
            : null,
        reqDepartment: json["req_department"] != null
            ? Department.fromJson(json["req_department"])
            : null,
        reqSection: json["req_section"] != null
            ? Section.fromJson(json["req_section"])
            : null,
        service: json["service"] != null
            ? Service.fromJson(json["service"])
            : null,
        subService: json["sub_service"] != null
            ? Service.fromJson(json["sub_service"])
            : null,
        chatMessages: (json["chat_messages"] as List?)
            ?.map((x) => ChatMessage.fromJson(x))
            .toList(),
        attachments: (json["attachments"] as List?)
            ?.map((x) => Attachment.fromJson(x))
            .toList(),
        workflowLogs: (json["workflow_logs"] as List?)
            ?.map((x) => WorkflowLog.fromJson(x))
            .toList(),
        approvalDetails: (json["approval_details"] as List?)
            ?.map((x) => ApprovalDetail.fromJson(x))
            .toList(),
        numberOfPassengers: json["number_of_passengers"],
        employeeIdPassport: json["employee_id_passport"],
        contactNumber: json["contact_number"],
        requestType: json["request_type"],
        originCity: json["origin_city"],
        destinationCity: json["destination_city"],
        arrivalDepartureDatetime: json["arrival_departure_datetime"] != null
            ? DateTime.tryParse(json["arrival_departure_datetime"])
            : null,
        specialInstructions: json["special_instructions"],
        passengers: (json["passengers"] as List?)
            ?.map((x) => Passenger.fromJson(x))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "title": title,
    "status": status,
    "service": service?.toJson(),
    "attachments": attachments?.map((x) => x.toJson()).toList(),
    "passengers": passengers?.map((x) => x.toJson()).toList(),
  };
}

class CreatedByUser {
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
  String? faxNumber;
  String? diplomaticName;
  String? avatar;
  String? fatherName;
  String? spouseName;
  String? children1Name;
  String? children2Name;
  String? address;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;
  bool? isAdmin;

  CreatedByUser({
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
    department: json["department"] != null
        ? Department.fromJson(json["department"])
        : null,
    category: json["category"],
    directorate: json["directorate"],
    section: json["section"] != null ? Section.fromJson(json["section"]) : null,
    position: json["position"] != null
        ? Position.fromJson(json["position"])
        : null,
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
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] != null
        ? DateTime.tryParse(json["updated_at"])
        : null,
    isAdmin: json["is_admin"],
  );

  Map<String, dynamic> toJson() => {
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

class Position {
  bool? isDeleted;
  int? id;
  String? name;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  Position({
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    isDeleted: json["is_deleted"],
    id: json["id"],
    name: json["name"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"] != null
        ? DateTime.tryParse(json["updated_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "is_deleted": isDeleted,
    "id": id,
    "name": name,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Department {
  int? id;
  String? name;

  Department({this.id, this.name});

  factory Department.fromJson(Map<String, dynamic> json) =>
      Department(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class Section {
  int? id;
  String? name;

  Section({this.id, this.name});

  factory Section.fromJson(Map<String, dynamic> json) =>
      Section(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class Service {
  int? id;
  String? name;

  Service({this.id, this.name});

  factory Service.fromJson(Map<String, dynamic> json) =>
      Service(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ChatMessage {
  int? id;
  int? requestId;
  int? userId;
  String? message;
  String? messageType;
  DateTime? createdAt;
  User? user;

  ChatMessage({
    this.id,
    this.requestId,
    this.userId,
    this.message,
    this.messageType,
    this.createdAt,
    this.user,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json["id"],
    requestId: json["request_id"],
    userId: json["user_id"],
    message: json["message"],
    messageType: json["message_type"],
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "message_type": messageType,
    "created_at": createdAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class Attachment {
  int? id;
  String? fileUrl;
  String? fileName;

  Attachment({this.id, this.fileUrl, this.fileName});

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    fileUrl: json["file_url"],
    fileName: json["file_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_url": fileUrl,
    "file_name": fileName,
  };
}

class Passenger {
  int? id;
  String? passengerName;

  Passenger({this.id, this.passengerName});

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      Passenger(id: json["id"], passengerName: json["passenger_name"]);

  Map<String, dynamic> toJson() => {"id": id, "passenger_name": passengerName};
}

class ApprovalDetail {
  int? id;
  String? comment;
  String? approvalStatus;

  ApprovalDetail({this.id, this.comment, this.approvalStatus});

  factory ApprovalDetail.fromJson(Map<String, dynamic> json) => ApprovalDetail(
    id: json["id"],
    comment: json["comment"],
    approvalStatus: json["approval_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "approval_status": approvalStatus,
  };
}

class WorkflowLog {
  int? id;
  String? logMessage;

  WorkflowLog({this.id, this.logMessage});

  factory WorkflowLog.fromJson(Map<String, dynamic> json) =>
      WorkflowLog(id: json["id"], logMessage: json["log_message"]);

  Map<String, dynamic> toJson() => {"id": id, "log_message": logMessage};
}

class User {
  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json["id"], name: json["name"], email: json["email"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}
