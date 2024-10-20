import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/models/models.dart';
import 'package:ttg/repositories/repositories.dart';
import 'package:ttg/services/timeTableCreator.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  static List<TimeTableEntryModel> generatedTimetable = [];
  TimetableModel? timetableModel;
  TimetableBloc() : super(TimetableInitial()) {
    on<LoadTimetableEvnet>((event, emit) async {
      emit(TimetableLoadingState());
      timetableModel =
          await TimetableDataHandling.getTimetableByCourseName(
              event.courseName);
      if (timetableModel != null) {
        emit(TimetableLoadedState(
            timetableEntryModels: timetableModel!.timetableEntryModel));
      } else {
        emit(NotFoundTimetableState());
      }
    });

    on<GenerateTimetableEvnet>((event,emit){
      generatedTimetable = generateCourseTimeTable(event.courseModel, StaffBloc.staffs);
      emit(GeneratedTimetableLoadedState(timetableEntryModels: generatedTimetable));
    });

    on<SaveGeneratedTimeTableButtonClickedEvent>((event,emit)async{
      emit(TimetableLoadingState());
      if(generatedTimetable.isNotEmpty){
        await TimetableDataHandling.addTimetableToDatabase(TimetableModel(id: DateTime.now().toString(), courseName: event.courseName, timetableEntryModel: generatedTimetable));
      }
      emit(TimetableLoadedState(timetableEntryModels: generatedTimetable));
      // generatedTimetable.clear();
    });

    on<DeleteSavedTimtableButtonClickedEvent>((event,emit)async{
      emit(TimetableLoadingState());
        await TimetableDataHandling.deleteTimetableByCourseName(courseName: event.courseName);
      emit(NotFoundTimetableState());
    });
  }
}
