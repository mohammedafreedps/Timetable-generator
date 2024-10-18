part of 'course_bloc.dart';

@immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

class FechedCourseDataState extends CourseState{
  final List<CoursesModel> courses;
  FechedCourseDataState({required this.courses});
}

class CourseDeletingState extends CourseState{}

class CourseDeletedState extends CourseState{}
