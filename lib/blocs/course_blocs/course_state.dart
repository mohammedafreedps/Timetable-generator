part of 'course_bloc.dart';

@immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

final class FechedCourseDataState extends CourseState{
  final List<CoursesModel> courses;
  FechedCourseDataState({required this.courses});
}

final class CourseDeletingState extends CourseState{}

final class CourseDeletedState extends CourseState{}
