part of 'course_adding_bloc.dart';

@immutable
sealed class CourseAddingState {}

final class CourseAddingInitial extends CourseAddingState {}

final class AddedSubjectShowState extends CourseAddingState{
  final List<String> addedSubjects;
  AddedSubjectShowState({required this.addedSubjects});
}

final class CourseSavingState extends CourseAddingState{}

final class CourseSavedState extends CourseAddingState{}
