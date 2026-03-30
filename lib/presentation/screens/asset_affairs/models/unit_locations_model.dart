class ResidentalUnitRentalLocationModel {
  final int? id;
  final String? locationName;
  final String? description;
  final bool? isActive;
  final int? displayOrder;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final bool? isDeleted;

  ResidentalUnitRentalLocationModel({
    this.id,
    this.locationName,
    this.description,
    this.isActive,
    this.displayOrder,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isDeleted,
  });

  /// ⭐ FROM JSON
  factory ResidentalUnitRentalLocationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResidentalUnitRentalLocationModel(
      id: json['id'],
      locationName: json['location_name'],
      description: json['description'],
      isActive: json['is_active'],
      displayOrder: json['display_order'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      isDeleted: json['is_deleted'],
    );
  }

  /// ⭐ TO JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "location_name": locationName,
      "description": description,
      "is_active": isActive,
      "display_order": displayOrder,
      "created_by": createdBy,
      "created_at": createdAt,
      "updated_by": updatedBy,
      "updated_at": updatedAt,
      "is_deleted": isDeleted,
    };
  }
}
