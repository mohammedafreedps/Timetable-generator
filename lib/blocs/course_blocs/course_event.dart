part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class FechCoursesDataEvent extends CourseEvent {}

class DeleteCourseButtonClickedEvent extends CourseEvent{
  final String documentId;
  DeleteCourseButtonClickedEvent({required this.documentId});
}

