import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/screens/student_list/list_screen.dart';
import 'package:studentgetx/getx/Db/db_functions.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final studentDB = Get.put(StudentDB());
    studentDB.getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Card(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        FileImage(File(studentDB.students[index].profile)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'NAME : ${studentDB.students[index].name.toUpperCase()}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'EMAIL : ${studentDB.students[index].email.toLowerCase()} ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'AGE : ${studentDB.students[index].age.toString()}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'CONTACT : ${studentDB.students[index].contact.toString()}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () => Get.to(ScreenForm(
                            isEdit: true,
                            index: index,
                          )),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
