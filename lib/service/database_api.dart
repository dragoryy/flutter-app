import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/student.dart';

abstract interface class DatabaseApi {
  Future<Stream<QuerySnapshot>> getStudents();

  Future addStudent(Student studentInfo, String id);

  Future updateStudents(String id, Student updateInfo);

  Future deleteStudents(String id);
}
