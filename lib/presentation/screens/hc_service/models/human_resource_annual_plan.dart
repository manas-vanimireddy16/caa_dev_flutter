import 'package:code_setup/presentation/models/base_request_model.dart';

class HumanResourceAnnualPlanningResponse {
  final String? status;
  final List<HumanResourceAnnualPlanningModel>? data;
  final int? total;

  const HumanResourceAnnualPlanningResponse({
    this.status,
    this.data,
    this.total,
  });

  factory HumanResourceAnnualPlanningResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HumanResourceAnnualPlanningResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) => HumanResourceAnnualPlanningModel.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
    );
  }
}

class HumanResourceAnnualPlanningModel {
  final BaseRequestModel base;

  /// Performance Management Fields
  final String? extensionNumber;
  final String? quater;
  final int? year;
  final List<TaskModel>? tasks;

  const HumanResourceAnnualPlanningModel({
    required this.base,
    
    this.extensionNumber,
    this.quater,
    this.year,
    this.tasks,
  });

  factory HumanResourceAnnualPlanningModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return HumanResourceAnnualPlanningModel(base: const BaseRequestModel());
    }

    return HumanResourceAnnualPlanningModel(
      base: BaseRequestModel.fromJson(json),

      extensionNumber: json['extension_number'] as String?,
      quater: json['quater'] as String?,
      year: json['year'] as int?,
      tasks: (json['tasks'] as List?)
          ?.map(
            (e) => TaskModel.fromJson(e as Map<String, dynamic>?),
          )
          .toList(),

    );
  }
}

class TaskModel {
  final int? id;
  final int? requestId;
  final String? extensionNumber;
  final String? dailyResponsibilities;
  final String? taskRelatedToProjects;
  final String? repeatFrequency;
  final String? duration;
  final String? durationUnit;
  final String? deliverables;
  final int? createdBy;
  final DateTime? createdAt;
  final int? updatedBy;
  final DateTime? updatedAt;
  final bool? isDeleted;

  const TaskModel({
    this.id,
    this.requestId,
    this.extensionNumber,
    this.dailyResponsibilities,
    this.taskRelatedToProjects,
    this.repeatFrequency,
    this.duration,
    this.durationUnit,
    this.deliverables,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isDeleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TaskModel();

    return TaskModel(
      id: json['id'] as int?,
      requestId: json['request_id'] as int?,
      extensionNumber: json['extension_number'] as String?,
      dailyResponsibilities: json['daily_responsibilities'] as String?,
      taskRelatedToProjects:
          json['task_related_to_projects'] as String?,
      repeatFrequency: json['repeat_frequency'] as String?,
      duration: json['duration'] as String?,
      durationUnit: json['duration_unit'] as String?,
      deliverables: json['deliverables'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      isDeleted: json['is_deleted'] as bool?,
    );
  }
}