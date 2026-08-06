import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/helper/localized_display_name.dart';

class EmployeeResponse {
  final String status;
  final List<EmployeeList> employees;
  final int totalCount;

  EmployeeResponse({
    required this.status,
    required this.employees,
    required this.totalCount,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as List;

    return EmployeeResponse(
      status: json['status'] ?? '',
      employees: (rawData[0] as List)
          .map((e) => EmployeeList.fromJson(e))
          .toList(),
      totalCount: rawData.length > 1 ? rawData[1] ?? 0 : 0,
    );
  }
}

class EmployeeList {
  final int id;
  final String employeeId;
  final String civilEmployeeId;
  final String employeeName;
  final String employeeArabicName;
  final String personType;
  final String? dateOfBirth;
  final String? regionOfBirth;
  final String? countryOfBirth;
  final String? dateOfJoining;
  final String? lastPromotionDate;
  final String gender;
  final String qualification;
  final String maritalStatus;
  final String nationality;
  final String email;
  final String bloodType;
  final String nationalId;
  final String manpowerId;
  final String mobile;
  final String officeNumber;
  final DepartmentModel? department;
  final SectionModel? section;
  final PositionModel? position;
  final String category;
  final String directorate;
  final String arabicPosition;
  final int grade;
  final String location;
  final String supervisorEmpId;
  final String supervisorEmpName;
  final String passportNumber;
  final String personalEmail;
  final int? extensionNumber;
  final String? faxNumber;
  final String diplomaticName;
  final String avatar;
  final String fatherName;
  final String? spouseName;
  final String? address;
  final bool isAdmin;

  EmployeeList({
    required this.id,
    required this.employeeId,
    required this.civilEmployeeId,
    required this.employeeName,
    required this.employeeArabicName,
    required this.personType,
    this.dateOfBirth,
    this.regionOfBirth,
    this.countryOfBirth,
    this.dateOfJoining,
    this.lastPromotionDate,
    required this.gender,
    required this.qualification,
    required this.maritalStatus,
    required this.nationality,
    required this.email,
    required this.bloodType,
    required this.nationalId,
    required this.manpowerId,
    required this.mobile,
    required this.officeNumber,
    this.department,
    this.section,
    this.position,
    required this.category,
    required this.directorate,
    required this.arabicPosition,
    required this.grade,
    required this.location,
    required this.supervisorEmpId,
    required this.supervisorEmpName,
    required this.passportNumber,
    required this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    required this.diplomaticName,
    required this.avatar,
    required this.fatherName,
    this.spouseName,
    this.address,
    required this.isAdmin,
  });

  factory EmployeeList.fromJson(Map<String, dynamic> json) {
    return EmployeeList(
      id: json['id'] ?? 0,
      employeeId: json['employee_id'] ?? '',
      civilEmployeeId: json['civil_employee_id'] ?? '',
      employeeName: json['employee_name'] ?? '',
      employeeArabicName: json['employee_arabic_name'] ?? '',
      personType: json['person_type'] ?? '',
      dateOfBirth: json['date_of_birth'],
      regionOfBirth: json['region_of_birth'],
      countryOfBirth: json['country_of_birth'],
      dateOfJoining: json['date_of_joining'],
      lastPromotionDate: json['last_promotion_date'],
      gender: json['gender'] ?? '',
      qualification: json['qualification'] ?? '',
      maritalStatus: json['marital_status'] ?? '',
      nationality: json['nationality'] ?? '',
      email: json['email'] ?? '',
      bloodType: json['blood_type'] ?? '',
      nationalId: json['national_id'] ?? '',
      manpowerId: json['manpower_id'] ?? '',
      mobile: json['mobile'] ?? '',
      officeNumber: json['office_number'] ?? '',
      department: json['department'] is Map
          ? DepartmentModel.fromJson(
              Map<String, dynamic>.from(json['department'] as Map),
            )
          : null,
      section: json['section'] is Map
          ? SectionModel.fromJson(
              Map<String, dynamic>.from(json['section'] as Map),
            )
          : json['section'] is int
          ? SectionModel(id: json['section'] as int)
          : null,
      position: json['position'] is Map
          ? PositionModel.fromJson(
              Map<String, dynamic>.from(json['position'] as Map),
            )
          : json['position'] is int
          ? PositionModel(id: json['position'] as int)
          : null,
      category: json['category'] ?? '',
      directorate: json['directorate'] ?? '',
      arabicPosition: json['arabic_position'] ?? '',
      grade: json['grade'] ?? 0,
      location: json['location'] ?? '',
      supervisorEmpId: json['supervisor_emp_id'] ?? '',
      supervisorEmpName: json['supervisor_emp_name'] ?? '',
      passportNumber: json['passport_number'] ?? '',
      personalEmail: json['personal_email'] ?? '',
      extensionNumber: json['extension_number'],
      faxNumber: json['fax_number'],
      diplomaticName: json['diplomatic_name'] ?? '',
      avatar: json['avatar'] ?? '',
      fatherName: json['father_name'] ?? '',
      spouseName: json['spouse_name'],
      address: json['address'],
      isAdmin: json['is_admin'] ?? false,
    );
  }

  String displayName({required bool isArabic}) => localizedDisplayName(
    isArabic: isArabic,
    english: employeeName,
    arabic: employeeArabicName,
  );
}
