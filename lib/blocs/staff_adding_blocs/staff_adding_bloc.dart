import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/models/models.dart';
import 'package:ttg/repositories/repositories.dart';

part 'staff_adding_event.dart';
part 'staff_adding_state.dart';

class StaffAddingBloc extends Bloc<StaffAddingEvent, StaffAddingState> {
  List<String> courses = [];
  List<CoursesModel> theCourse = [];
  String selectedCourse = '';
  static Set<String> addedSubjects = {};  

  StaffAddingBloc() : super(StaffAddingInitial()) {
    on<AddSubjectButtonClickedEvent>((event, emit) {
      if (SelectSubjectBloc.selectedSubject != null) {
        addedSubjects.add(SelectSubjectBloc.selectedSubject!);
        emit(AddedSubjectsState(subjects: addedSubjects.toList()));
      }
    });

    on<ShowAddedSubjectsForEditEvent>((event,emit){
      addedSubjects.addAll(event.addedSubjectsForEdit);
      emit(AddedSubjectsState(subjects: addedSubjects.toList()));
    });

    on<ClearAddedSubjectEvent>((event, emit) {
      addedSubjects.clear();
      emit(AddedSubjectsState(subjects: addedSubjects.toList()));
    });

    on<RemoveSubjectButtonClickedEvent>((event, emit) {
      final List<String> tempSubjects = addedSubjects.toList();
      
      if (event.index >= 0 && event.index < tempSubjects.length) {
        addedSubjects.remove(tempSubjects[event.index]);
        emit(AddedSubjectsState(subjects: addedSubjects.toList()));
      }
    });

    on<SaveButtonPressedEvent>((event,emit)async{
      emit(StaffDataSavingState());
      await StaffDataHandling.addStaffToDatabase(event.staffName, SelectCourseBloc.selectedCourseId!, addedSubjects.toList());
      emit(StaffDataSavedState());
    });

    on<EditedSaveButtonClickedEvent>((event,emit)async{
      emit(StaffDataSavingState());
      if(event.staffID.isNotEmpty && event.staffName.isNotEmpty&&SelectCourseBloc.selectedCourse != null &&addedSubjects.toList().isNotEmpty){

      }else{
        if(SelectCourseBloc.selectedCourse == null){
        }
      }
      await StaffDataHandling.editStaffDataFromDatabase(event.staffID,event.staffName,SelectCourseBloc.selectedCourse!,addedSubjects.toList());
      emit(StaffDataSavedState());
    });
  }
}
