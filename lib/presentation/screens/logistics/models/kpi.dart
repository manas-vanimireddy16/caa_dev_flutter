class CombinedKpiLogisticsResponse {
  final String? status;
  final String? message;
  final KpiData? data;

  CombinedKpiLogisticsResponse({this.status, this.message, this.data});

  factory CombinedKpiLogisticsResponse.fromJson(Map<String, dynamic> json) {
    return CombinedKpiLogisticsResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? KpiData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class KpiData {
  final int? totalRequests;
  final int? approved;
  final int? pending;
  final int? rejected;
  final KpiBreakdown? breakdown;

  KpiData({
    this.totalRequests,
    this.approved,
    this.pending,
    this.rejected,
    this.breakdown,
  });

  factory KpiData.fromJson(Map<String, dynamic> json) {
    return KpiData(
      totalRequests: json['total_requests'],
      approved: json['approved'],
      pending: json['pending'],
      rejected: json['rejected'],
      breakdown: json['breakdown'] != null
          ? KpiBreakdown.fromJson(json['breakdown'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_requests': totalRequests,
    'approved': approved,
    'pending': pending,
    'rejected': rejected,
    'breakdown': breakdown?.toJson(),
  };

  /// Optional: For UI mapping (e.g., dashboard cards)
  Map<String, dynamic> toMap() {
    return {
      "Total Requests": totalRequests ?? 0,
      "Approved": approved ?? 0,
      "Pending": pending ?? 0,
      "Rejected": rejected ?? 0,
    };
  }
}

class KpiBreakdown {
  final KpiCategory? logistics;
  final KpiCategory? foreignVehicle;

  KpiBreakdown({this.logistics, this.foreignVehicle});

  factory KpiBreakdown.fromJson(Map<String, dynamic> json) {
    return KpiBreakdown(
      logistics: json['logistics'] != null
          ? KpiCategory.fromJson(json['logistics'])
          : null,
      foreignVehicle: json['foreign_vehicle'] != null
          ? KpiCategory.fromJson(json['foreign_vehicle'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'logistics': logistics?.toJson(),
    'foreign_vehicle': foreignVehicle?.toJson(),
  };
}

class KpiCategory {
  final int? totalRequests;
  final int? approved;
  final int? pending;
  final int? rejected;

  KpiCategory({this.totalRequests, this.approved, this.pending, this.rejected});

  factory KpiCategory.fromJson(Map<String, dynamic> json) {
    return KpiCategory(
      totalRequests: json['total_requests'],
      approved: json['approved'],
      pending: json['pending'],
      rejected: json['rejected'],
    );
  }

  Map<String, dynamic> toJson() => {
    'total_requests': totalRequests,
    'approved': approved,
    'pending': pending,
    'rejected': rejected,
  };
}
