// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:student_management_app/app/routes/app_pages.dart';
// import '../controllers/home_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeView extends StatelessWidget {
//   HomeView({Key? key}) : super(key: key);

//   final HomeController controller = Get.put(HomeController());
//   final AuthController authC = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manajemen Siswa'),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: controller.streamStudents(),
//         builder: (context, snapStudents) {
//           if (snapStudents.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapStudents.data!.docs.isEmpty) {
//             return const Center(
//               child: Text("Tidak Ada Siswa"),
//             );
//           }

//           List<StudentModel> allStudents = [];

//           for (var element in snapStudents.data!.docs) {
//             allStudents.add(StudentModel.fromJson(element.data()));
//           }

//           return ListView.builder(
//             itemCount: allStudents.length,
//             itemBuilder: (context, index) {
//               StudentModel student = allStudents[index];
//               return ListTile(
//                 title: Text(student.name),
//                 subtitle: Text(student.number),
//                 onTap: () {
//                   Get.toNamed(
//                     Routes.detailStudent,
//                     arguments: student,
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add_rounded),
//             label: 'Tambah Siswa',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.qr_code),
//             label: 'QR Code',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.document_scanner_outlined),
//             label: 'Daftar Siswa',
//           ),
//         ],
//         onTap: (int index) {
//           switch (index) {
//             case 0:
//               Get.toNamed(Routes.addStudent);
//               break;
//             case 1:
//               // Logic for QR Code
//               break;
//             case 2:
//               controller.downloadCatalog();
//               break;
//           }
//         },
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:student_management_app/app/controllers/auth_controller.dart';
// import 'package:student_management_app/app/routes/app_pages.dart';

// import '../controllers/home_controller.dart';

// class HomeView extends StatelessWidget {
//   HomeView({Key? key}) : super(key: key);

//   final HomeController controller = Get.put(HomeController());
//   final AuthController authC = Get.find<AuthController>();

//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Tambah Siswa',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//     Text(
//       'QR Code',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//     Text(
//       'Daftar Siswa',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     int _selectedIndex = 0;

//     void _onItemTapped(int index) {
//       _selectedIndex = index;
//       switch (index) {
//         case 0:
//           Get.toNamed(Routes.addStudent);
//           break;
//         case 1:
//           Get.toNamed(Routes.students);
//           break;
//         case 2:
//           controller.downloadCatalog();
//           break;
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manajemen Siswa'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add_rounded),
//             label: 'Tambah Siswa',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.qr_code),
//             label: 'QR Code',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.document_scanner_outlined),
//             label: 'Daftar Siswa',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:student_management_app/app/controllers/auth_controller.dart';
import 'package:student_management_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Siswa'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Tambah Siswa";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.addStudent);
              break;
            case 1:
              title = "Detail Siswa";
              icon = Icons.list_alt_rounded;
              onTap = () => Get.toNamed(Routes.students);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code;
              onTap = () async {
                String barcode = await FlutterBarcodeScanner.scanBarcode(
                  "#000000",
                  "CANCEL",
                  true,
                  ScanMode.QR,
                );

                // Get data dari firebase search by student id
                Map<String, dynamic> hasil =
                    await controller.getStudentsById(barcode);
                if (hasil["error"] == false) {
                  Get.toNamed(
                    Routes.detailStudent,
                    arguments: hasil["data"],
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    hasil["message"],
                    duration: const Duration(seconds: 2),
                  );
                }
              };
              break;
            case 3:
              title = "Daftar Siswa";
              icon = Icons.document_scanner_outlined;
              onTap = () {
                controller.downloadCatalog();
              };
              break;
          }

          return Material(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(icon, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(title),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> hasil = await authC.logout();
          if (hasil["error"] == false) {
            Get.offAllNamed(Routes.login);
          } else {
            Get.snackbar("Error", hasil["error"]);
          }
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
