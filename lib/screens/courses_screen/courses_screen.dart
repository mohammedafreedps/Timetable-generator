import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/screens/courses_adding_screen/courses_adding_screen.dart';
import 'package:ttg/screens/courses_screen/widgets/courses_tile.dart';
import 'package:ttg/styles/app_styles.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/app_circular_progress_indicator.dart';
import 'package:ttg/widgets/app_dialog_box.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseAddingBloc, CourseAddingState>(
      listener: (context, state) {
        if (state is CourseSavedState) {
          context.read<CourseBloc>().add(FechCoursesDataEvent());
          CourseAddingBloc.addedSubjects.clear();
        }
      },
      child: BlocListener<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is CourseDeletedState) {
            context.read<CourseBloc>().add(FechCoursesDataEvent());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Courses',
              style: AppTextStyles.secondaryStyle,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CoursesAddingScreen()),
                    );
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPaddings.screenPadding),
            child: BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) {
                if (state is FechedCourseDataState) {
                  return state.courses.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.courses.length,
                          itemBuilder: (context, index) {
                            return coursesTile(() {
                              appDialogBox(
                                  context: context,
                                  title:
                                      'Do you really Want to delete this Course',
                                  yesFunction: () {
                                    context.read<CourseBloc>().add(
                                        DeleteCourseButtonClickedEvent(
                                            documentId:
                                                state.courses[index].courseID));
                                  });
                            }, () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => CoursesAddingScreen(
                                        isForEdit: true,
                                        index: index,
                                      )));
                            }, state.courses[index].subjects,
                                state.courses[index].courseName);
                          })
                      : const Center(
                          child: Text('No data to show'),
                        );
                } else {
                  return Center(
                    child: appCircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
