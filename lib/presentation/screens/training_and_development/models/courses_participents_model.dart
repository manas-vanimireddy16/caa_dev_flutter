import 'package:code_setup/presentation/models/base_request_model.dart';

class CourseNameResponseModel {
  final String? status;
  final int? totalCount;
  final List<CourseName> data;

  CourseNameResponseModel({this.status, this.totalCount, required this.data});

  factory CourseNameResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseNameResponseModel(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List? ?? [])
          .map((e) => CourseName.fromJson(e))
          .toList(),
    );
  }
}

class CourseName {
  final BaseRequestModel? base;

  final bool? isDeleted;
  final int? id;
  final int? userId;

  final String? courseName;
  final String? courseCost;
  final String? totalCost;
  final String? proposedImplementationDate;
  final String? description;
  final String? place;
  final String? reason;
  final String? status;

  final ParticipantsModel? participants;

  CourseName({
    this.base,
    this.isDeleted,
    this.id,
    this.userId,
    this.courseName,
    this.courseCost,
    this.totalCost,
    this.proposedImplementationDate,
    this.description,
    this.place,
    this.reason,
    this.status,
    this.participants,
  });

  factory CourseName.fromJson(Map<String, dynamic> json) {
    return CourseName(
      base: json['base'] != null
          ? BaseRequestModel.fromJson(json['base'])
          : null,

      isDeleted: json['is_deleted'],
      id: json['id'],
      userId: json['user_id'],

      courseName: json['course_name'],
      courseCost: json['course_cost'],
      totalCost: json['total_cost'],
      proposedImplementationDate: json['proposed_implementation_date'],
      description: json['description'],
      place: json['place'],
      reason: json['reason'],
      status: json['status'],

      participants: json['participants'] != null
          ? ParticipantsModel.fromJson(json['participants'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "is_deleted": isDeleted,
      "id": id,
      "user_id": userId,

      "course_name": courseName,
      "course_cost": courseCost,
      "total_cost": totalCost,
      "proposed_implementation_date": proposedImplementationDate,
      "description": description,
      "place": place,
      "reason": reason,
      "status": status,

      "participants": participants?.toJson(),
    };
  }
}

class ParticipantsModel {
  final int? noOfParticipants;
  final List<String>? nameOfParticipants;
  final List<dynamic>? employeeList;

  ParticipantsModel({
    this.noOfParticipants,
    this.nameOfParticipants,
    this.employeeList,
  });

  factory ParticipantsModel.fromJson(Map<String, dynamic> json) {
    return ParticipantsModel(
      noOfParticipants: json['no_of_participants'],

      nameOfParticipants: (json['name_of_participants'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      employeeList: json['employee_list'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "no_of_participants": noOfParticipants,

      "name_of_participants": nameOfParticipants,

      "employee_list": employeeList,
    };
  }
}
