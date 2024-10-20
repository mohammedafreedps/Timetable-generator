part of 'staff_adding_bloc.dart';

@immutable
sealed class StaffAddingState {}

final class StaffAddingInitial extends StaffAddingState {}

final class AddedSubjectsState extends StaffAddingState{
  final List<String> subjects;
  AddedSubjectsState({required this.subjects});
}

final class StaffDataSavingState extends StaffAddingState{}

final class StaffDataSavedState extends StaffAddingState{}