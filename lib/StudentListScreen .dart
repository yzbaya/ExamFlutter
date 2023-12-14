import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

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
      birthDate:
          DateTime.tryParse(json['birthDate'] ?? '') ?? DateTime(2000, 1, 1),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> students = [];
  DateTime filterDate = DateTime(2000, 1, 1);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String data = await rootBundle.loadString('assets/student.json');
      Map<String, dynamic> jsonData = json.decode(data);
      List<dynamic> studentsData = jsonData['students'];

      List<Student> loadedStudents = studentsData.map((student) {
        return Student.fromJson(student);
      }).toList();

      setState(() {
        students = loadedStudents;
      });
    } catch (error) {
      print('Erreur lors du chargement du fichier JSON: $error');
    }
  }

  List<Student> filterStudentsByDate(DateTime date) {
    return students
        .where((student) => student.birthDate.isAfter(date))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Student> filteredStudents = filterStudentsByDate(filterDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des étudiants'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date de naissance:'),
                TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: filterDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        filterDate = pickedDate;
                        filteredStudents = filterStudentsByDate(filterDate);
                      });
                    }
                  },
                  child: Text(
                    '${filterDate.year}-${filterDate.month.toString().padLeft(2, '0')}-${filterDate.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredStudents[index].name),
                  subtitle: Text('Âge: ${filteredStudents[index].age}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
