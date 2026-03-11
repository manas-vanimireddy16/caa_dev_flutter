class Task {
  final String taskName;
  final String status; // completed, pending, not_started
  final String approvedBy;
  final String? date;

  Task({
    required this.taskName,
    required this.status,
    required this.approvedBy,
    this.date,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['taskName'],
      status: json['status'],
      approvedBy: json['approvedBy'],
      date: json['date'],
    );
  }
}
