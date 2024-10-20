part of 'course_adding_bloc.dart';

@immutable
sealed class CourseAddingEvent {}

final class AddButtonClickedEvent extends CourseAddingEvent {
  final String subjectName;
  AddButtonClickedEvent({required this.subjectName});
}

final class DeleteButtonClickedEvent extends CourseAddingEvent{
  final int index;
  DeleteButtonClickedEvent({required this.index});
}

final class SaveButtonClickedEvent extends CourseAddingEvent{
  final String mainCourseName;
  SaveButtonClickedEvent({required this.mainCourseName});
}

final class LoadAddedSubjectForEditEvent extends CourseAddingEvent{
  final int index;
  LoadAddedSubjectForEditEvent({required this.index});
}

final class EditedCourseSaveButtonClickedEvent extends CourseAddingEvent{
  final String courseId;
  final String mainCourseName;
  EditedCourseSaveButtonClickedEvent({required this.courseId,required this.mainCourseName});
}