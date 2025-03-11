import 'dart:convert';

class CalendarModel {
  final String title;
  final DateTime date;
  final DateTime start;
  final DateTime end;
  final String note;

  const CalendarModel({
    required this.title,
    required this.date,
    required this.start,
    required this.end,
    required this.note,
  });

  String toJson() => json.encode({
        'title': title,
        'date': date.toString(),
        'start': start.toString(),
        'end': end.toString(),
        'note': note,
      });

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        title: json['title'],
        date: DateTime.parse(json['date']),
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']),
        note: json['note'],
      );

  CalendarModel copyWith(DateTime newDate) => CalendarModel(
        title: title,
        date: newDate,
        start: start,
        end: end,
        note: note,
      );
}
