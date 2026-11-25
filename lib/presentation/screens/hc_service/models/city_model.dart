class CityModel {
  final int? id;
  final String? cityName;
  final String? cityNameArabic;
  final int? countryId;
  final bool? isActive;

  const CityModel({
    this.id,
    this.cityName,
    this.cityNameArabic,
    this.countryId,
    this.isActive,
  });

  factory CityModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CityModel();
    return CityModel(
      id: json['id'] as int?,
      cityName: (json['city_name'] ?? json['name'])?.toString(),
      cityNameArabic: json['city_name_arabic']?.toString(),
      countryId: json['country_id'] as int?,
      isActive: json['is_active'] as bool?,
    );
  }
}
