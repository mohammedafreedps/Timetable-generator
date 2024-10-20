import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadNeededDatasEvent>((event, emit) {
      emit(LoadAllDataForDashboardState());
    });

    on<DatasHaveLoadedEvent>((event,emit){
      emit(AlldataHaveLoadedState());
    });
  }
}
