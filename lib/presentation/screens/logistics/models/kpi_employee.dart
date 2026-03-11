// class KpiLogisticsResponse {
//   final String? status;
//   final String? message;
//   final KpiData? data;

//   KpiLogisticsResponse({this.status, this.message, this.data});

//   factory KpiLogisticsResponse.fromJson(Map<String, dynamic> json) {
//     return KpiLogisticsResponse(
//       status: json['status'],
//       message: json['message'],
//       data: json['data'] != null ? KpiData.fromJson(json['data']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'status': status,
//     'message': message,
//     'data': data?.toJson(),
//   };
// }

// class KpiData {
//   final int? totalRequests;
//   final int? approved;
//   final int? pending;
//   final int? rejected;

//   KpiData({this.totalRequests, this.approved, this.pending, this.rejected});

//   factory KpiData.fromJson(Map<String, dynamic> json) {
//     return KpiData(
//       totalRequests: json['total_requests'],
//       approved: json['approved'],
//       pending: json['pending'],
//       rejected: json['rejected'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'total_requests': totalRequests,
//     'approved': approved,
//     'pending': pending,
//     'rejected': rejected,
//   };

//   /// For easy UI rendering or card mapping
//   Map<String, dynamic> toMap() {
//     return {
//       "Total Requests": totalRequests ?? 0,
//       "Approved": approved ?? 0,
//       "Pending": pending ?? 0,
//       "Rejected": rejected ?? 0,
//     };
//   }
// }
