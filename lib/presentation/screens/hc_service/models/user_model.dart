import 'package:code_setup/presentation/models/details_models.dart';

class EmployeeResponse {
  final String? status;
  final List<Employee> data;
  final int? totalCount;

  const EmployeeResponse({this.status, required this.data, this.totalCount});

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      status: json['status'] as String?,
      totalCount: json['total_count'] as int?,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Employee {
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
  final DepartmentModel? department;
  final String? category;
  final String? directorate;
  final int? section;
  final PositionModel? position;
  final String? arabicPosition;
  final String? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;
  final String? passportNumber;
  final String? personalEmail;
  final String? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? createdAt;
  final String? updatedAt;
  final String? isAdmin;
  final String? address;
  final String? religion;

  Employee({
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
    this.faxNumber,
    this.diplomaticName,
    this.avatar,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.address,
    this.religion,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    String? s(v) => v?.toString();

    return Employee(
      id: json['id'],
      createdBy: s(json['created_by']),
      updatedBy: s(json['updated_by']),
      employeeId: s(json['employee_id']),
      civilEmployeeId: s(json['civil_employee_id']),
      employeeName: s(json['employee_name']),
      employeeArabicName: s(json['employee_arabic_name']),
      personType: s(json['person_type']),
      dateOfBirth: s(json['date_of_birth']),
      regionOfBirth: s(json['region_of_birth']),
      countryOfBirth: s(json['country_of_birth']),
      dateOfJoining: s(json['date_of_joining']),
      lastPromotionDate: s(json['last_promotion_date']),
      gender: s(json['gender']),
      qualification: s(json['qualification']),
      maritalStatus: s(json['marital_status']),
      nationality: s(json['nationality']),
      email: s(json['email']),
      bloodType: s(json['blood_type']),
      nationalId: s(json['national_id']),
      manpowerId: s(json['manpower_id']),
      mobile: s(json['mobile']),
      officeNumber: s(json['office_number']),
      department: json['department'] is Map
          ? DepartmentModel.fromJson(
              Map<String, dynamic>.from(json['department'] as Map),
            )
          : null,
      category: s(json['category']),
      directorate: s(json['directorate']),
      section: json['section'] is int
          ? json['section'] as int
          : json['section'] is Map
          ? int.tryParse(json['section']['id']?.toString() ?? '')
          : int.tryParse(json['section']?.toString() ?? ''),
      position: json['position'] is Map
          ? PositionModel.fromJson(
              Map<String, dynamic>.from(json['position'] as Map),
            )
          : json['position'] is int
          ? PositionModel(id: json['position'] as int)
          : null,
      arabicPosition: s(json['arabic_position']),
      grade: s(json['grade']),
      location: s(json['location']),
      supervisorEmpId: s(json['supervisor_emp_id']),
      supervisorEmpName: s(json['supervisor_emp_name']),
      passportNumber: s(json['passport_number']),
      personalEmail: s(json['personal_email']),
      extensionNumber: s(json['extension_number']),
      faxNumber: s(json['fax_number']),
      diplomaticName: s(json['diplomatic_name']),
      avatar: s(json['avatar']),
      fatherName: s(json['father_name']),
      spouseName: s(json['spouse_name']),
      children1Name: s(json['children1_name']),
      children2Name: s(json['children2_name']),
      createdAt: s(json['created_at']),
      updatedAt: s(json['updated_at']),
      isAdmin: s(json['is_admin']),
      address: s(json['address']),
      religion: s(json['religion']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_by': createdBy,
    'updated_by': updatedBy,
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
    'department': department?.toJson(),
    'category': category,
    'directorate': directorate,
    // 'section': section?.toJson(),
    'position': position?.toJson(),
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
    'created_at': createdAt,
    'updated_at': updatedAt,
    'is_admin': isAdmin,
    'address': address,
    'religion': religion,
  };
}
