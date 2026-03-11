class LogisticsStatusBreakdownModel {
  final String? status;
  final String? message;
  final LogisticsStatusData? data;

  LogisticsStatusBreakdownModel({this.status, this.message, this.data});

  factory LogisticsStatusBreakdownModel.fromJson(Map<String, dynamic> json) {
    return LogisticsStatusBreakdownModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? LogisticsStatusData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class LogisticsStatusData {
  final String? timePeriod;
  final int? totalRequests;
  final int? approved;
  final int? pending;
  final int? rejected;
  final List<ChartData>? breakdown;

  LogisticsStatusData({
    this.timePeriod,
    this.totalRequests,
    this.approved,
    this.pending,
    this.rejected,
    this.breakdown,
  });

  factory LogisticsStatusData.fromJson(Map<String, dynamic> json) {
    return LogisticsStatusData(
      timePeriod: json['time_period'] as String?,
      totalRequests: json['total_requests'] as int?,
      approved: json['approved'] as int?,
      pending: json['pending'] as int?,
      rejected: json['rejected'] as int?,
      breakdown: (json['breakdown'] as List<dynamic>?)
          ?.map((e) => ChartData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_period': timePeriod,
      'total_requests': totalRequests,
      'approved': approved,
      'pending': pending,
      'rejected': rejected,
      'breakdown': breakdown?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChartData {
  final String? status;
  final int? count;
  final double? percentage;

  ChartData({this.status, this.count, this.percentage});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      status: json['status'] as String?,
      count: json['count'] as int?,
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'count': count, 'percentage': percentage};
  }
}
