part of 'staff_adding_bloc.dart';

@immutable
sealed class StaffAddingEvent {}

final class AddSubjectButtonClickedEvent extends StaffAddingEvent{}

final class ClearAddedSubjectEvent extends StaffAddingEvent{}

final class RemoveSubjectButtonClickedEvent extends StaffAddingEvent{
  final int index;
  RemoveSubjectButtonClickedEvent({required this.index});
}

final class SaveButtonPressedEvent extends StaffAddingEvent{
  final String staffName;
  SaveButtonPressedEvent({required this.staffName});
}

final class ShowAddedSubjectsForEditEvent extends StaffAddingEvent{
  final List<String> addedSubjectsForEdit;
  ShowAddedSubjectsForEditEvent({required this.addedSubjectsForEdit});
}

final class EditedSaveButtonClickedEvent extends StaffAddingEvent{
  final String staffID;
  final String staffName;
  EditedSaveButtonClickedEvent({required this.staffName,required this.staffID});
}