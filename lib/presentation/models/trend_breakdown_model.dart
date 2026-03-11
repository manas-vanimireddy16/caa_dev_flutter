class TrendBreakdownModel {
  final String? status;
  final String? message;
  final TrendBreakDown? data;

  TrendBreakdownModel({this.status, this.message, this.data});

  factory TrendBreakdownModel.fromJson(Map<String, dynamic> json) {
    return TrendBreakdownModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? TrendBreakDown.fromJson(json['data']) : null,
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

class TrendBreakDown {
  final int? year;
  final int? totalRequests;
  final List<TrendData>? trendData;

  TrendBreakDown({this.year, this.totalRequests, this.trendData});

  factory TrendBreakDown.fromJson(Map<String, dynamic> json) {
    return TrendBreakDown(
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
