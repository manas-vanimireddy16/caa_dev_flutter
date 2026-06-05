import 'package:code_setup/presentation/models/base_request_model.dart';

class FollowUpReportRequestModel {
  final BaseRequestModel? base;

  final int? id;
  final int? userId;

  final String? sentBy;
  final String? letterDate;

  final String? subject;
  final String? subjectClassification;

  final String? topic;
  final String? concernedDepartment;

  final String? dateFrom;
  final String? dateTo;

  final String? requestSubmissionDate;

  final String? status;

  FollowUpReportRequestModel({
    this.base,
    this.id,
    this.userId,
    this.sentBy,
    this.letterDate,
    this.subject,
    this.subjectClassification,
    this.topic,
    this.concernedDepartment,
    this.dateFrom,
    this.dateTo,
    this.requestSubmissionDate,
    this.status,
  });

  factory FollowUpReportRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return FollowUpReportRequestModel();
    }

    return FollowUpReportRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      id: json['id'],
      userId: json['user_id'],

      sentBy: json['sent_by'],
      letterDate: json['letter_date'],

      subject: json['subject'],
      subjectClassification: json['subject_classification'],

      topic: json['topic'],
      concernedDepartment: json['concerned_department'],

      dateFrom: json['date_from'],
      dateTo: json['date_to'],

      requestSubmissionDate: json['request_submission_date'],

      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,

      'sent_by': sentBy,
      'letter_date': letterDate,

      'subject': subject,
      'subject_classification': subjectClassification,

      'topic': topic,
      'concerned_department': concernedDepartment,

      'date_from': dateFrom,
      'date_to': dateTo,

      'request_submission_date': requestSubmissionDate,

      'status': status,
    };
  }
}
