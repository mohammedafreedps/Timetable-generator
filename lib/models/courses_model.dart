class CoursesModel {
  String courseID;
  String courseName;
  List<String> subjects;

  CoursesModel({
    required this.courseID,
    required this.courseName,
    required this.subjects,
  });

 
  factory CoursesModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CoursesModel(
      courseID: documentId,
      courseName: data['courseName'] ?? '',
      subjects: List<String>.from(data['subjects'] ?? []), 
    );
  }


  Map<String, dynamic> toFirestore() {
    return {
      'courseName': courseName,
      'subjects': subjects,
    };
  }
}
