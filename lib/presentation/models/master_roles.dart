import 'dart:convert';

MasterRoles rolesResponseFromJson(String str) =>
    MasterRoles.fromJson(json.decode(str));

String rolesResponseToJson(MasterRoles data) => json.encode(data.toJson());

class MasterRoles {
  String? status;
  String? message;
  List<MasterRolesModel>? data;
  int? totalCount;
  int? offset;
  int? limit;

  MasterRoles({
    this.status,
    this.message,
    this.data,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory MasterRoles.fromJson(Map<String, dynamic> json) => MasterRoles(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<MasterRolesModel>.from(
            json["data"].map((x) => MasterRolesModel.fromJson(x)),
          ),
    totalCount: json["total_count"],
    offset: json["offset"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_count": totalCount,
    "offset": offset,
    "limit": limit,
  };
}

class MasterRolesModel {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;
  String? name;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  MasterRolesModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory MasterRolesModel.fromJson(Map<String, dynamic> json) =>
      MasterRolesModel(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<String>.from(json["jsonIgnore"].map((x) => x)),
        isDeleted: json["is_deleted"],
        id: json["id"],
        name: json["name"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
    "jsonIgnore": jsonIgnore == null
        ? []
        : List<dynamic>.from(jsonIgnore!.map((x) => x)),
    "is_deleted": isDeleted,
    "id": id,
    "name": name,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_by": updatedBy,
    "updated_at": updatedAt,
  };
}
