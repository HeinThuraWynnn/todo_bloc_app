// lib/data/models/task_model.dart

import 'package:uuid/uuid.dart';

class Task {
  late final String id;
  final String title;
  final String description;
  bool isCompleted;

  Task({
    String? id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  }) : id = id ?? Uuid().v4();

  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'],
      isCompleted: (json['isCompleted'] is bool)
          ? json['isCompleted']
          : (json['isCompleted'] == 1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
