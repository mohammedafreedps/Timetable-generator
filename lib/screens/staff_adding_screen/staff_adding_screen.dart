import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/screens/staff_adding_screen/widgets/teaching_suject_tile.dart';
import 'package:ttg/styles/styles.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/widgets.dart';

class StaffAddingScreen extends StatefulWidget {
  final bool? isForEdit;
  final int? index;
  const StaffAddingScreen({super.key, this.isForEdit, this.index});

  @override
  State<StaffAddingScreen> createState() => _StaffAddingScreenState();
}

class _StaffAddingScreenState extends State<StaffAddingScreen> {
  final List<String> items = ['Select'];

  final staffNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.index != null) {
      staffNameController.text = StaffBloc.staffs[widget.index!].name;
    }
    _loading();
    super.didChangeDependencies();
  }

  void _loading() async {
    if (CourseBloc.courses.isEmpty) {
      context.read<CourseBloc>().add(FechCoursesDataEvent());
      await Future.delayed(const Duration(seconds: 2));
    }
    if (widget.isForEdit != null && widget.isForEdit == true) {
      context.read<SelectCourseBloc>().add(LoadAllCoursesForSelectingEvent(
          isForEditing: true,
          initSelectedCourse: StaffBloc.staffs[widget.index!].courseName));
      context.read<SelectSubjectBloc>().add(LoadSubjectBaseOnCourses());
      context.read<StaffAddingBloc>().add(ShowAddedSubjectsForEditEvent(
          addedSubjectsForEdit: StaffBloc.staffs[widget.index!].subjects));
    } else {
      context.read<SelectCourseBloc>().add(LoadAllCoursesForSelectingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectCourseBloc, SelectCourseState>(
      listener: (context, state) {
        if (state is LoadedCoursesState) {
          context.read<SelectSubjectBloc>().add(LoadSubjectBaseOnCourses());
          if (widget.isForEdit == null) {
            context.read<StaffAddingBloc>().add(ClearAddedSubjectEvent());
          }
        }
      },
      child: BlocListener<StaffAddingBloc, StaffAddingState>(
        listener: (context, state) {
          if (state is AddedSubjectsState) {
            context.read<SelectSubjectBloc>().add(LoadSubjectBaseOnCourses());
          }
          if (state is StaffDataSavedState) {
            staffNameController.clear();
            context.read<SelectSubjectBloc>().add(ClearAllSubjectsDataEvent());
            context.read<SelectCourseBloc>().add(ClearAllSelectionsEvent());
            Navigator.pop(context);
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
                Text(
                  'Staff Name',
                  style: AppTextStyles.secondaryStyle.copyWith(fontSize: 20),
                ),
                appTextField(controller: staffNameController),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SelectCourseBloc, SelectCourseState>(
                  builder: (context, state) {
                    if (state is LoadedCoursesState) {
                      return appDropdownButton(
                          items: state.courses,
                          hintText: state.selectedCourse ?? 'd',
                          onChange: (value) {
                            context.read<SelectCourseBloc>().add(
                                CousesSelectingEvent(selectedCourses: value));
                          });
                    } else {
                      return appDropdownButton(
                          items: items, hintText: 'Loding...');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<SelectSubjectBloc, SelectSubjectState>(
                        builder: (context, state) {
                          if (state is ShowCourseBasedSubjectsState) {
                            return appDropdownButton(
                                items: state.subjects,
                                hintText:
                                    state.selectedSubject ?? 'Select Subject',
                                onChange: (value) {
                                  context.read<SelectSubjectBloc>().add(
                                      LoadSubjectBaseOnCourses(
                                          selectedSubject: value));
                                });
                          } else {
                            return appDropdownButton(
                                items: items, hintText: 'Select Subjects');
                          }
                        },
                      ),
                      AppButton(
                        lable: 'Add',
                        width: 100,
                        height: 40,
                        function: () {
                          context
                              .read<StaffAddingBloc>()
                              .add(AddSubjectButtonClickedEvent());
                        },
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<StaffAddingBloc, StaffAddingState>(
                    builder: (context, state) {
                      if (state is AddedSubjectsState) {
                        return ListView.builder(
                            itemCount: state.subjects.length,
                            itemBuilder: (context, index) {
                              return teachingSubjectsTile(
                                  index + 1, state.subjects[index], () {
                                context.read<StaffAddingBloc>().add(
                                    RemoveSubjectButtonClickedEvent(
                                        index: index));
                              });
                            });
                      } else {
                        return const Center(
                          child: Text('Not added anything'),
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<StaffAddingBloc, StaffAddingState>(
                      builder: (context, state) {
                        if (state is StaffDataSavingState) {
                          return appCircularProgressIndicator();
                        } else {
                          return AppButton(
                            lable: 'Save',
                            function: () {
                              if (staffNameController.text.trim().isNotEmpty &&
                                  StaffAddingBloc.addedSubjects.isNotEmpty &&
                                  SelectCourseBloc.selectedCourse != null) {
                                if (widget.isForEdit != null &&
                                    widget.isForEdit == true) {
                                  context.read<StaffAddingBloc>().add(
                                      EditedSaveButtonClickedEvent(
                                          staffID: StaffBloc
                                              .staffs[widget.index!].id,
                                          staffName:
                                              staffNameController.text.trim()));
                                } else {
                                  context.read<StaffAddingBloc>().add(
                                      SaveButtonPressedEvent(
                                          staffName:
                                              staffNameController.text.trim()));
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
      ),
    );
  }
}
