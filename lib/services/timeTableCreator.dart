import 'dart:math';

import 'package:ttg/models/courses_model.dart';
import 'package:ttg/models/timetable_model.dart';
import 'package:ttg/models/tutors_model.dart';


// Map<String, dynamic> generateCourseTimeTable(CoursesModel course, List<TutorsModel> staffs) {
//   List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
//   int periodsPerDay = 4;
//   Random random = Random();

//   // Initialize timetable
//   Map<String, List<String>> timeTable = {
//     'Monday': [],
//     'Tuesday': [],
//     'Wednesday': [],
//     'Thursday': [],
//     'Friday': [],
//   };

//   // Track subjects taught by tutors
//   Map<String, String> subjectTutorMapping = {};

//   // Keep track of assigned subjects and staff availability
//   Map<String, List<String>> assignedSubjects = {};

//   // Loop through each day
//   for (String day in days) {
//     while (timeTable[day]!.length < periodsPerDay) {
//       String subject = course.subjects[random.nextInt(course.subjects.length)];
//       // Get a tutor for the subject
//       TutorsModel? tutor = staffs.firstWhere(
//         (staff) => staff.subjects.contains(subject),
       
//       );

//       // Check for availability conflicts
//       if (tutor != null && !assignedSubjects.containsKey(subject)) {
//         timeTable[day]!.add(subject);
//         assignedSubjects[subject] = [day];
//         subjectTutorMapping[subject] = tutor.name; // Map subject to tutor
//       } else if (tutor != null && assignedSubjects[subject]!.length < 5) {
//         timeTable[day]!.add(subject);
//         assignedSubjects[subject]!.add(day);
//         subjectTutorMapping[subject] = tutor.name; // Map subject to tutor
//       }
//     }
//   }

//   // Return the timetable along with subject-tutor mapping
//   return {
//     'timetable': timeTable,
//     'subjectTutorMapping': subjectTutorMapping,
//   };
// }

// Map<String, dynamic> generateCourseTimeTable(CoursesModel course, List<TutorsModel> staffs) {
//   List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
//   int periodsPerDay = 4;
//   Random random = Random();

//   // Define time slots for each period
//   List<String> timeSlots = [
//     '09:00 - 10:00',
//     '10:00 - 11:00',
//     '11:00 - 12:00',
//     '12:00 - 01:00'
//   ];

//   // Initialize timetable
//   Map<String, List<Map<String, String>>> timeTable = {
//     'Monday': [],
//     'Tuesday': [],
//     'Wednesday': [],
//     'Thursday': [],
//     'Friday': [],
//   };

//   // Track subjects taught by tutors
//   Map<String, String> subjectTutorMapping = {};

//   // Keep track of assigned subjects and staff availability
//   Map<String, List<String>> assignedSubjects = {};

//   // Loop through each day
//   for (String day in days) {
//     while (timeTable[day]!.length < periodsPerDay) {
//       String subject = course.subjects[random.nextInt(course.subjects.length)];
//       // Get a tutor for the subject
//       TutorsModel? tutor = staffs.firstWhere(
//         (staff) => staff.subjects.contains(subject),
//       // Ensure this handles no tutor found case
//       );

//       // Check for availability conflicts
//       if (tutor != null && !assignedSubjects.containsKey(subject)) {
//         // Get the index for the period to assign the time slot
//         int periodIndex = timeTable[day]!.length;
//         if (periodIndex < periodsPerDay) {
//           timeTable[day]!.add({
//             'subject': subject,
//             'tutor': tutor.name,
//             'time': timeSlots[periodIndex],
//           });
//           assignedSubjects[subject] = [day];
//           subjectTutorMapping[subject] = tutor.name; // Map subject to tutor
//         }
//       } else if (tutor != null && assignedSubjects[subject]!.length < 5) {
//         // Get the index for the period to assign the time slot
//         int periodIndex = timeTable[day]!.length;
//         if (periodIndex < periodsPerDay) {
//           timeTable[day]!.add({
//             'subject': subject,
//             'tutor': tutor.name,
//             'time': timeSlots[periodIndex],
//           });
//           assignedSubjects[subject]!.add(day);
//           subjectTutorMapping[subject] = tutor.name; // Map subject to tutor
//         }
//       }
//     }
//   }

//   // Return the timetable along with subject-tutor mapping
//   return {
//     'timetable': timeTable,
//     'subjectTutorMapping': subjectTutorMapping,
//   };
// }

List<TimetableModel> generateCourseTimeTable(CoursesModel course, List<TutorsModel> tutors) {
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  int periodsPerDay = 4;
  Random random = Random();

  // Define time slots for each period
  List<String> timeSlots = [
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 01:00',
  ];

  List<TimetableModel> timetable = [];

  // Keep track of assigned subjects per day
  Map<String, List<String>> assignedSubjects = {};

  for (String day in days) {
    assignedSubjects[day] = [];

    for (int period = 0; period < periodsPerDay; period++) {
      // Randomly pick a subject
      String subject = course.subjects[random.nextInt(course.subjects.length)];

      // Find a tutor who teaches the selected subject
      TutorsModel? tutor = tutors.firstWhere(
        (staff) => staff.subjects.contains(subject),
        orElse: () => TutorsModel(id: 'unknown', name: 'Unknown', courseName: 'Unknown', subjects: []), // Handle if no tutor found
      );

      // Create a TimetableEntry and add it to the list
      TimetableModel entry = TimetableModel(
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
