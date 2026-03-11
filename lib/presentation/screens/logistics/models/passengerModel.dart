class PassengerModel {
  final String name;

  PassengerModel({required this.name});

  Map<String, dynamic> toJson() => {"name": name};

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(name: json['name'] ?? '');
  }
}
