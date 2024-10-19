part of 'select_subject_bloc.dart';

@immutable
sealed class SelectSubjectState {}

final class SelectSubjectInitial extends SelectSubjectState {}

class ShowCourseBasedSubjectsState extends SelectSubjectState{
  final List<String> subjects;
  final String? selectedSubject;
  ShowCourseBasedSubjectsState({required this.subjects,this.selectedSubject});
}

