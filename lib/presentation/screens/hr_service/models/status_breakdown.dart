class ServiceTransferStatus {
  final String? status;
  final String? message;
  final ServiceTransferStatusData? data;

  ServiceTransferStatus({this.status, this.message, this.data});

  factory ServiceTransferStatus.fromJson(Map<String, dynamic> json) {
    return ServiceTransferStatus(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ServiceTransferStatusData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class ServiceTransferStatusData {
  final String? timePeriod;
  final int? totalRequests;
  final int? totalApprovals;
  final int? approved;
  final int? pending;
  final int? rejected;
  final List<ServiceTransferStatusBreakdown>? breakdown;

  ServiceTransferStatusData({
    this.timePeriod,
    this.totalRequests,
    this.totalApprovals,
    this.approved,
    this.pending,
    this.rejected,
    this.breakdown,
  });

  factory ServiceTransferStatusData.fromJson(Map<String, dynamic> json) {
    return ServiceTransferStatusData(
      timePeriod: json['time_period'] as String?,
      totalRequests: json['total_requests'] as int?,
      totalApprovals: json['total_approvals'] as int?,
      approved: json['approved'] as int?,
      pending: json['pending'] as int?,
      rejected: json['rejected'] as int?,
      breakdown: (json['breakdown'] as List<dynamic>?)
          ?.map(
            (e) => ServiceTransferStatusBreakdown.fromJson(
              e as Map<String, dynamic>,
            ),
          )
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
      'breakdown': breakdown?.map((e) => e.toJson()).toList(),
    };
  }
}

class ServiceTransferStatusBreakdown {
  final String? status;
  final int? count;
  final double? percentage;

  ServiceTransferStatusBreakdown({this.status, this.count, this.percentage});

  factory ServiceTransferStatusBreakdown.fromJson(Map<String, dynamic> json) {
    return ServiceTransferStatusBreakdown(
      status: json['status'] as String?,
      count: json['count'] as int?,
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'count': count, 'percentage': percentage};
  }
}
