class TutorsModel {
  String name;
  List subjects;

  TutorsModel({
    required this.name,
    required this.subjects,
  });

  factory TutorsModel.fromFirestore(Map<String, dynamic> data) {
    return TutorsModel(
      name: data['name'] ?? '',
      subjects: List<String>.from(data['subjects'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'subjects': subjects,
    };
  }
}
