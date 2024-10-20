part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class LoadAllDataForDashboardState extends DashboardState{}

final class AlldataHaveLoadedState extends DashboardState{}
