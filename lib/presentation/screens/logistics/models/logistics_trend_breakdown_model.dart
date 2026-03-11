class LogisticsTrendBreakdownModel {
  final String? status;
  final String? message;
  final LogisticsTrendData? data;

  LogisticsTrendBreakdownModel({this.status, this.message, this.data});

  factory LogisticsTrendBreakdownModel.fromJson(Map<String, dynamic> json) {
    return LogisticsTrendBreakdownModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? LogisticsTrendData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }

  /// ✅ Dart-friendly map version (good for local storage or state)
  Map<String, dynamic> toMap() {
    return {'status': status, 'message': message, 'data': data?.toMap()};
  }
}

class LogisticsTrendData {
  final int? year;
  final int? totalRequests;
  final List<TrendData>? trendData;

  LogisticsTrendData({this.year, this.totalRequests, this.trendData});

  factory LogisticsTrendData.fromJson(Map<String, dynamic> json) {
    return LogisticsTrendData(
      year: json['year'] as int?,
      totalRequests: json['total_requests'] as int?,
      trendData: (json['trend_data'] as List<dynamic>?)
          ?.map((item) => TrendData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'total_requests': totalRequests,
      'trend_data': trendData?.map((e) => e.toJson()).toList(),
    };
  }

  /// ✅ Dart-friendly map version
  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'totalRequests': totalRequests,
      'trendData': trendData?.map((e) => e.toMap()).toList(),
    };
  }
}

class TrendData {
  final String? month;
  final int? year;
  final int? count;

  TrendData({this.month, this.year, this.count});

  factory TrendData.fromJson(Map<String, dynamic> json) {
    return TrendData(
      month: json['month'] as String?,
      year: json['year'] as int?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'year': year, 'count': count};
  }

  /// ✅ Dart-friendly map version
  Map<String, dynamic> toMap() {
    return {'month': month, 'year': year, 'count': count};
  }
}
