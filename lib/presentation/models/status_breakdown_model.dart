class StatusBreakdownModel {
  final String? status;
  final String? message;
  final StatusData? data;

  StatusBreakdownModel({this.status, this.message, this.data});

  factory StatusBreakdownModel.fromJson(Map<String, dynamic> json) {
    return StatusBreakdownModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? StatusData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class StatusData {
  final String? timePeriod;
  final int? totalRequests;
  final int? approved;
  final int? pending;
  final int? rejected;
  final List<ChartData>? breakdown;

  StatusData({
    this.timePeriod,
    this.totalRequests,
    this.approved,
    this.pending,
    this.rejected,
    this.breakdown,
  });

  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
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
