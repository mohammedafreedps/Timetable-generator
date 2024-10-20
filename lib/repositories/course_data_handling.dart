import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ttg/models/models.dart';

class CourseDataHandling {
  static Future<void> addCourseToDatabase(
      String courseName, List<String> subjects, List<String> tutors) async {
    CollectionReference courses =
        FirebaseFirestore.instance.collection('courses');
    courses.doc(courseName).set(
        {'courseName': courseName.trim(), 'subjects': subjects, 'tutors': tutors});
  }

  static Future<List<CoursesModel>> getAllCoursesFromDatabase() async {
    CollectionReference coursesCollection =
        FirebaseFirestore.instance.collection('courses');
    QuerySnapshot querySnapshot = await coursesCollection.get();
    List<CoursesModel> coursesList = querySnapshot.docs.map((doc) {
      return CoursesModel.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    return coursesList;
  }

  static Future<void> deleteCoursesFromDatabase(
      {required String documentId}) async {
    CollectionReference courses =
        FirebaseFirestore.instance.collection('courses');
    await courses.doc(documentId).delete();
  }

  static Future<void> editCoursesDataFromDatabase(
    String courseId,
    String courseName,
    List<String> subjects,
  ) async {
    CollectionReference courses =
        FirebaseFirestore.instance.collection('courses');
    await courses.doc(courseId).update({
      'courseName': courseName.trim(),
      'subjects': subjects,
    });
  }
}
