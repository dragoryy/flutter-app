import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/models/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first/pages/students.dart';
import 'package:first/service/database.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/auth/authentication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeName = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController favSubjectController = TextEditingController();

  onTapFunction({required BuildContext context, required String date}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2024),
      initialDate: DateFormat('yyyy-MM-dd').parse(date),
    );
    if (pickedDate == null) return;
    birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  Stream? studentList;

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.pushNamed(context, '/auth');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Успешный выход!')));
  }

  loadStudents() async {
    studentList = await DatabaseMethods().getStudents();
    setState(() {});
  }

  @override
  void initState() {
    loadStudents();
    super.initState();
  }

  Widget _signOutButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ElevatedButton(onPressed: signOut, child: const Text('Выйти')),
    );
  }

  Widget _allStudents() {
    return StreamBuilder(
      stream: studentList,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Имя: ${ds['firstName']}",
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      firstNameController.text =
                                          ds['firstName'];
                                      lastNameController.text = ds["lastName"];
                                      middleNameController.text =
                                          ds["middleName"];
                                      birthDateController.text =
                                          ds["birthDate"];
                                      favSubjectController.text =
                                          ds["favSubject"];
                                      EditStudent(ds["id"]);
                                    },
                                    child: const MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                    )),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteStudents(ds["id"]);
                                      Fluttertoast.showToast(
                                          msg: "Студент успешно удален!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: const MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ))
                              ],
                            ),
                            Text(
                              "Фамилия:  ${ds["lastName"]}",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Отчество: ${ds["middleName"]}",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Дата рождения: ${ds["birthDate"]}",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Любимый предмет: ${ds["favSubject"]}",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text(
              "Образовательное учреждение",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 29.0,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/') {
                      Navigator.pushNamed((context), '/');
                    }
                  },
                  child: Text('Главная'),
                ),
                TextButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/about') {
                      Navigator.pushNamed((context), '/about');
                    }
                  },
                  child: Text('О нас'),
                ),
                TextButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/add') {
                      Navigator.pushNamed((context), '/add');
                    }
                  },
                  child: Text('Добавить студента'),
                ),
                _signOutButton()
              ],
            ))
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: _allStudents()),
          ],
        ),
      ),
    );
  }

}
