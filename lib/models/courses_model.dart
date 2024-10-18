import 'package:ttg/models/models.dart';

class CoursesModel {
  String courseID;
  String courseName;
  List<String> subjects;
  List<TutorsModel> tutors;

  CoursesModel({
    required this.courseID,
    required this.courseName,
    required this.subjects,
    required this.tutors,
  });

 
  factory CoursesModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CoursesModel(
      courseID: documentId,
      courseName: data['courseName'] ?? '',
      subjects: List<String>.from(data['subjects'] ?? []), 
      tutors: List<TutorsModel>.from(data['tutors'] ?? []), 
    );
  }


  Map<String, dynamic> toFirestore() {
    return {
      'courseName': courseName,
      'subjects': subjects,
      'tutors': tutors,
    };
  }
}
