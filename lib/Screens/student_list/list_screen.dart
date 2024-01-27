import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/getx/list/student_image.dart';
import 'package:studentgetx/getx/list/student_data.dart';

UserImage imageController = Get.put(UserImage());
FormFunctions studentFormController = Get.put(FormFunctions());

class ScreenForm extends StatelessWidget {
  const ScreenForm({
    super.key,
    required this.isEdit,
    required this.index,
  });
  final bool isEdit;
  final int index;
  @override
  Widget build(BuildContext context) {
    isEdit
        ? studentFormController.isUpdate(index)
        : studentFormController.reset();

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Sutdent Details' : 'Add Student'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: studentFormController.formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () => imageController.getImage(),
                    child: imageController.imgPath.value == ''
                        ? ClipOval(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      imageController.userAvatar.value),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(
                                      File(imageController.imgPath.value)),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: studentFormController.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      studentFormController.nameController.text.isEmpty
                          ? 'Name field is empty'
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: studentFormController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) =>
                      studentFormController.emailController.text.isEmpty
                          ? 'Email field is empty'
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: studentFormController.ageController,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age of student',
                    prefixIcon: Icon(Icons.av_timer),
                  ),
                  validator: (value) =>
                      studentFormController.ageController.text.isEmpty
                          ? 'Age field is empty'
                          : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: studentFormController.contactController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Contact Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) =>
                      studentFormController.contactController.text.isEmpty
                          ? 'Contact field is empty'
                          : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () async {
                          if (studentFormController.formKey.currentState!
                              .validate()) {
                            if (imageController.imgPath.value != '') {
                              if (isEdit) {
                                await studentFormController.updateData(index);
                              } else {
                                await studentFormController.submitData();
                              }
                              Get.snackbar(
                                'Success',
                                isEdit
                                    ? 'Data Updated Successfully'
                                    : 'Data Submitted Successfully',
                                backgroundColor: Colors.green.withOpacity(0.5),
                              );
                            } else {
                              studentFormController.notSuccess();
                              Get.snackbar(
                                'Error',
                                'Image path is empty',
                                backgroundColor: Colors.red.withOpacity(0.5),
                              );
                            }
                          }
                        },
                        child: Text(isEdit ? 'Update' : 'Submit'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
