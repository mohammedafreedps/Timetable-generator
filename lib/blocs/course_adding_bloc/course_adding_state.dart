part of 'course_adding_bloc.dart';

@immutable
sealed class CourseAddingState {}

final class CourseAddingInitial extends CourseAddingState {}

class AddedSubjectShowState extends CourseAddingState{
  final List<String> addedSubjects;
  AddedSubjectShowState({required this.addedSubjects});
}

class CourseSavingState extends CourseAddingState{}

class CourseSavedState extends CourseAddingState{}
