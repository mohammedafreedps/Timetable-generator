import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/models/models.dart';

part 'select_subject_event.dart';
part 'select_subject_state.dart';

class SelectSubjectBloc extends Bloc<SelectSubjectEvent, SelectSubjectState> {
  List<String> subjects = [];
  static String? selectedSubject;
  
  SelectSubjectBloc() : super(SelectSubjectInitial()) {
    
    on<LoadSubjectBaseOnCourses>((event, emit) {
      if (SelectCourseBloc.selectedCourse != null) {
        final List<CoursesModel> matchingCourses = CourseBloc.courses
            .where((course) => course.courseName == SelectCourseBloc.selectedCourse!)
            .toList();
        if (matchingCourses.isNotEmpty) {
          CoursesModel model = matchingCourses.first;  
          subjects = model.subjects;  
          selectedSubject = event.selectedSubject;
          emit(ShowCourseBasedSubjectsState(subjects: subjects,selectedSubject: selectedSubject));
        } else {
          print('no maching found');

        }
      } else {
        print('course not selected');
      }
    });

    on<ClearSelectedSubjectEvent>((event,emit){

      emit(ShowCourseBasedSubjectsState(subjects: subjects,selectedSubject: selectedSubject));
    });

    on<ClearAllSubjectsDataEvent>((event,emit){
      selectedSubject = null;
      // subjects.clear();
      print(subjects);
      emit(ShowCourseBasedSubjectsState(subjects: subjects,selectedSubject: selectedSubject));
    });
  }
}
