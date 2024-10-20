import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/models/models.dart';
import 'package:ttg/repositories/repositories.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  static List<CoursesModel> courses = [];
  CourseBloc() : super(CourseInitial()) {
    on<FechCoursesDataEvent>((event, emit) async {
      courses = await CourseDataHandling.getAllCoursesFromDatabase();
      emit(FechedCourseDataState(courses: courses));
    });

    on<DeleteCourseButtonClickedEvent>((event,emit)async{
      emit(CourseDeletingState());
      await CourseDataHandling.deleteCoursesFromDatabase(documentId: event.documentId);
      emit(CourseDeletedState());
    });

  }
}