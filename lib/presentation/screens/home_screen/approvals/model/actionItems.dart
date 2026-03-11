import 'dart:convert';

/// Top-level function to parse JSON string into model
ActionItemsModel serviceRequestResponseFromJson(String str) =>
    ActionItemsModel.fromJson(json.decode(str));

/// Top-level function to convert model back to JSON string
String serviceRequestResponseToJson(ActionItemsModel data) =>
    json.encode(data.toJson());

/// ✅ Parent Model (Root)
class ActionItemsModel {
  final String? status;
  final List<ActionItemData>? data;
  final int? totalCount;

  ActionItemsModel({this.status, this.data, this.totalCount});

  factory ActionItemsModel.fromJson(Map<String, dynamic> json) =>
      ActionItemsModel(
        status: json["status"] as String?,
        data: (json["data"] as List<dynamic>?)
            ?.map((x) => ActionItemData.fromJson(x))
            .toList(),
        totalCount: json["total_count"] as int?,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.map((x) => x.toJson()).toList(),
    "total_count": totalCount,
  };
}

/// ✅ Each Service Request Item
class ActionItemData {
  final int? id;
  final String? createdBy;
  final String? updatedBy;
  final String? department;
  final String? serviceType;
  final String? problem;
  final String? requestFor;
  final String? description;
  final String? extnNum;
  final String? contactNum;
  final String? requestDate;
  final String? attachmentUrl;
  final ReportingManager? reportingManager;
  final String? assignedTo;
  final String? status;
  final String? workflowExecutionId;
  final String? createdAt;
  final String? updatedAt;
  final int? userId;

  ActionItemData({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.department,
    this.serviceType,
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
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory ActionItemData.fromJson(Map<String, dynamic> json) => ActionItemData(
    id: json["id"] as int?,
    createdBy: json["created_by"] as String?,
    updatedBy: json["updated_by"] as String?,
    department: json["department"] as String?,
    serviceType: json["service_type"] as String?,
    problem: json["problem"] as String?,
    requestFor: json["request_for"] as String?,
    description: json["description"] as String?,
    extnNum: json["extn_num"] as String?,
    contactNum: json["contact_num"] as String?,
    requestDate: json["request_date"] as String?,
    attachmentUrl: json["attachment_url"] as String?,
    reportingManager: json["reporting_manager"] != null
        ? ReportingManager.fromJson(json["reporting_manager"])
        : null,
    assignedTo: json["assigned_to"] as String?,
    status: json["status"] as String?,
    workflowExecutionId: json["workflow_execution_id"] as String?,
    createdAt: json["created_at"] as String?,
    updatedAt: json["updated_at"] as String?,
    userId: json["user_id"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "department": department,
    "service_type": serviceType,
    "problem": problem,
    "request_for": requestFor,
    "description": description,
    "extn_num": extnNum,
    "contact_num": contactNum,
    "request_date": requestDate,
    "attachment_url": attachmentUrl,
    "reporting_manager": reportingManager?.toJson(),
    "assigned_to": assignedTo,
    "status": status,
    "workflow_execution_id": workflowExecutionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_id": userId,
  };
}

/// ✅ Nested Reporting Manager Model
class ReportingManager {
  final int? id;
  final String? createdBy;
  final String? updatedBy;
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
  final String? extensionNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? createdAt;
  final String? updatedAt;
  final bool? isAdmin;

  ReportingManager({
    this.id,
    this.createdBy,
    this.updatedBy,
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
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
  });

  factory ReportingManager.fromJson(Map<String, dynamic> json) =>
      ReportingManager(
        id: json["id"] as int?,
        createdBy: json["created_by"] as String?,
        updatedBy: json["updated_by"] as String?,
        employeeId: json["employee_id"] as String?,
        civilEmployeeId: json["civil_employee_id"] as String?,
        employeeName: json["employee_name"] as String?,
        employeeArabicName: json["employee_arabic_name"] as String?,
        personType: json["person_type"] as String?,
        dateOfBirth: json["date_of_birth"] as String?,
        regionOfBirth: json["region_of_birth"] as String?,
        countryOfBirth: json["country_of_birth"] as String?,
        dateOfJoining: json["date_of_joining"] as String?,
        lastPromotionDate: json["last_promotion_date"] as String?,
        gender: json["gender"] as String?,
        qualification: json["qualification"] as String?,
        maritalStatus: json["marital_status"] as String?,
        nationality: json["nationality"] as String?,
        email: json["email"] as String?,
        bloodType: json["blood_type"] as String?,
        nationalId: json["national_id"] as String?,
        manpowerId: json["manpower_id"] as String?,
        mobile: json["mobile"] as String?,
        officeNumber: json["office_number"] as String?,
        department: json["department"] as int?,
        category: json["category"] as String?,
        directorate: json["directorate"] as String?,
        section: json["section"] as int?,
        position: json["position"] as int?,
        arabicPosition: json["arabic_position"] as String?,
        grade: json["grade"] as int?,
        location: json["location"] as String?,
        supervisorEmpId: json["supervisor_emp_id"] as String?,
        supervisorEmpName: json["supervisor_emp_name"] as String?,
        passportNumber: json["passport_number"] as String?,
        personalEmail: json["personal_email"] as String?,
        extensionNumber: json["extension_number"] as String?,
        diplomaticName: json["diplomatic_name"] as String?,
        avatar: json["avatar"] as String?,
        createdAt: json["created_at"] as String?,
        updatedAt: json["updated_at"] as String?,
        isAdmin: json["is_admin"] as bool?,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "updated_by": updatedBy,
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_admin": isAdmin,
  };
}
