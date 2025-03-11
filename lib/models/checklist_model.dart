import 'dart:convert';

class ChecklistModel {
  final String id;
  String title;
  final String? iconPath;
  List<ChecklistSection> sections;

  ChecklistModel(
      {required this.id,
      required this.title,
      required this.iconPath,
      required this.sections});

  String get checkedCount =>
      sections.where((e) => e.isActive).length.toString();

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        id: json['id'],
        title: json['title'],
        iconPath: json['iconPath'],
        sections: (json['sections'] as List<dynamic>)
            .map((e) => ChecklistSection.fromJson(
                jsonDecode(e) as Map<String, dynamic>))
            .toList(),
      );

  String toJson() => json.encode({
        'id': id,
        'title': title,
        'iconPath': iconPath,
        'sections': sections.map((e) => e.toJson()).toList(),
      });
}

class ChecklistSection {
  final String title;
  bool isActive;

  ChecklistSection({required this.title, this.isActive = false});

  factory ChecklistSection.fromJson(Map<String, dynamic> json) =>
      ChecklistSection(
        title: json['title'],
        isActive: json['isActive'],
      );

  String toJson() => json.encode({
        'title': title,
        'isActive': isActive,
      });
}
