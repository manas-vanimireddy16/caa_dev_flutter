class ActivityFeedModel {
  final String? status;
  final String? message;
  final List<ActivityFeedData>? data;
  final int? totalCount;

  ActivityFeedModel({this.status, this.message, this.data, this.totalCount});

  factory ActivityFeedModel.fromJson(Map<String, dynamic> json) {
    return ActivityFeedModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ActivityFeedData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'total_count': totalCount,
    };
  }
}

class ActivityFeedData {
  final int? id;
  final String? requestNumber;
  final String? title;
  final String? status;
  final String? subType;
  final String? type;
  final String? category;
  final DateTime? timestamp;
  final DateTime? createdAt;

  ActivityFeedData({
    this.id,
    this.requestNumber,
    this.title,
    this.status,
    this.subType,
    this.type,
    this.category,
    this.timestamp,
    this.createdAt,
  });

  factory ActivityFeedData.fromJson(Map<String, dynamic> json) {
    return ActivityFeedData(
      id: json['id'] as int?,
      requestNumber: json['request_number'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      subType: json['sub_type'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_number': requestNumber,
      'title': title,
      'status': status,
      'sub_type': subType,
      'type': type,
      'category': category,
      'timestamp': timestamp?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
