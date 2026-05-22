class KpiModel {
  final String? status;
  final KpiData? data;
  final KpiFilters? filters;

  KpiModel({this.status, this.data, this.filters});

  factory KpiModel.fromJson(Map<String, dynamic> json) {
    return KpiModel(
      status: json['status'],
      data: json['data'] != null ? KpiData.fromJson(json['data']) : null,
      filters: json['filters'] != null
          ? KpiFilters.fromJson(json['filters'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
      'filters': filters?.toJson(),
    };
  }
}

class KpiData {
  final int? totalTickets;
  final int? openTickets;
  final int? inProgress;
  final int? closed;
  final int? avgApprovalTimeHours;

  KpiData({
    this.totalTickets,
    this.openTickets,
    this.inProgress,
    this.closed,
    this.avgApprovalTimeHours,
  });

  factory KpiData.fromJson(Map<String, dynamic> json) {
    return KpiData(
      totalTickets: json['total_tickets'],
      openTickets: json['open_tickets'],
      inProgress: json['in_progress'],
      closed: json['closed'],
      avgApprovalTimeHours: json['avg_approval_time_hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_tickets': totalTickets,
      'open_tickets': openTickets,
      'in_progress': inProgress,
      'closed': closed,
      'avg_approval_time_hours': avgApprovalTimeHours,
    };
  }

  // -----------------------------
  // ✅ Dynamic Map for UI
  // -----------------------------
  Map<String, dynamic> toMap() {
    return {
      "Total Tickets": totalTickets ?? 0,
      "Open Tickets": openTickets ?? 0,
      "In Progress": inProgress ?? 0,
      "Closed": closed ?? 0,
      "Avg Approval (hrs)": avgApprovalTimeHours ?? 0,
    };
  }
}

class KpiFilters {
  final int? serviceId;
  final int? subServiceId;
  final String? startDate;
  final String? endDate;

  KpiFilters({this.serviceId, this.subServiceId, this.startDate, this.endDate});

  factory KpiFilters.fromJson(Map<String, dynamic> json) {
    return KpiFilters(
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
