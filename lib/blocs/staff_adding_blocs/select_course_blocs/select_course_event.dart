part of 'select_course_bloc.dart';

@immutable
sealed class SelectCourseEvent {}

final class LoadAllCoursesForSelectingEvent extends SelectCourseEvent{
  final bool? isForEditing;
  final String? initSelectedCourse; 
  LoadAllCoursesForSelectingEvent({this.isForEditing,this.initSelectedCourse});
}

final class CousesSelectingEvent extends SelectCourseEvent{
  final String? selectedCourses;
  CousesSelectingEvent({required this.selectedCourses});
}

final class ClearAllSelectionsEvent extends SelectCourseEvent{}