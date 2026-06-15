class GoalListModel {
  final int id;
  final String title;
  final String description;
  final int? weight;

  GoalListModel({
    required this.id,
    required this.title,
    required this.description,
    this.weight,
  });

  GoalListModel copyWith({int? weight}) {
    return GoalListModel(
      id: id,
      title: title,
      description: description,
      weight: weight ?? this.weight,
    );
  }
}
