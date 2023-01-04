import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management/presentation/home_screen/home_nav.dart';
import 'package:student_management/presentation/student_list/students_nav.dart';

final pageprovider = StateProvider<int>((ref) => 0);

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final _pages = [
    const HomeNav(),
    const StudentsNav(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final value = ref.watch(pageprovider);
      return Scaffold(
        body: _pages[value],
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            currentIndex: value,
            onTap: (newindex) {
              ref.read(pageprovider.notifier).state = newindex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Students',
              ),
            ]),
      );
    });
  }
}
