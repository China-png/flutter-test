import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier{

  final SharedPreferences prefs; // Добавляем поле для хранения пульта управления

  List<String> _fruits = ['Apple', 'Orange']; // Делаем список приватным
  int _counter = 0;

  // Конструктор теперь принимает prefs и может сразу загрузить данные
  AppData(this.prefs){
    _loadData();
  }

  void _loadData(){
    // Используем наш оператор ?? для установки значений по умолчанию
    _fruits = prefs.getStringList('items') ?? ['Apple', 'Orange'];
    _counter = prefs.getInt('counter') ?? 0;
    notifyListeners();
  }

  List<String> get fruits => _fruits; // Геттер для доступа извне
  int get counter => _counter;

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