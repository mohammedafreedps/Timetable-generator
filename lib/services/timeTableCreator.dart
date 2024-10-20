import 'dart:math';

import 'package:ttg/models/courses_model.dart';
import 'package:ttg/models/timetable_entry_model.dart';
import 'package:ttg/models/tutors_model.dart';


List<TimeTableEntryModel> generateCourseTimeTable(CoursesModel course, List<TutorsModel> tutors) {
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  int periodsPerDay = 4;
  Random random = Random();

  List<String> timeSlots = [
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 01:00',
  ];

  List<TimeTableEntryModel> timetable = [];


  Map<String, List<String>> assignedSubjects = {};

  for (String day in days) {
    assignedSubjects[day] = [];

    for (int period = 0; period < periodsPerDay; period++) {
      String subject = course.subjects[random.nextInt(course.subjects.length)];

      TutorsModel? tutor = tutors.firstWhere(
        (staff) => staff.subjects.contains(subject),
        orElse: () => TutorsModel(id: 'unknown', name: 'Unknown', courseName: 'Unknown', subjects: []), // Handle if no tutor found
      );

      TimeTableEntryModel entry = TimeTableEntryModel(
        courseName: course.courseName,
        day: day,
        subject: subject,
        tutor: tutor.name,
        time: timeSlots[period],
      );

      timetable.add(entry);
      assignedSubjects[day]!.add(subject);
    }
  }

  return timetable;
}
