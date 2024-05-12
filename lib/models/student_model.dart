import 'package:campus_check_app/models/user_model.dart';

class StudentModel extends UserModel {
  String code;
  String faculty;
  String career;
  int stateEnrollment;
  int semester;
  String photoURL;

  StudentModel({
    required this.code,
    required String docID,
    required String name,
    required this.faculty,
    required this.career,
    required this.stateEnrollment,
    required this.semester,
    required this.photoURL,
  }) : super(docID: docID, name: name);
}
