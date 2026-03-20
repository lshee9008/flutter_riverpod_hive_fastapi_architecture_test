// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart'; // 프로바이더를 불러옵니다

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 구독
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Riverpod + Hive + FastAPI')),
      body: todos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Icon(
                    todo.isCompleted
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: todo.isCompleted ? Colors.green : Colors.grey,
                  ),
                );
              },
            ),
    );
  }
}
