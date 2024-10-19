import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttg/models/tutors_model.dart';
import 'package:ttg/repositories/staff_data_handling.dart';

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
