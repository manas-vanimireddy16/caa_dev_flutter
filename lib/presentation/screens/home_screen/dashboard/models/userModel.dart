class UserModel {
  final String? status;
  final User? data;

  UserModel({this.status, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'] as String?,
      data: json['data'] != null
          ? User.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.toJson()};
  }
}

class User {
  final int? id;
  final int? createdBy;
  final int? updatedBy;
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
  final int? extensionNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? createdAt;
  final String? updatedAt;
  final bool? isAdmin;
  final String? address;

  User({
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
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      employeeId: json['employee_id'] as String?,
      civilEmployeeId: json['civil_employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      employeeArabicName: json['employee_arabic_name'] as String?,
      personType: json['person_type'] as String,
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
      department: json['department'] != null
          ? Department.fromJson(json['department'] as Map<String, dynamic>)
          : null,
      category: json['category'] as String?,
      directorate: json['directorate'] as String?,
      section: json['section'] != null
          ? Section.fromJson(json['section'] as Map<String, dynamic>)
          : null,
      position: json['position'] != null
          ? Position.fromJson(json['position'] as Map<String, dynamic>)
          : null,
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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isAdmin: json['is_admin'] as bool?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}

class Department {
  final int? id;
  final int? createdBy;
  final int? updatedBy;
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
    return Department(
      id: json['id'] as int?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
      departmentDescription: json['department_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
}

class Section {
  final int? id;
  final int? createdBy;
  final int? updatedBy;
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
    return Section(
      id: json['id'] as int?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      sectionName: json['section_name'] as String?,
      sectionCode: json['section_code'] as String?,
      sectionDescription: json['section_description'] as String?,
      departmentId: json['department_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
}

class Position {
  final int? id;
  final int? createdBy;
  final int? updatedBy;
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
    return Position(
      id: json['id'] as int?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
