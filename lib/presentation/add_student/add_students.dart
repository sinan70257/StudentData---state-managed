import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/presentation/add_student/functions/student_adder.dart';
import 'package:student_management/presentation/add_student/widgets/error_message.dart';
import 'package:student_management/presentation/add_student/widgets/text_field.dart';

final nameController = TextEditingController();

final ageController = TextEditingController();

final placeController = TextEditingController();

final phoneController = TextEditingController();

// ignore: must_be_immutable
class AddStudentsWidget extends StatelessWidget {
  AddStudentsWidget({super.key});
  String? path;

  @override
  Widget build(BuildContext context) {
    fieldClear();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Add Students.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 3,
                    width: 250,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                      controller: nameController,
                      hint: 'Name',
                      icon: Icons.abc_rounded),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: ageController,
                      hint: 'Age',
                      icon: Icons.numbers),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: placeController,
                      hint: 'Place',
                      icon: Icons.location_pin),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: phoneController,
                      hint: 'Phone Number',
                      icon: Icons.phone),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 270,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImage();
                      },
                      label: const Text(
                        '+',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      icon: const Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: 270,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        AddButton(context);
                      },
                      label: const Text(
                        'Add',
                        style: TextStyle(color: Colors.black),
                      ),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AddButton(BuildContext ctx) {
    List data = [
      nameController.text.trim(),
      ageController.text.trim(),
      placeController.text.trim(),
      phoneController.text.trim(),
      path,
      DateTime.now().toString()
    ];
    SnackBar mysnackBar = CheckError(data);
    ScaffoldMessenger.of(ctx).showSnackBar(mysnackBar);
  }

  getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      path = pickedFile.path;
    }
  }
}

alertDelete(BuildContext ctx, index) {
  showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          // title: Text('Delete'),
          content: const Text('Do you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (index != null) {
                  deleteStudent(index);
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      });
}
