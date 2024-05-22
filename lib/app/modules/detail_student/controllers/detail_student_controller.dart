import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailStudentController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> editStudent(Map<String, dynamic> data) async {
    try {
      await firestore.collection("student").doc(data["id"]).update({
        "number": data["number"],
        "name": data["name"],
        "class": data["class"],
      });

      return {
        "error": false,
        "message": "Berhasil update siswa.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat update siswa.",
      };
    }
  }

  Future<Map<String, dynamic>> deleteStudent(String id) async {
    try {
      await firestore.collection("student").doc(id).delete();
      return {
        "error": false,
        "message": "Berhasil delete siswa.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat delete siswa.",
      };
    }
  }
}
