class StudentModel {
  StudentModel({
    required this.studentModelClass,
    required this.name,
    required this.number,
    required this.studentId,
  });

  final String studentModelClass;
  final String name;
  final String number;
  final String studentId;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        studentModelClass: json["class"] ?? "",
        name: json["name"] ?? "",
        number: json["number"] ?? "",
        studentId: json["studentId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "class": studentModelClass,
        "name": name,
        "number": number,
        "studentId": studentId,
      };
}
