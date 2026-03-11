class SectionResponse {
  final String status;
  final List<Section> data;

  SectionResponse({required this.status, required this.data});

  factory SectionResponse.fromJson(Map<String, dynamic> json) {
    return SectionResponse(
      status: json['status'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Section.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class Section {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final String? departmentId;
  final String? createdAt;
  final String? updatedAt;

  Section({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.sectionName,
    this.sectionCode,
    this.sectionDescription,
    this.departmentId,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      sectionName: json['section_name'],
      sectionCode: json['section_code'],
      sectionDescription: json['section_description'],
      departmentId: json['department_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'section_name': sectionName,
      'section_code': sectionCode,
      'section_description': sectionDescription,
      'department_id': departmentId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
