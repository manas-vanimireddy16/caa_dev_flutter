class KPIResponse {
  final String? status;
  final String? message;
  final KPIData? data;

  KPIResponse({this.status, this.message, this.data});

  factory KPIResponse.fromJson(Map<String, dynamic> json) {
    return KPIResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? KPIData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class KPIData {
  final int? totalRequests;
  final int? totalApprovals;
  final int? approved;
  final int? closed;
  final int? pending;
  final int? rejected;
  final int? expired;
  final int? pendingActionItems;
  final int? inProgress;
  final int? assigned;
  final int? completed;

  KPIData({
    this.totalRequests,
    this.totalApprovals,
    this.approved,
    this.closed,
    this.pending,
    this.rejected,
    this.expired,
    this.pendingActionItems,
    this.inProgress,
    this.assigned,
    this.completed,
  });

  factory KPIData.fromJson(Map<String, dynamic> json) {
    return KPIData(
      totalRequests: json['total_requests'],
      totalApprovals: json['total_approvals'],
      approved: json['approved'],
      pending: json['pending'],
      closed: json['closed'],
      rejected: json['rejected'],
      expired: json['expired'],
      pendingActionItems:
          json['pendingActionItems'] ?? json['pending_action_items'],
      inProgress: json['in_progress'],
      assigned: json['assigned'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'totalRequests': totalRequests,
    'totalApprovals': totalApprovals,
    'approved': approved,
    'closed': closed,
    'pending': pending,
    'rejected': rejected,
    'expired': expired,
    'in_progress': inProgress,
    'assigned': assigned,
    'completed': completed,
    'pendingActionItems': pendingActionItems,
  };
}

class KPIBreakdown {
  final KPICategory? logistics;
  final KPICategory? foreignVehicle;

  KPIBreakdown({this.logistics, this.foreignVehicle});

  factory KPIBreakdown.fromJson(Map<String, dynamic> json) {
    return KPIBreakdown(
      logistics: json['logistics'] != null
          ? KPICategory.fromJson(json['logistics'])
          : null,
      foreignVehicle: json['foreign_vehicle'] != null
          ? KPICategory.fromJson(json['foreign_vehicle'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'logistics': logistics?.toJson(),
    'foreign_vehicle': foreignVehicle?.toJson(),
  };
}

class KPICategory {
  final int? totalRequests;
  final int? approved;
  final int? pending;
  final int? rejected;

  KPICategory({this.totalRequests, this.approved, this.pending, this.rejected});

  factory KPICategory.fromJson(Map<String, dynamic> json) {
    return KPICategory(
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
