class GoalResponseModel {
  final String status;
  final List<GoalModel> data;

  GoalResponseModel({required this.status, required this.data});

  factory GoalResponseModel.fromJson(Map<String, dynamic> json) {
    return GoalResponseModel(
      status: json['status'],
      data: (json['data'] as List).map((e) => GoalModel.fromJson(e)).toList(),
    );
  }
}

// class GoalModel {
//   final int id;
//   final String goalTitle;
//   final String goalDescription;
//   final int cyclePeriodId;
//   final bool isActive;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String cyclePeriod;
//   final int cycleYear;
//   final bool cyclePeriodActive;

//   int weight; // user input

//   GoalModel({
//     required this.id,
//     required this.goalTitle,
//     required this.goalDescription,
//     required this.cyclePeriodId,
//     required this.isActive,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.cyclePeriod,
//     required this.cycleYear,
//     required this.cyclePeriodActive,
//     this.weight = 0,
//   });

//   factory GoalModel.fromJson(Map<String, dynamic> json) {
//     return GoalModel(
//       id: json['id'],
//       goalTitle: json['goal_title'],
//       goalDescription: json['goal_description'],
//       cyclePeriodId: json['cycle_period_id'],
//       isActive: json['is_active'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       cyclePeriod: json['cycle_period'],
//       cycleYear: json['cycle_year'],
//       cyclePeriodActive: json['cycle_period_active'],
//     );
//   }

//   Map<String, dynamic> toWeightJson() {
//     return {"id": id, "weight": weight};
//   }
// }

class GoalModel {
  bool? isDeleted;
  int? id;
  int? requestId;
  String? goalTitle;
  String? goalId;
  String? goalDescription;
  int? goalWeight;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;

  GoalModel({
    this.isDeleted,
    this.id,
    this.requestId,
    this.goalTitle,
    this.goalId,
    this.goalDescription,
    this.goalWeight,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      isDeleted: json["is_deleted"],
      id: json["id"],
      requestId: json["request_id"],
      goalTitle: json["goal_title"],
      goalId: json["goal_id"],
      goalDescription: json["goal_description"],
      goalWeight: json["goal_weight"],
      createdBy: json["created_by"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "is_deleted": isDeleted,
      "id": id,
      "request_id": requestId,
      "goal_title": goalTitle,
      "goal_id": goalId,
      "goal_description": goalDescription,
      "goal_weight": goalWeight,
      "created_by": createdBy,
      "created_at": createdAt?.toIso8601String(),
      "updated_by": updatedBy,
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}
