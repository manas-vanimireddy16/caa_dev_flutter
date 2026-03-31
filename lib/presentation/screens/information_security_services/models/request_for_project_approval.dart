import 'package:code_setup/presentation/models/base_request_model.dart';

class RequestForProjectApprovalResponse {
  final String? status;
  final List<RequestForProjectApprovalModel>? data;
  final int? total;

  const RequestForProjectApprovalResponse({this.status, this.data, this.total});

  factory RequestForProjectApprovalResponse.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return const RequestForProjectApprovalResponse();
    }

    return RequestForProjectApprovalResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) => RequestForProjectApprovalModel.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
    );
  }
}

class RequestForProjectApprovalModel {
  final int? departmentId;
  final String? phone;
  final String? dateOfSubmission;
  final String? titleOfProject;
  final BaseRequestModel? base;

  const RequestForProjectApprovalModel({
    this.departmentId,
    this.phone,
    this.dateOfSubmission,
    this.titleOfProject,
    this.base,
  });

  factory RequestForProjectApprovalModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RequestForProjectApprovalModel();
    }

    return RequestForProjectApprovalModel(
      base: BaseRequestModel.fromJson(json),

      departmentId: json['department_id'] as int?,
      phone: json['phone'] as String?,
      dateOfSubmission: json['date_of_submission'] as String?,
      titleOfProject: json['title_of_project'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "department_id": departmentId,
      "phone": phone,
      "date_of_submission": dateOfSubmission,
      "title_of_project": titleOfProject,
    };
  }
}
