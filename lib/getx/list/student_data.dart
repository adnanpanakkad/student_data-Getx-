import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/Screens/student_list/list_screen.dart';
import 'package:studentgetx/getx/Db/db_functions.dart';
import 'package:studentgetx/model/studentmodel.dart';


class FormFunctions extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> isUpdate(int index) async {
    final studentDB = Get.put(StudentDB());
    await studentDB.getAllStudents();
    imageController.imgPath.value = studentDB.students[index].profile;
    nameController.text = studentDB.students[index].name;
    emailController.text = studentDB.students[index].email;
    ageController.text = studentDB.students[index].age.toString();
    contactController.text = studentDB.students[index].contact.toString();
  }

  void notSuccess() {
    Get.snackbar('Image not added!!', 'Please add a image of student');
  }

  Future<void> submitData() async {
    final studentObject = StudentModel(
        id: DateTime.now(),
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        age: int.parse(ageController.text.trim()),
        contact: int.parse(contactController.text.trim()),
        profile: imageController.imgPath.value);

    await StudentDB().addStudent(studentObject);
    reset();
    final studentDB = Get.put(StudentDB());
    studentDB.getAllStudents();
    Get.back();
  }

  Future<void> updateData(int index) async {
    final studentObject = StudentModel(
        id: DateTime.now(),
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        age: int.parse(ageController.text.trim()),
        contact: int.parse(contactController.text.trim()),
        profile: imageController.imgPath.value);
    await StudentDB().editStudent(index, studentObject);
    final studentDB = Get.put(StudentDB());
    studentDB.getAllStudents();
    Get.back();
  }

  reset() {
    imageController.imgPath.value = '';
    nameController.text = '';
    emailController.text = '';
    ageController.text = '';
    contactController.text = '';
  }
}
