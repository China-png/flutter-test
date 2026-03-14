import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tester_app/service/api_service.dart';

class AppData extends ChangeNotifier{

  final SharedPreferences prefs; // Добавляем поле для хранения пульта управления

  List<String> _fruits = ['Apple', 'Orange']; // Делаем список приватным
  int _counter = 0;
  bool _isloading = true; // Переменная что бы проверять пришли ли данные из http запроса
  final ApiService _apiService = ApiService();

  List<String> get fruits => _fruits; // Геттер для доступа извне
  int get counter => _counter;
  bool get isLoading => _isloading;

  // Конструктор теперь принимает prefs и может сразу загрузить данные
  AppData(this.prefs){
    _loadData();
  }

  void _loadData() async{
    _isloading = true; // 1. Ставим флаг "Загрузка..."
    notifyListeners();
    // Переменная _isLoading помогает нам управлять вниманием пользователя:
    // Когда _isLoading == true: Мы говорим интерфейсу: «Покажи крутилку поверх данных или вместо них. Мы сейчас связываемся с сервером!». 🔄
    // Когда _isLoading == false: Мы говорим: «Всё, курьер приехал, данные самые свежие, можно убирать индикатор загрузки». ✅

    try {
      // 2. Сначала быстро берем старые данные из памяти
      // Используем наш оператор ?? для установки значений по умолчанию
      _fruits = prefs.getStringList('items') ?? ['Apple', 'Orange'];
      _counter = prefs.getInt('counter') ?? 0;
      notifyListeners();

      // Делаем реальный запрос в интернет
      List<String> networkFruits = await _apiService.getFruits();

      // Если запрос успешен, обновляем список и сохраняем его в локальную память
      _fruits = networkFruits;
      await prefs.setStringList('items', _fruits);
    } catch (e) {
      // Если интернета нет или сервер выдал ошибку
      print('Error Loading: $e');
      // Здесь можно оставить старые данные из SharedPreferences
    } finally {
      // В любом случае выключаем крутилку
      _isloading = false;
      notifyListeners();
    }
  }



  void addFruit (String name) async{
    _fruits.add(name);
    notifyListeners();
    await prefs.setStringList('items', _fruits);
    // Когда ты вызываешь notifyListeners(), происходит следующее:
    // 1) Провайдер понимает, что данные внутри изменились.
    // 2) Он находит все виджеты, которые «слушают» этот класс (например, твой список фруктов).
    // 3) Он заставляет эти виджеты перерисоваться с новыми данными.
  }

  void incrementCounter () async{
    _counter++;
    notifyListeners();
    await prefs.setInt('counter', _counter);
  }

  void removeFruit(int index) async{
    _fruits.removeAt(index);
    notifyListeners();
    await prefs.setStringList('items', _fruits);
  }
}

// Источник (ChangeNotifier): Это резервуар с водой (твои данные: список фруктов и счетчик). У него есть насос (notifyListeners()), который толкает воду в трубы, когда уровень меняется 💧.
// Трубы (ChangeNotifierProvider): Это сама система коммуникаций. Она прокладывается по всему дому (дереву виджетов), чтобы вода могла дойти до любой комнаты 🏗️.
// Кран (Consumer или context.watch): Это точка доступа. Ты открываешь кран в конкретной комнате (виджете), чтобы получить воду. Если насос сработал, из крана сразу потечет обновленная вода 🚰.