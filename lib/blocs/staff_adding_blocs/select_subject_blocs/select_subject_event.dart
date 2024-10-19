part of 'select_subject_bloc.dart';

@immutable
sealed class SelectSubjectEvent {}

class LoadSubjectBaseOnCourses extends SelectSubjectEvent{
  final String? selectedSubject;
  LoadSubjectBaseOnCourses({this.selectedSubject});
}

class ClearSelectedSubjectEvent extends SelectSubjectEvent{
}

class ClearAllSubjectsDataEvent extends SelectSubjectEvent{}