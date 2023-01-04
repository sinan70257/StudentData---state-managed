import 'package:flutter/material.dart';
import 'package:student_management/presentation/add_student/add_students.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: AddStudentsWidget(),
      ),
    );
  }
}
