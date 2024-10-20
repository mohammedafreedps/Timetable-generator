

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';

part 'select_course_event.dart';
part 'select_course_state.dart';

class SelectCourseBloc extends Bloc<SelectCourseEvent, SelectCourseState> {
  static String? selectedCourse;
  static String? selectedCourseId;
  SelectCourseBloc() : super(SelectCourseInitial()) {
    List<String> courses = [];
    on<LoadAllCoursesForSelectingEvent>((event, emit) {
      if (CourseBloc.courses.isNotEmpty) {
        courses =
            CourseBloc.courses.map((course) => course.courseName).toList();

        if (event.isForEditing != null &&
            event.isForEditing == true &&
            event.initSelectedCourse != null) {
          selectedCourse = event.initSelectedCourse;
          emit(LoadedCoursesState(
              courses: courses, selectedCourse: event.initSelectedCourse));
        } else {
          emit(LoadedCoursesState(
              courses: courses, selectedCourse: 'Select a Course'));
        }
      }
    });

    on<CousesSelectingEvent>((event, emit) {
      if (event.selectedCourses != null) {
        selectedCourse = event.selectedCourses!.trim();
      } else {
        selectedCourse = event.selectedCourses;
      }
      selectedCourseId = CourseBloc.courses
          .where((c) => c.courseName == selectedCourse)
          .toList()[0]
          .courseID;
      emit(LoadedCoursesState(
          courses: courses, selectedCourse: event.selectedCourses));
    });

    on<ClearAllSelectionsEvent>((event, emit) {
      courses.clear();
      emit(LoadedCoursesState(
          courses: courses, selectedCourse: 'Select a Course'));
    });
  }
}
