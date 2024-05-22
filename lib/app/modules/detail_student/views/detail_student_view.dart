import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:student_management_app/app/data/models/student_model.dart';

import '../controllers/detail_student_controller.dart';

class DetailStudentView extends GetView<DetailStudentController> {
  DetailStudentView({Key? key}) : super(key: key);

  final StudentModel student = Get.arguments;

  final TextEditingController numberC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController classC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    numberC.text = student.number;
    nameC.text = student.name;
    classC.text = student.studentModelClass;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL SISWA'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: student.number,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: numberC,
            keyboardType: TextInputType.number,
            // readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "NISN",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: classC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Kelas",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoadingUpdate.isFalse) {
                if (numberC.text.isNotEmpty &&
                    nameC.text.isNotEmpty &&
                    classC.text.isNotEmpty) {
                  controller.isLoadingUpdate(true);
                  Map<String, dynamic> hasil = await controller.editStudent({
                    "id": student.studentId,
                    "number": numberC.text,
                    "name": nameC.text,
                    "class": classC.text,
                  });
                  controller.isLoadingUpdate(false);

                  Get.snackbar(
                    hasil["error"] == true ? "Error" : "Berhasil",
                    hasil["message"],
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "Semua data wajib diisi.",
                    duration: const Duration(seconds: 2),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(controller.isLoadingUpdate.isFalse
                  ? "UPDATE SISWA"
                  : "LOADING..."),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Hapus Siswa",
                middleText: "Apakah kamu yakin menghapus data ini?",
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("BATAL"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.isLoadingDelete(true);
                      Map<String, dynamic> hasil =
                          await controller.deleteStudent(student.studentId);
                      controller.isLoadingDelete(false);

                      Get.back(); //tutup dialog
                      Get.back(); // Balik ke page all student

                      Get.snackbar(
                        hasil["error"] == true ? "Error" : "Berhasil",
                        hasil["message"],
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: Obx(
                      () => controller.isLoadingDelete.isFalse
                          ? const Text("HAPUS")
                          : Container(
                              padding: const EdgeInsets.all(2),
                              height: 15,
                              width: 15,
                              child: const CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 1,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
            child: Text(
              "HAPUS SISWA",
              style: TextStyle(
                color: Colors.red.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
