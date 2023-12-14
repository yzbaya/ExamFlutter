class Student {
  final int id;
  final String image;
  final String name;
  final int age;
  final DateTime birthDate;

  Student({
    required this.id,
    required this.image,
    required this.name,
    required this.age,
    required this.birthDate,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      birthDate: DateTime.parse(
          json['birthDate'] ?? ''), 
    );
  }
}
