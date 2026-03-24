class HrTask {
  final String task;
  final String responsibility;
  final String frequency;
  final String duration;

  const HrTask({
    required this.task,
    required this.responsibility,
    required this.frequency,
    required this.duration,
  });

  HrTask copyWith({
    String? task,
    String? responsibility,
    String? frequency,
    String? duration,
  }) {
    return HrTask(
      task: task ?? this.task,
      responsibility: responsibility ?? this.responsibility,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
    );
  }
}
