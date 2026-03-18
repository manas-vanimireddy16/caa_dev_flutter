import 'package:code_setup/presentation/models/base_request_model.dart';

class PerformanceManagementResponse {
  final String? status;
  final List<PerformanceManagementModel>? data;
  final int? total;

  const PerformanceManagementResponse({this.status, this.data, this.total});

  factory PerformanceManagementResponse.fromJson(Map<String, dynamic> json) {
    return PerformanceManagementResponse(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List?)
          ?.map(
            (e) =>
                PerformanceManagementModel.fromJson(e as Map<String, dynamic>?),
          )
          .toList(),
    );
  }
}

class PerformanceManagementModel {
  final BaseRequestModel base;

  /// Performance Management Fields
  final String? cyclePeriod;
  final int? cycleYear;

  const PerformanceManagementModel({
    required this.base,
    this.cyclePeriod,
    this.cycleYear,
  });

  factory PerformanceManagementModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PerformanceManagementModel(base: const BaseRequestModel());
    }

    return PerformanceManagementModel(
      base: BaseRequestModel.fromJson(json),

      cyclePeriod: json['cycle_period'] as String?,
      cycleYear: json['cycle_year'] as int?,
    );
  }
}
