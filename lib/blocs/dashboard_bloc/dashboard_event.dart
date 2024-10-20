part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class LoadNeededDatasEvent extends DashboardEvent{}

class DatasHaveLoadedEvent extends DashboardEvent{}
