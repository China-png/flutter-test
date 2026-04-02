class Fruits{
  final int id;
  final String name;
  final DateTime created_at;

  Fruits({
    required this.id,
    required this.name,
    required this.created_at
});

  // "Фабрика", которая превращает Map в объект Fruits
  factory Fruits.fromMap(Map<String, dynamic> map) {
    return Fruits(
        id: map['id'], // Берем значение по ключу 'id'
        name: map['name'], // Берем значение по ключу 'name'
        created_at: DateTime.parse(map['created_at']) // Превращаем строку в дату
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': created_at.toIso8601String(),
    };
  }
}