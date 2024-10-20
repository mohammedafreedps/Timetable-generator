part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class LoadNeededDatasEvent extends DashboardEvent{}

final class DatasHaveLoadedEvent extends DashboardEvent{}
