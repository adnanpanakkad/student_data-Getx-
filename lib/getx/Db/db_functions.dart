import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:studentgetx/model/studentmodel.dart';

class StudentDB extends GetxController {
  List<StudentModel> students = <StudentModel>[].obs;
  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    students.add(value);
    await studentDB.add(value);
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    students.clear();
    students.addAll(studentDB.values);
  }

  Future<void> deleteStudent(int index) async {
    final sutdentDB =await Hive.openBox<StudentModel>('student_db');
    await sutdentDB.deleteAt(index); 
    getAllStudents();
  }
    Future<void> editStudent(int index, StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.putAt(index, student);
    getAllStudents(); 

  }
}
