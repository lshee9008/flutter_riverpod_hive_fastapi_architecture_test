import 'dart:convert';

import 'package:flutter_riverpod_hive_fastapi_architecture_test/models/todo.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "http://localhost:8000";

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((dynamic item) => Todo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
