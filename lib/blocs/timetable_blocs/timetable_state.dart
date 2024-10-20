part of 'timetable_bloc.dart';

@immutable
sealed class TimetableState {}

final class TimetableInitial extends TimetableState {}

final class TimetableLoadingState extends TimetableState{}

final class TimetableLoadedState extends TimetableState{
  final List<TimeTableEntryModel> timetableEntryModels;
  TimetableLoadedState({required this.timetableEntryModels});
}

final class NotFoundTimetableState extends TimetableState{}

final class GeneratedTimetableLoadedState extends TimetableState{
  final List<TimeTableEntryModel> timetableEntryModels;
  GeneratedTimetableLoadedState({required this.timetableEntryModels});
}
