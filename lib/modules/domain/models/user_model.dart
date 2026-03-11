class UserInformation {
  final String? status;
  final UserData? data;

  UserInformation({this.status, this.data});

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      status: json['status']?.toString(),
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}

class UserData {
  final String? id;
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
  final Department? department;
  final String? category;
  final String? directorate;
  final Section? section;
  final Position? position;
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

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) {
    String? s(v) => v?.toString();

    return UserData(
      id: s(json['id']),
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
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      category: s(json['category']),
      directorate: s(json['directorate']),
      section: json['section'] != null
          ? Section.fromJson(json['section'])
          : null,
      position: json['position'] != null
          ? Position.fromJson(json['position'])
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

class Department {
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? createdAt;
  final String? updatedAt;

  Department({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    String? s(v) => v?.toString();

    return Department(
      id: s(json['id']),
      createdBy: s(json['created_by']),
      updatedBy: s(json['updated_by']),
      departmentName: s(json['department_name']),
      departmentCode: s(json['department_code']),
      departmentDescription: s(json['department_description']),
      createdAt: s(json['created_at']),
      updatedAt: s(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'department_name': departmentName,
    'department_code': departmentCode,
    'department_description': departmentDescription,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Section {
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final String? departmentId;
  final String? createdAt;
  final String? updatedAt;

  Section({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.sectionName,
    this.sectionCode,
    this.sectionDescription,
    this.departmentId,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    String? s(v) => v?.toString();

    return Section(
      id: s(json['id']),
      createdBy: s(json['created_by']),
      updatedBy: s(json['updated_by']),
      sectionName: s(json['section_name']),
      sectionCode: s(json['section_code']),
      sectionDescription: s(json['section_description']),
      departmentId: s(json['department_id']),
      createdAt: s(json['created_at']),
      updatedAt: s(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'section_name': sectionName,
    'section_code': sectionCode,
    'section_description': sectionDescription,
    'department_id': departmentId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Position {
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Position({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    String? s(v) => v?.toString();

    return Position(
      id: s(json['id']),
      createdBy: s(json['created_by']),
      updatedBy: s(json['updated_by']),
      name: s(json['name']),
      createdAt: s(json['created_at']),
      updatedAt: s(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'name': name,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
