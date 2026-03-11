class EmployeesResponse {
  final String? status;
  final List<Employee>? data;

  EmployeesResponse({this.status, this.data});

  factory EmployeesResponse.fromJson(Map<String, dynamic> json) {
    return EmployeesResponse(
      status: json['status'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class Employee {
  final String? createdBy;
  final String? updatedBy;
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
  final Department? department;
  final String? category;
  final String? directorate;
  final Section? section;
  final Position? position;
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

  Employee({
    this.createdBy,
    this.updatedBy,
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
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      employeeId: json['employee_id'],
      civilEmployeeId: json['civil_employee_id'],
      employeeName: json['employee_name'],
      employeeArabicName: json['employee_arabic_name'],
      personType: json['person_type'],
      dateOfBirth: json['date_of_birth'],
      regionOfBirth: json['region_of_birth'],
      countryOfBirth: json['country_of_birth'],
      dateOfJoining: json['date_of_joining'],
      lastPromotionDate: json['last_promotion_date'],
      gender: json['gender'],
      qualification: json['qualification'],
      maritalStatus: json['marital_status'],
      nationality: json['nationality'],
      email: json['email'],
      bloodType: json['blood_type'],
      nationalId: json['national_id'],
      manpowerId: json['manpower_id'],
      mobile: json['mobile'],
      officeNumber: json['office_number'],
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      category: json['category'],
      directorate: json['directorate'],
      section: json['section'] != null
          ? Section.fromJson(json['section'])
          : null,
      position: json['position'] != null
          ? Position.fromJson(json['position'])
          : null,
      arabicPosition: json['arabic_position'],
      grade: json['grade'],
      location: json['location'],
      supervisorEmpId: json['supervisor_emp_id'],
      supervisorEmpName: json['supervisor_emp_name'],
      passportNumber: json['passport_number'],
      personalEmail: json['personal_email'],
      extensionNumber: json['extension_number'],
      diplomaticName: json['diplomatic_name'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isAdmin: json['is_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
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
      'department': department?.toJson(),
      'category': category,
      'directorate': directorate,
      'section': section?.toJson(),
      'position': position?.toJson(),
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
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_admin': isAdmin,
    };
  }
}

class Department {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? createdAt;
  final String? updatedAt;

  Department({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      departmentName: json['department_name'],
      departmentCode: json['department_code'],
      departmentDescription: json['department_description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'department_name': departmentName,
      'department_code': departmentCode,
      'department_description': departmentDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Section {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final String? departmentId;
  final String? createdAt;
  final String? updatedAt;

  Section({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.sectionName,
    this.sectionCode,
    this.sectionDescription,
    this.departmentId,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      sectionName: json['section_name'],
      sectionCode: json['section_code'],
      sectionDescription: json['section_description'],
      departmentId: json['department_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'section_name': sectionName,
      'section_code': sectionCode,
      'section_description': sectionDescription,
      'department_id': departmentId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Position {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Position({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
