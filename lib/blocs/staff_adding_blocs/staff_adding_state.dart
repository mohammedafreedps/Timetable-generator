part of 'staff_adding_bloc.dart';

@immutable
sealed class StaffAddingState {}

final class StaffAddingInitial extends StaffAddingState {}

class AddedSubjectsState extends StaffAddingState{
  final List<String> subjects;
  AddedSubjectsState({required this.subjects});
}

class StaffDataSavingState extends StaffAddingState{}

class StaffDataSavedState extends StaffAddingState{}