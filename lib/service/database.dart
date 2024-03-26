import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/service/database_api.dart';

import '../models/student.dart';

class DatabaseMethods {
  @override
  Future addStudent(Student studentInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .set(studentInfo.toMap());
  }

  @override
  Future<Stream<QuerySnapshot>> getStudents() async {
    return FirebaseFirestore.instance.collection("students").snapshots();
  }

  @override
  Future updateStudents(String id, Student updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .update(updateInfo.toMap());
  }

  @override
  Future deleteStudents(String id) async {
    return await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .delete();
  }
}
