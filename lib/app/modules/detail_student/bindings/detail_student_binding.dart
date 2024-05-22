import 'package:get/get.dart';

import '../controllers/detail_student_controller.dart';

class DetailStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStudentController>(
      () => DetailStudentController(),
    );
  }
}
