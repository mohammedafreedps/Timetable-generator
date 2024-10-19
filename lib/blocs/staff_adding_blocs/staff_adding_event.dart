part of 'staff_adding_bloc.dart';

@immutable
sealed class StaffAddingEvent {}

class AddSubjectButtonClickedEvent extends StaffAddingEvent{}

class ClearAddedSubjectEvent extends StaffAddingEvent{}

class RemoveSubjectButtonClickedEvent extends StaffAddingEvent{
  final int index;
  RemoveSubjectButtonClickedEvent({required this.index});
}

class SaveButtonPressedEvent extends StaffAddingEvent{
  final String staffName;
  SaveButtonPressedEvent({required this.staffName});
}
