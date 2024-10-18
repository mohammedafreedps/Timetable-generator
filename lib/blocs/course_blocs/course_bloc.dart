import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttg/models/courses_model.dart';
import 'package:ttg/repositories/course_data_handling.dart';

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
// on<>((event,emit){});