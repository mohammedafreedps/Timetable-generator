import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttg/blocs/staff_adding_blocs/select_course_blocs/select_course_bloc.dart';
import 'package:ttg/blocs/staff_adding_blocs/select_subject_blocs/select_subject_bloc.dart';
import 'package:ttg/models/courses_model.dart';
import 'package:ttg/repositories/staff_data_handling.dart';

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

    on<SaveButtonPressedEvent>((event,emit){
      print(event.staffName);
      print(addedSubjects);
      print(SelectCourseBloc.selectedCourse);
      print(SelectCourseBloc.selectedCourseId! + '  course id ok');
      emit(StaffDataSavingState());
      StaffDataHandling.addStaffToDatabase(event.staffName, SelectCourseBloc.selectedCourseId!, addedSubjects.toList());
      emit(StaffDataSavedState());
    });
  }
}
