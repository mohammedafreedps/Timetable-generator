import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttg/blocs/course_blocs/course_bloc.dart';

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
        emit(LoadedCoursesState(
            courses: courses, selectedCourse: 'Select a Course'));
      }
    });

    on<CousesSelectingEvent>((event,emit){
      selectedCourse = event.selectedCourses;
      selectedCourseId = CourseBloc.courses.where((c)=> c.courseName == selectedCourse).toList()[0].courseID;
      emit(LoadedCoursesState(courses: courses,selectedCourse: event.selectedCourses));
    });

    on<ClearAllSelectionsEvent>((event,emit){
      courses.clear();
      emit(LoadedCoursesState(courses: courses,selectedCourse: 'Select a Course'));
    });
  }
}
