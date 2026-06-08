class StationListResponseModel {
  final String? status;
  final List<StationModel>? data;

  StationListResponseModel({this.status, this.data});

  factory StationListResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return StationListResponseModel();
    }

    return StationListResponseModel(
      status: json['status'],

      data: (json['data'] as List?)
          ?.map((e) => StationModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class StationModel {
  final bool? isDeleted;

  final int? id;

  final String? stationName;
  final String? stationCode;

  final int? createdBy;
  final String? createdAt;

  final int? updatedBy;
  final String? updatedAt;

  final String? stationArabicName;

  final String? location;
  final String? description;

  final List<dynamic>? jsonIgnore;

  StationModel({
    this.isDeleted,
    this.id,
    this.stationName,
    this.stationCode,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.stationArabicName,
    this.location,
    this.description,
    this.jsonIgnore,
  });

  factory StationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return StationModel();
    }

    return StationModel(
      isDeleted: json['is_deleted'],

      id: json['id'],

      stationName: json['station_name'],
      stationCode: json['station_code'],

      createdBy: json['created_by'],
      createdAt: json['created_at'],

      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],

      stationArabicName: json['station_arabic_name'],

      location: json['location'],
      description: json['description'],

      jsonIgnore: json['jsonIgnore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_deleted': isDeleted,

      'id': id,

      'station_name': stationName,
      'station_code': stationCode,

      'created_by': createdBy,
      'created_at': createdAt,

      'updated_by': updatedBy,
      'updated_at': updatedAt,

      'station_arabic_name': stationArabicName,

      'location': location,
      'description': description,

      'jsonIgnore': jsonIgnore,
    };
  }
}
