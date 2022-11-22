import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  final String taskDate;
  final String date;
  bool? isDone;
  bool? isDeleted;

  Task({
    required this.title,
    required this.taskDate,
    required this.description,
    required this.id,
    required this.date,
    this.isDeleted,
    this.isDone,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? title,
    String? description,
    String? taskDate,
    String? id,
    String? date,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      taskDate: taskDate ?? this.taskDate,
      id: id ?? this.id,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'taskDate': taskDate,
      'id': id,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      taskDate: map['taskDate'] ?? '',
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        taskDate,
        id,
        date,
        isDone,
        isDeleted,
      ];
}
