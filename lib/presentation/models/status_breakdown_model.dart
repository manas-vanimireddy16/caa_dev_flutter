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
  final int? totalApprovals;
  final int? approved;
  final int? pending;
  final int? rejected;
  final int? inProgress;
  final List<ChartData>? breakdown;

  StatusData({
    this.timePeriod,
    this.totalRequests,
    this.totalApprovals,
    this.approved,
    this.pending,
    this.rejected,
    this.inProgress,
    this.breakdown,
  });

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  factory StatusData.fromJson(Map<String, dynamic> json) {
    final totalApprovals = _asInt(json['total_approvals']);
    final totalRequests =
        _asInt(json['total_requests']) ?? totalApprovals;

    return StatusData(
      timePeriod: json['time_period'] as String?,
      totalRequests: totalRequests,
      totalApprovals: totalApprovals,
      approved: _asInt(json['approved']),
      pending: _asInt(json['pending']),
      rejected: _asInt(json['rejected']),
      inProgress: _asInt(json['in_progress']),
      breakdown: (json['breakdown'] as List<dynamic>?)
          ?.map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_period': timePeriod,
      'total_requests': totalRequests,
      'total_approvals': totalApprovals,
      'approved': approved,
      'pending': pending,
      'rejected': rejected,
      'in_progress': inProgress,
      'breakdown': breakdown?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChartData {
  final String? status;
  final int? count;
  final double? percentage;

  ChartData({this.status, this.count, this.percentage});

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      status: json['status'] as String?,
      count: _asInt(json['count']),
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'count': count, 'percentage': percentage};
  }
}
