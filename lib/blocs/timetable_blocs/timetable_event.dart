part of 'timetable_bloc.dart';

@immutable
sealed class TimetableEvent {}

final class LoadTimetableEvnet extends TimetableEvent {
  final String courseName;
  LoadTimetableEvnet({required this.courseName});
}

final class GenerateTimetableEvnet extends TimetableEvent {
  final CoursesModel courseModel;
  final String courseName;
  GenerateTimetableEvnet({required this.courseName, required this.courseModel});
}

final class SaveGeneratedTimeTableButtonClickedEvent extends TimetableEvent {
  final String courseName;
  SaveGeneratedTimeTableButtonClickedEvent({required this.courseName});
}

final class DeleteSavedTimtableButtonClickedEvent extends TimetableEvent {
  final String courseName;
  DeleteSavedTimtableButtonClickedEvent({required this.courseName});
}
