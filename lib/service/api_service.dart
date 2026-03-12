import 'package:http/http.dart' as http;
import 'dart:convert'; // Нужен для работы c JSON

class ApiService{

  Future<List<String>> getFruits() async {
    final url = Uri.parse(''); // Записывае ссылку в переменную url
    final response = await http.get(url); // Даем запрос get в интернет и ждем ответа. http.get возвращает тип данных типа Future<Response>

    if(response.statusCode == 200) {
      // Здесь мы превратим текст из интернета в реальный список
      List<dynamic> data = json.decode(response.body); // decode нужен так как данные приходят в виде одной длинной строки а decode упорядочивает все
      // После того как json.decode превратил текст в «понятный» для Dart объект (обычно это List или Map),
      // нам нужно убедиться, что каждый элемент внутри — это именно строка. Поэтому мы используем:
      return data.map((item) => item.toString()).toList();
    }
    else {
      throw Exception('Не удалось загрузить фрукты');
    }
  }
}