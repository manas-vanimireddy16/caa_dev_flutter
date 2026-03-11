class TaskRD {
  final String taskName;
  final String status; // completed, pending, not_started
  final String approvedBy;
  final String? date;

  TaskRD({
    required this.taskName,
    required this.status,
    required this.approvedBy,
    this.date,
  });

  factory TaskRD.fromJson(Map<String, dynamic> json) {
    return TaskRD(
      taskName: json['taskName'],
      status: json['status'],
      approvedBy: json['approvedBy'],
      date: json['date'],
    );
  }
}
