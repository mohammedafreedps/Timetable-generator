import 'package:ttg/models/models.dart';

class TimetableModel {
  String id;
  String courseName;
  List<TimeTableEntryModel> timetableEntryModel;
  TimetableModel({required this.id, required this.courseName, required this.timetableEntryModel});
}