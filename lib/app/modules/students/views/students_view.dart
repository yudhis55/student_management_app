import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:student_management_app/app/data/models/student_model.dart';
import 'package:student_management_app/app/routes/app_pages.dart';

import '../controllers/students_controller.dart';

class StudentsView extends GetView<StudentsController> {
  const StudentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL SISWA'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamStudents(),
        builder: (context, snapStudents) {
          if (snapStudents.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapStudents.data!.docs.isEmpty) {
            return const Center(
              child: Text("Tidak Ada Siswa"),
            );
          }

          List<StudentModel> allStudents = [];

          for (var element in snapStudents.data!.docs) {
            allStudents.add(StudentModel.fromJson(element.data()));
          }
          return ListView.builder(
            itemCount: allStudents.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              StudentModel student = allStudents[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.detailStudent, arguments: student);
                  },
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    height: 105,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.number,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(student.name),
                              Text("Kelas : ${student.studentModelClass}"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: QrImageView(
                            data: "147831247",
                            size: 200.0,
                            version: QrVersions.auto,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}