// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/db/model/data_model.dart';

final List<StudentModel> studentBoxList =
    Hive.box<StudentModel>('student_db').values.toList();
final searchprovider =
    StateProvider<List<StudentModel>>(((ref) => studentBoxList));

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  final List<StudentModel> studentBoxList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> displayStudent =
      List<StudentModel>.from(studentBoxList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Search Students"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Consumer(builder: (context, ref, child) {
              final values = ref.watch(searchprovider);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 7),
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: const OutlineInputBorder(),
                          focusColor: Colors.white,
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          )),
                      controller: _searchController,
                      onChanged: (value) {
                        ref.read(searchprovider.notifier).state = studentBoxList
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        displayStudent = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: (displayStudent.isNotEmpty)
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              File imageFile =
                                  File(displayStudent[index].image);
                              return ListTile(
                                onTap: () {},
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(imageFile),
                                  radius: 30,
                                ),
                                title: Text(
                                  displayStudent[index].name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: displayStudent.length,
                          )
                        : const Center(
                            child: Text(
                            "The data is not Found",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                  ),
                ],
              );
            })));
  }
}
