import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttg/blocs/course_blocs/course_bloc.dart';
import 'package:ttg/repositories/course_data_handling.dart';

part 'course_adding_event.dart';
part 'course_adding_state.dart';

class CourseAddingBloc extends Bloc<CourseAddingEvent, CourseAddingState> {
  static List<String> addedSubjects = [];
  CourseAddingBloc() : super(CourseAddingInitial()) {
     
    on<AddButtonClickedEvent>((event, emit) { 
      addedSubjects.add(event.subjectName);
      emit(AddedSubjectShowState(addedSubjects: addedSubjects));
    });

    on<DeleteButtonClickedEvent>((event,emit){
      addedSubjects.removeAt(event.index);
      emit(AddedSubjectShowState(addedSubjects: addedSubjects));
    });

    on<SaveButtonClickedEvent>((event,emit) async {
      emit(CourseSavingState());
      await CourseDataHandling.addCourseToDatabase(event.mainCourseName, addedSubjects, []);
      emit(CourseSavedState());
    });
    
    on<LoadAddedSubjectForEditEvent>((event,emit){
      addedSubjects = CourseBloc.courses[event.index].subjects;
      emit(AddedSubjectShowState(addedSubjects: addedSubjects));
    });
    
    on<EditedCourseSaveButtonClickedEvent>((event,emit)async{
      emit(CourseSavingState());
      await CourseDataHandling.editCoursesDataFromDatabase(event.courseId, event.mainCourseName, addedSubjects);
      emit(CourseSavedState());
    });
  }
}
// on<>((event,emit){});