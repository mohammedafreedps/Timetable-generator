part of 'staff_bloc.dart';

@immutable
sealed class StaffState {}

final class StaffInitial extends StaffState {}

final class StaffDetailsLoadedState extends StaffState{
  final List<TutorsModel> staffs;
  StaffDetailsLoadedState({required this.staffs});
}

final class StaffDetailsLoadingState extends StaffState{}

final class StaffDeletedState extends StaffState{}
