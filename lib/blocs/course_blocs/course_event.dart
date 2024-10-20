part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

final class FechCoursesDataEvent extends CourseEvent {}

final class DeleteCourseButtonClickedEvent extends CourseEvent{
  final String documentId;
  DeleteCourseButtonClickedEvent({required this.documentId});
}

