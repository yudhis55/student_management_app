import 'package:get/get.dart';

import '../modules/add_student/bindings/add_student_binding.dart';
import '../modules/add_student/views/add_student_view.dart';
import '../modules/detail_student/bindings/detail_student_binding.dart';
import '../modules/detail_student/views/detail_student_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/students/bindings/students_binding.dart';
import '../modules/students/views/students_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.addStudent,
      page: () => AddStudentView(),
      binding: AddStudentBinding(),
    ),
    GetPage(
      name: _Paths.students,
      page: () => const StudentsView(),
      binding: StudentsBinding(),
    ),
    GetPage(
      name: _Paths.detailStudent,
      page: () => DetailStudentView(),
      binding: DetailStudentBinding(),
    ),
  ];
}
