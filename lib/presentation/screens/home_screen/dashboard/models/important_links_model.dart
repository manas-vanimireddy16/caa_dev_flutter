class ImportantLinkModel {
  final int? id;
  final String? title;
  final String? url;
  final bool? isDeleted;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  const ImportantLinkModel({
    this.id,
    this.title,
    this.url,
    this.isDeleted,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ImportantLinkModel.fromJson(Map<String, dynamic> json) {
    return ImportantLinkModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      isDeleted: json['is_deleted'] as bool?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'is_deleted': isDeleted,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
    };
  }
}

class ImportantLinksResponse {
  final String? status;
  final List<ImportantLinkModel> data;
  final int totalCount;

  const ImportantLinksResponse({
    this.status,
    required this.data,
    required this.totalCount,
  });

  factory ImportantLinksResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'] as List<dynamic>? ?? [];
    return ImportantLinksResponse(
      status: json['status'] as String?,
      data: rawList
          .map(
            (item) => ImportantLinkModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
      totalCount: json['total_count'] as int? ?? rawList.length,
    );
  }
}
