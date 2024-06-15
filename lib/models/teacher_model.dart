import 'package:campus_check_app/models/user_model.dart';

class TeacherModel extends UserModel {
  String code;
  String faculty;

  TeacherModel({
    required this.code,
    required super.docID,
    required super.name,
    required this.faculty,
  });
}
