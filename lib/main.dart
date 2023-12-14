import 'package:flutter/material.dart';
import 'package:flutter_fichjson/StudentListScreen .dart';
//import 'package:flutter_fichjson/StudentListScreen%20.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentListScreen(),
    );
  }
} 
