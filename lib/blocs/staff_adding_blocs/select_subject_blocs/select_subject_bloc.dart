import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttg/blocs/course_blocs/course_bloc.dart';
import 'package:ttg/blocs/staff_adding_blocs/select_course_blocs/select_course_bloc.dart';
import 'package:ttg/models/courses_model.dart';

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
          print(subjects.toString()+'  subjects');
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
