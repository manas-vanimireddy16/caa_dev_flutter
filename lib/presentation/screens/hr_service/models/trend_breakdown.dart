class ServiceTransferTrend {
  final String? status;
  final String? message;
  final ServiceTransferTrendData? data;

  ServiceTransferTrend({this.status, this.message, this.data});

  factory ServiceTransferTrend.fromJson(Map<String, dynamic> json) {
    return ServiceTransferTrend(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ServiceTransferTrendData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }

  Map<String, dynamic> toMap() {
    return {'status': status, 'message': message, 'data': data?.toMap()};
  }
}

class ServiceTransferTrendData {
  final int? year;
  final List<ServiceTransferMonthlyData>? monthlyData;

  ServiceTransferTrendData({this.year, this.monthlyData});

  factory ServiceTransferTrendData.fromJson(Map<String, dynamic> json) {
    return ServiceTransferTrendData(
      year: json['year'] as int?,
      monthlyData: (json['monthly_data'] as List<dynamic>?)
          ?.map(
            (e) =>
                ServiceTransferMonthlyData.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'monthly_data': monthlyData?.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'monthlyData': monthlyData?.map((e) => e.toMap()).toList(),
    };
  }
}

class ServiceTransferMonthlyData {
  final String? month;
  final int? monthNumber;
  final int? total;
  final int? approved;
  final int? pending;
  final int? rejected;

  ServiceTransferMonthlyData({
    this.month,
    this.monthNumber,
    this.total,
    this.approved,
    this.pending,
    this.rejected,
  });

  factory ServiceTransferMonthlyData.fromJson(Map<String, dynamic> json) {
    return ServiceTransferMonthlyData(
      month: json['month'] as String?,
      monthNumber: json['month_number'] as int?,
      total: json['total'] as int?,
      approved: json['approved'] as int?,
      pending: json['pending'] as int?,
      rejected: json['rejected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'month_number': monthNumber,
      'total': total,
      'approved': approved,
      'pending': pending,
      'rejected': rejected,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'monthNumber': monthNumber,
      'total': total,
      'approved': approved,
      'pending': pending,
      'rejected': rejected,
    };
  }
}
