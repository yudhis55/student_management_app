import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddStudentController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addStudent(Map<String, dynamic> data) async {
    try {
      var hasil = await firestore.collection("student").add(data);
      await firestore.collection("student").doc(hasil.id).update({
        "studentId": hasil.id,
      });

      return {
        "error": false,
        "message": "Berhasil menambah siswa.",
      };
    } catch (e) {
      // Error general
      return {
        "error": true,
        "message": "Tidak dapat menambah siswa.",
      };
    }
  }
}
