import 'package:code_setup/presentation/models/base_request_model.dart';

class DashboardRequestModel {
  final BaseRequestModel? base;

  final bool? isDeleted;
  final int? id;
  final String? requestId;

  DashboardRequestModel({this.base, this.isDeleted, this.id, this.requestId});

  factory DashboardRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DashboardRequestModel();
    }

    return DashboardRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      isDeleted: json['is_deleted'],
      id: json['id'],
      requestId: json['request_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'is_deleted': isDeleted, 'id': id, 'request_id': requestId};
  }
}
