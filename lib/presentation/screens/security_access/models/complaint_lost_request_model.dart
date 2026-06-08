import 'package:code_setup/presentation/models/base_request_model.dart';

class ComplaintLostPropertyRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final int? userId;

  final String? workflowExecutionId;

  final String? dateTimeOfLoss;
  final String? locationWhereItemWasLost;

  final String? itemDescription;
  final String? description;

  final String? referenceNumber;

  final String? status;

  ComplaintLostPropertyRequestModel({
    this.base,
    this.id,
    this.userId,
    this.workflowExecutionId,
    this.dateTimeOfLoss,
    this.locationWhereItemWasLost,
    this.itemDescription,
    this.description,
    this.referenceNumber,
    this.status,
  });

  factory ComplaintLostPropertyRequestModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return ComplaintLostPropertyRequestModel();
    }

    return ComplaintLostPropertyRequestModel(
      /// ⭐ BASE COMMON FIELDS
      base: BaseRequestModel.fromJson(json),

      id: json['id'],
      userId: json['user_id'],

      workflowExecutionId: json['workflow_execution_id'],

      dateTimeOfLoss: json['date_time_of_loss'],

      locationWhereItemWasLost: json['location_where_item_was_lost'],

      itemDescription: json['item_description'],

      description: json['description'],

      referenceNumber: json['reference_number'],

      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,

      'workflow_execution_id': workflowExecutionId,

      'date_time_of_loss': dateTimeOfLoss,

      'location_where_item_was_lost': locationWhereItemWasLost,

      'item_description': itemDescription,

      'description': description,

      'reference_number': referenceNumber,

      'status': status,
    };
  }
}
