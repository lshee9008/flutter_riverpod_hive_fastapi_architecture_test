import 'package:hive/hive.dart';

// Hive 코드 생성용 파일 - build_runner가 만들어 줌
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  Todo({required this.id, required this.title, required this.done});

  // fieldId도 고유해야 함 (0부터 시작)
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool done;

  // JSON <-> Todo 변환 (FastAPI 통신용)
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'] as String,
    title: json['title'] as String,
    done: json['done'] as bool,
  );

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'done': done};

  Todo copyWith({String? id, String? title, bool? done}) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    done: done ?? this.done,
  );
}
