class GoalListModel {
  final int id;
  final String title;
  final String description;
  int weight;

  GoalListModel({
    required this.id,
    required this.title,
    required this.description,
    this.weight = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "weight": weight,
      "title": title,
      "description": description,
    };
  }
}
