import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/models/models.dart';
import 'package:ttg/repositories/repositories.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  static List<TutorsModel> staffs = [];
  StaffBloc() : super(StaffInitial()) {
    on<FetchStaffDetailsEvent>((event, emit) async {
      emit(StaffDetailsLoadingState());
      staffs = await StaffDataHandling.getAllStaffFromDatabase();

      emit(StaffDetailsLoadedState(staffs: staffs));
    });

    on<DeleteStaffButtonClickedEvent>((event,emit) async {
      await StaffDataHandling.deleteStaffFromDatabase(documentId: event.id);
      emit(StaffDeletedState());
    });

  }
}
