class ResidentalUnitRentalApartmentModel {
  final int? id;
  final String? apartmentType;
  final int? costPerType;
  final String? description;
  final bool? isActive;
  final int? displayOrder;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final bool? isDeleted;

  ResidentalUnitRentalApartmentModel({
    this.id,
    this.apartmentType,
    this.costPerType,
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
  factory ResidentalUnitRentalApartmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResidentalUnitRentalApartmentModel(
      id: json['id'],
      apartmentType: json['apartment_type_name'],
      costPerType: json['cost_per_type'],
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
      "apartment_type_name": apartmentType,
      "cost_per_type": costPerType,
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
