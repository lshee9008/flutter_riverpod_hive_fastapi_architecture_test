import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_hive_fastapi_architecture_test/models/todo.dart';
import 'package:flutter_riverpod_hive_fastapi_architecture_test/services/api_services.dart';
import 'package:hive/hive.dart';

final apiServiceProvider = Provider((ref) => ApiServices());

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(ref.read(apiServiceProvider));
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final ApiServices apiService;

  TodoNotifier(this.apiService) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final box = Hive.box<Todo>('todosBox');

    // 1단계: 캐시 데이터가 있으면 바로 UI 상태(state)에 밀어 넣는다.
    if (box.isNotEmpty) {
      state = box.values.toList();
    }

    // 2단계: 최신 데이터 요청 및 동기화
    try {
      final freshTodos = await apiService.fetchTodos();

      // 서버에서 가져온 데이터가 정상이라면, 기존 박스를 비우고 새 데이터를 채움
      await box.clear();
      await box.addAll(freshTodos);

      //상태 업데이트 -> 이 순간 화면이 최신 데이터로 리블드 됨.
      state = freshTodos;
    } catch (e) {
      // 3단계: 오프라인이거나 서버가 죽었을 때의 예외 처리
      // API 호출이 실패해도, 1단계에서 불러온 로컬 데이터(state)가 유지되므로
      // 앱이 튕기거나 빈 화면이 나오지 않는다. 이것이 Hive를 쓰는 이유
      print("서버 통신 실패, 로컬 캐시를 유지합니다: $e");
    }
  }
}
