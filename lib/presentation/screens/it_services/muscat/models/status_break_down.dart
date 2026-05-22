class StatusBreakdown {
  final String? status;
  final StatusBreakdownData? data;

  StatusBreakdown({this.status, this.data});

  factory StatusBreakdown.fromJson(Map<String, dynamic> json) {
    return StatusBreakdown(
      status: json['status'] as String?,
      data: json['data'] != null
          ? StatusBreakdownData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}

class StatusBreakdownData {
  final int? totalTickets;
  final List<ChartData>? breakdown;

  StatusBreakdownData({this.totalTickets, this.breakdown});

  factory StatusBreakdownData.fromJson(Map<String, dynamic> json) {
    var breakdownList = json['breakdown'] as List<dynamic>?;
    List<ChartData>? breakdownItems = breakdownList
        ?.map((item) => ChartData.fromJson(item))
        .toList();

    return StatusBreakdownData(
      totalTickets: json['total_tickets'] as int?,
      breakdown: breakdownItems,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_tickets': totalTickets,
    'breakdown': breakdown?.map((item) => item.toJson()).toList(),
  };
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

  Map<String, dynamic> toJson() => {
    'status': status,
    'count': count,
    'percentage': percentage,
  };
}
