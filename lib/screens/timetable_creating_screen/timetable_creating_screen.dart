import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/models/models.dart';
import 'package:ttg/screens/timetable_creating_screen/widgets/timetabel_tile.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/widgets.dart';

class TimetableCreatingScreen extends StatefulWidget {
  final CoursesModel courseModel;
  const TimetableCreatingScreen({super.key, required this.courseModel});

  @override
  State<TimetableCreatingScreen> createState() =>
      _TimetableCreatingScreenState();
}

class _TimetableCreatingScreenState extends State<TimetableCreatingScreen> {
  @override
  void initState() {
    context
        .read<TimetableBloc>()
        .add(LoadTimetableEvnet(courseName: widget.courseModel.courseName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimetableBloc, TimetableState>(
      listener: (context, state) {
        if (state is NotFoundTimetableState) {
          context.read<TimetableBloc>().add(GenerateTimetableEvnet(
              courseModel: widget.courseModel,
              courseName: widget.courseModel.courseName));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.courseModel.courseName),
            actions: [
              BlocBuilder<TimetableBloc, TimetableState>(
                builder: (context, state) {
                  if (state is GeneratedTimetableLoadedState) {
                    return IconButton(
                        onPressed: () {
                          context.read<TimetableBloc>().add(
                              GenerateTimetableEvnet(
                                  courseName: widget.courseModel.courseName,
                                  courseModel: widget.courseModel));
                        },
                        icon: const Icon(Icons.refresh));
                  }
                  return Container();
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPaddings.screenPadding),
            child: BlocBuilder<TimetableBloc, TimetableState>(
              builder: (context, state) {
                if (state is GeneratedTimetableLoadedState) {
                  return Column(
                    children: [
                      const Text('Generated Timetable'),
                      Expanded(
                          child: ListView(children: [
                        timeTableTile(state.timetableEntryModels)
                      ])),
                      AppButton(
                        lable: 'Save',
                        function: () {
                          context.read<TimetableBloc>().add(
                              SaveGeneratedTimeTableButtonClickedEvent(
                                  courseName: widget.courseModel.courseName));
                        },
                      ),
                    ],
                  );
                }
                if (state is TimetableLoadedState) {
                  return Column(
                    children: [
                      const Text('Saved Timetable'),
                      Expanded(
                          child: ListView(children: [
                        timeTableTile(state.timetableEntryModels)
                      ])),
                      AppButton(
                        lable: 'Delete',
                        function: () {
                          appDialogBox(
                              context: context,
                              title:
                                  'Do you really want to delete Timetable ${widget.courseModel.courseName}',
                              yesFunction: () {
                                context.read<TimetableBloc>().add(
                                    DeleteSavedTimtableButtonClickedEvent(
                                        courseName:
                                            widget.courseModel.courseName));
                              });
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: appCircularProgressIndicator(),
                  );
                }
              },
            ),
          )),
    );
  }
}
