part of 'select_course_bloc.dart';

@immutable
sealed class SelectCourseState {}

final class SelectCourseInitial extends SelectCourseState {}

class LoadedCoursesState extends SelectCourseState{
  final List<String> courses;
  final String? selectedCourse;
  LoadedCoursesState({required this.courses,this.selectedCourse});
}
