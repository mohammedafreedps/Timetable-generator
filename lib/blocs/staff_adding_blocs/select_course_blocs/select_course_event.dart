part of 'select_course_bloc.dart';

@immutable
sealed class SelectCourseEvent {}

class LoadAllCoursesForSelectingEvent extends SelectCourseEvent{
  final bool? isForEditing;
  final String? initSelectedCourse; 
  LoadAllCoursesForSelectingEvent({this.isForEditing,this.initSelectedCourse});
}

class CousesSelectingEvent extends SelectCourseEvent{
  final String? selectedCourses;
  CousesSelectingEvent({required this.selectedCourses});
}

class ClearAllSelectionsEvent extends SelectCourseEvent{}