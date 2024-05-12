import 'package:campus_check_app/models/user_model.dart';

class TeacherModel extends UserModel {
  String code;
  String faculty;

  TeacherModel({
    required this.code,
    required String docID,
    required String name,
    required this.faculty,
  }) : super(docID: docID, name: name);
}
