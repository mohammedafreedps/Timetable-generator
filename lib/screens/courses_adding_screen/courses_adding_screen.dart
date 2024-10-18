import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/screens/courses_adding_screen/widgets/added_subjects_tile.dart';
import 'package:ttg/styles/app_styles.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/app_button.dart';
import 'package:ttg/widgets/app_circular_progress_indicator.dart';
import 'package:ttg/widgets/app_textfield.dart';

class CoursesAddingScreen extends StatefulWidget {
  final bool isForEdit;
  final int? index;
  const CoursesAddingScreen({super.key, this.isForEdit = false, this.index});

  @override
  State<CoursesAddingScreen> createState() => _CoursesAddingScreenState();
}

class _CoursesAddingScreenState extends State<CoursesAddingScreen> {
  final mainCourseNameController = TextEditingController();

  final subjectsController = TextEditingController();

  @override
  void initState() {
    if (widget.isForEdit && widget.index != null) {
      mainCourseNameController.text =
          CourseBloc.courses[widget.index!].courseName;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.isForEdit && widget.index != null) {
      context
          .read<CourseAddingBloc>()
          .add(LoadAddedSubjectForEditEvent(index: widget.index!));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseAddingBloc, CourseAddingState>(
      listener: (context, state) {
        if (state is CourseSavedState) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(AppPaddings.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Main Course Name',
                  style: AppTextStyles.secondaryStyle.copyWith(fontSize: 20)),
              appTextField(controller: mainCourseNameController),
              const SizedBox(
                height: 50,
              ),
              Text('Subjects',
                  style: AppTextStyles.secondaryStyle.copyWith(fontSize: 20)),
              appTextField(controller: subjectsController),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    lable: 'Add',
                    width: 100,
                    height: 40,
                    function: () {
                      if (subjectsController.text.isNotEmpty) {
                        context.read<CourseAddingBloc>().add(
                            AddButtonClickedEvent(
                                subjectName: subjectsController.text));
                      }
                      subjectsController.clear();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              Expanded(
                child: BlocBuilder<CourseAddingBloc, CourseAddingState>(
                  builder: (context, state) {
                    if (state is AddedSubjectShowState) {
                      return state.addedSubjects.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.addedSubjects.length,
                              itemBuilder: (context, index) {
                                return addedSubjectsTile(() {
                                  context.read<CourseAddingBloc>().add(
                                      DeleteButtonClickedEvent(index: index));
                                }, index + 1, state.addedSubjects[index]);
                              })
                          : const Center(
                              child: Text('Nothing Has added'),
                            );
                    }
                    return const Center(
                      child: Text('Nothing Has added'),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<CourseAddingBloc, CourseAddingState>(
                    builder: (context, state) {
                      if (state is CourseSavingState) {
                        return appCircularProgressIndicator();
                      } else {
                        return AppButton(
                          lable: 'Save',
                          function: () {
                            if (widget.isForEdit && widget.index != null) {
                              context.read<CourseAddingBloc>().add(
                                  EditedCourseSaveButtonClickedEvent(
                                      courseId: CourseBloc
                                          .courses[widget.index!].courseID,
                                      mainCourseName:
                                          mainCourseNameController.text));
                                          
                            } else {
                              if (mainCourseNameController.text.isNotEmpty &&
                                  CourseAddingBloc.addedSubjects.isNotEmpty) {
                                context.read<CourseAddingBloc>().add(
                                    SaveButtonClickedEvent(
                                        mainCourseName:
                                            mainCourseNameController.text));
                              }
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
