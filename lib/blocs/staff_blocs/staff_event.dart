part of 'staff_bloc.dart';

@immutable
sealed class StaffEvent {}

final class FetchStaffDetailsEvent extends StaffEvent{}

final class DeleteStaffButtonClickedEvent extends StaffEvent{
  final String id;
  DeleteStaffButtonClickedEvent({required this.id});
}
