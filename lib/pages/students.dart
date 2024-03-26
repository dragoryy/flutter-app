import 'package:first/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'dart:developer';


class Students extends StatefulWidget {
  const Students({super.key});

  static const routeName = '/add';

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController favSubjectController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2024),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Добавить студента",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 29.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: ListView(
            children: [
              const Text(
                "Имя",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                  controller: firstNameController,
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              const Text(
                "Фамилия",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите фамилию';
                    }
                    return null;
                  },
                  controller: lastNameController,
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              const Text(
                "Отчество",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите отчество';
                    }
                    return null;
                  },
                  controller: middleNameController,
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              const Text(
                "Дата рождения",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: TextFormField(
                  controller: birthDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите дату рождения';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () => onTapFunction(context: context),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              const Text(
                "Любимый предмет",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите любимый предмет';
                    }
                    return null;
                  },
                  controller: favSubjectController,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String id = randomAlphaNumeric(10);
                          Map<String,dynamic> studentInfo = {
                              "firstName": firstNameController.text,
                              "lastName": lastNameController.text,
                              "middleName": middleNameController.text,
                              "birthDate": birthDateController.text,
                              "id": id,
                              "favSubject":favSubjectController.text)
                          }
                          await DatabaseMethods()
                              .addStudent(studentInfo, id)
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: "Студент успешно добавлен!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                        }
                      },
                      child: const Text(
                        "Добавить",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
