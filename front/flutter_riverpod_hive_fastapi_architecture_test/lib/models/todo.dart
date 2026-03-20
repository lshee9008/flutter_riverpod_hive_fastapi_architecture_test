import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isCompleted;

  Todo({required this.id, required this.title, required this.isCompleted});

  // JSON -> 객체 변환 팩토리(API 응답 처리용)
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['is_completed'],
    );
  }
}
