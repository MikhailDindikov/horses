class TrainingModel {
  final String task;
  final DateTime date;
  final DateTime notifDate;
  final DateTime startTime;
  final DateTime endTime;
  final String note;

  const TrainingModel({
    required this.task,
    required this.date,
    required this.notifDate,
    required this.startTime,
    required this.endTime,
    required this.note,
  });
}
