class TutorsModel {
  String id; 
  String name;
  String courseName; 
  List<String> subjects; 


  TutorsModel({
    required this.id,
    required this.name,
    required this.courseName,
    required this.subjects,
  });


  factory TutorsModel.fromFirestore(Map<String, dynamic> data,String id) {
    return TutorsModel(
      id: id, 
      name: data['name'] ?? '',
      courseName: data['courseName'] ?? '', 
      subjects: List<String>.from(data['subjects'] ?? []),
    );
  }


  Map<String, dynamic> toFirestore() {
    return {
      'id': id, 
      'name': name,
      'courseName': courseName, 
      'subjects': subjects,
    };
  }
}
