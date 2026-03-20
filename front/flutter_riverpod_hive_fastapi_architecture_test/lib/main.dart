import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_hive_fastapi_architecture_test/models/todo.dart';
import 'package:flutter_riverpod_hive_fastapi_architecture_test/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Flutter 엔진 초기화 보장 (오타 수정: Widgets에 s 추가)
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Hive 초기화 (휴대폰 내부 저장소 경로 설정)
  await Hive.initFlutter();

  // 2. TypeAdapter 등록 (위에서 생성한 번역기를 등록)
  Hive.registerAdapter(TodoAdapter());

  // 3. 데이터를 담을 Box(테이블 같은 개념) 열기
  await Hive.openBox<Todo>('todosBox');

  runApp(
    // Riverpod을 사용하기 위해 반드시 앱 전체를 ProviderScope로 감싸야 함
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // 화면 UI를 띄워줍니다
    );
  }
}
