import 'package:flutter/material.dart';
import 'package:ttg/blocs/staff_blocs/staff_bloc.dart';
import 'package:ttg/models/courses_model.dart';
import 'package:ttg/models/timetable_entry_model.dart';
import 'package:ttg/screens/timetable_creating_screen/widgets/timetabel_tile.dart';
import 'package:ttg/services/timeTableCreator.dart';
import 'package:ttg/utils/constants.dart';

class TimetableCreatingScreen extends StatefulWidget {
  final CoursesModel courseModel;
  const TimetableCreatingScreen({super.key, required this.courseModel});

  @override
  State<TimetableCreatingScreen> createState() =>
      _TimetableCreatingScreenState();
}

class _TimetableCreatingScreenState extends State<TimetableCreatingScreen> {
  List<TimeTableEntryModel> timetable = [];
  @override
  void initState() {
    timetable = generateCourseTimeTable(widget.courseModel, StaffBloc.staffs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
      padding: EdgeInsets.all(AppPaddings.screenPadding),
      child: ListView(children: [timeTableTile(timetable)]),
    ));
  }
}