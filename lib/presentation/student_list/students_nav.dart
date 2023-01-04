import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/model/data_model.dart';
import 'package:student_management/presentation/add_student/add_students.dart';
import 'package:student_management/presentation/edit_student/edit_students.dart';
import 'package:student_management/presentation/search_screen/search_students.dart';
import 'package:student_management/presentation/student_details/student_details.dart';

var imageProvider = StateProvider<String>(((ref) => ''));

class StudentsNav extends StatelessWidget {
  const StudentsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Student List'),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final data = studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(data.image),
                  ),
                ),
                title: Text(
                  data.name,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  data.place,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return ShowDetails(data: data);
                      }),
                    ),
                  );
                },
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        imageProvider =
                            StateProvider<String>(((ref) => data.image));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditStudents(index: index, data: data),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // ignore: unnecessary_null_comparison
                        if (data.key != null) {
                          alertDelete(ctx, index);
                        } else {
                          print('No key found.');
                        }
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
