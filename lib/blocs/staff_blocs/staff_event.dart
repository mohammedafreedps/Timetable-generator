part of 'staff_bloc.dart';

@immutable
sealed class StaffEvent {}

class FetchStaffDetailsEvent extends StaffEvent{}

class DeleteStaffButtonClickedEvent extends StaffEvent{
  final String id;
  DeleteStaffButtonClickedEvent({required this.id});
}
