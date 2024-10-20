class TimeTableEntryModel {
  final String courseName;
  final String day;
  final String subject;
  final String tutor;
  final String time;

  TimeTableEntryModel({
    required this.courseName,
    required this.day,
    required this.subject,
    required this.tutor,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'day': day,
      'subject': subject,
      'tutor': tutor,
      'time': time,
    };
  }

  factory TimeTableEntryModel.fromMap(Map<String, dynamic> map) {
    return TimeTableEntryModel(
      courseName: map['courseName'] ?? '', 
      day: map['day'] ?? '',
      subject: map['subject'] ?? '',
      tutor: map['tutor'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
