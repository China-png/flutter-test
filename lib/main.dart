import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'models/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future — это объект, который представляет результат асинхронной операции. Это своего рода «обещание» или «контейнер» для значения, которого еще нет, но которое появится позже.
// Есть 3 состояние Future: 1) Ожиание, 2) Выполнено, 3) Ошибка
Future<void> main() async {
  // нам нужно убедиться, что "движок" Flutter готов к общению с операционной системой телефона. Для этого первой строчкой в main обычно пишут:
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  // prefs контроллер для работы с локальными данными
  // Получает данные и держит в небольшом файле в оперативке для быстрого доступа. Позволяет вытаскивать данные из него без await

  // Оператор ??. Он работает так: выражение1 ?? выражение2.
  // Если левая часть не равна null, используется она. Если там null, то подставляется правая часть.

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Теперь HomeScreen — это отдельный класс ниже
    );
  }
}
