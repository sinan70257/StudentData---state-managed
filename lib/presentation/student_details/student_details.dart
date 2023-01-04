import 'package:flutter/material.dart';

import 'dart:io';

import 'package:student_management/presentation/student_details/widgets/details.dart';

class ShowDetails extends StatelessWidget {
  var data;
  var student;

  ShowDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Student Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  backgroundImage: FileImage(File(data.image)),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 30),
              Details(
                labeltext: 'Name : ${data.name}',
              ),
              Details(
                labeltext: 'Age : ${data.age}',
              ),
              Details(
                labeltext: 'Place : ${data.place}',
              ),
              Details(
                labeltext: 'Ph : ${data.phone}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
