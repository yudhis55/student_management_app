import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamStudents() async* {
    yield* firestore.collection("student").snapshots();
  }
}
