class RequestMessageResponse {
  final String? status;
  final List<RequestMessageData>? data;
  final int? totalCount;

  RequestMessageResponse({this.status, this.data, this.totalCount});

  factory RequestMessageResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>?;
    return RequestMessageResponse(
      status: json['status'] as String?,
      data: dataList?.map((item) => RequestMessageData.fromJson(item)).toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((item) => item.toJson()).toList(),
    'total_count': totalCount,
  };
}

class RequestMessageData {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final int? requestId;
  final int? userId;
  final String? message;
  final bool? isInternal;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;
  final User? user;

  RequestMessageData({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.requestId,
    this.userId,
    this.message,
    this.isInternal,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.user,
  });

  factory RequestMessageData.fromJson(Map<String, dynamic> json) {
    var jsonIgnoreList = (json['jsonIgnore'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
    return RequestMessageData(
      jsonIgnore: jsonIgnoreList,
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      requestId: json['request_id'] as int?,
      userId: json['user_id'] as int?,
      message: json['message'] as String?,
      isInternal: json['is_internal'] as bool?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'jsonIgnore': jsonIgnore,
    'is_deleted': isDeleted,
    'id': id,
    'request_id': requestId,
    'user_id': userId,
    'message': message,
    'is_internal': isInternal,
    'created_by': createdBy,
    'created_at': createdAt?.toIso8601String(),
    'updated_by': updatedBy,
    'updated_at': updatedAt?.toIso8601String(),
    'user': user?.toJson(),
  };
}

class User {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
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

  factory User.fromJson(Map<String, dynamic> json) {
    var jsonIgnoreList = (json['jsonIgnore'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
    return User(
      jsonIgnore: jsonIgnoreList,
      isDeleted: json['is_deleted'] as bool?,
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
      department: json['department'] as int?,
      category: json['category'] as String?,
      directorate: json['directorate'] as String?,
      section: json['section'] as int?,
      position: json['position'] as int?,
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
  }

  Map<String, dynamic> toJson() => {
    'jsonIgnore': jsonIgnore,
    'is_deleted': isDeleted,
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
