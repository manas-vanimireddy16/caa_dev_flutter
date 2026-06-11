import 'package:code_setup/presentation/models/base_request_model.dart';

class BookCaaHallRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;

  final int? serviceId;
  final int? subServiceId;
  final int? userId;

  final String? purposeOfEvent;
  final int? hallId;
  final String? typeOfHall;

  final String? startDate;
  final String? endDate;

  final String? startTime;
  final String? endTime;

  final int? noOfAttendees;
  final String? remarks;
  final String? status;

  final String? workflowExecutionId;

  final HallModel? hall;

  BookCaaHallRequestModel({
    this.base,
    this.id,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.purposeOfEvent,
    this.hallId,
    this.typeOfHall,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.noOfAttendees,
    this.remarks,
    this.status,
    this.workflowExecutionId,
    this.hall,
  });
  factory BookCaaHallRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BookCaaHallRequestModel();
    }

    return BookCaaHallRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),
      id: json['id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],

      reqUserDepartmentId: json['req_user_department_id'],
      reqUserSectionId: json['req_user_section_id'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      userId: json['user_id'],

      purposeOfEvent: json['purpose_of_event'],
      hallId: json['hall_id'],
      typeOfHall: json['type_of_hall'],

      startDate: json['start_date'],
      endDate: json['end_date'],

      startTime: json['start_time'],
      endTime: json['end_time'],

      noOfAttendees: json['no_of_attendees'],
      remarks: json['remarks'],
      status: json['status'],

      workflowExecutionId: json['workflow_execution_id'],

      hall: json['hall'] != null ? HallModel.fromJson(json['hall']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,

      'req_user_department_id': reqUserDepartmentId,
      'req_user_section_id': reqUserSectionId,

      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'user_id': userId,

      'purpose_of_event': purposeOfEvent,
      'hall_id': hallId,
      'type_of_hall': typeOfHall,

      'start_date': startDate,
      'end_date': endDate,

      'start_time': startTime,
      'end_time': endTime,

      'no_of_attendees': noOfAttendees,
      'remarks': remarks,
      'status': status,

      'workflow_execution_id': workflowExecutionId,

      'hall': hall?.toJson(),
    };
  }
}

class HallModel {
  final List<String>? jsonIgnore;

  final bool? isDeleted;

  final int? id;
  final int? createdBy;
  final String? createdAt;

  final int? updatedBy;
  final String? updatedAt;

  final String? name;
  final String? location;

  final int? departmentId;

  final String? locationNameInArabic;
  final String? hallNameInArabic;

  final String? hallType;

  HallModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.name,
    this.location,
    this.departmentId,
    this.locationNameInArabic,
    this.hallNameInArabic,
    this.hallType,
  });

  factory HallModel.fromJson(Map<String, dynamic> json) {
    return HallModel(
      jsonIgnore: json['jsonIgnore'] != null
          ? List<String>.from(json['jsonIgnore'])
          : [],

      isDeleted: json['is_deleted'],

      id: json['id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],

      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],

      name: json['name'],
      location: json['location'],

      departmentId: json['department_id'],

      locationNameInArabic: json['location_name_in_arabic'],
      hallNameInArabic: json['hall_name_in_arabic'],

      hallType: json['hall_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonIgnore': jsonIgnore,
      'is_deleted': isDeleted,

      'id': id,
      'created_by': createdBy,
      'created_at': createdAt,

      'updated_by': updatedBy,
      'updated_at': updatedAt,

      'name': name,
      'location': location,

      'department_id': departmentId,

      'location_name_in_arabic': locationNameInArabic,
      'hall_name_in_arabic': hallNameInArabic,

      'hall_type': hallType,
    };
  }
}
