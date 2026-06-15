class PositionResponse {
  final String? status;
  final List<Position> data;
  final int? totalCount;

  const PositionResponse({this.status, required this.data, this.totalCount});

  factory PositionResponse.fromJson(Map<String, dynamic> json) {
    return PositionResponse(
      status: json['status'] as String?,
      totalCount: json['total_count'] as int?,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total_count': totalCount,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Position {
  final int? id;
  final String? name;

  const Position({this.id, this.name});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(id: json['id'] as int?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
