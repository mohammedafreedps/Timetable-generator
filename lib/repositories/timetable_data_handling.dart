import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ttg/models/models.dart';


class TimetableDataHandling {
  static Future<void> addTimetableToDatabase(TimetableModel timetable) async {
    CollectionReference timetables = FirebaseFirestore.instance.collection('timetables');
    
    List<Map<String, dynamic>> timetableEntries = timetable.timetableEntryModel.map((entry) => entry.toMap()).toList();
    
    await timetables.doc(timetable.id).set({
      'id': timetable.id,
      'courseName': timetable.courseName.trim(),
      'timetableEntries': timetableEntries,
    });
  }

  static Future<List<TimetableModel>> getAllTimetablesFromDatabase() async {
    CollectionReference timetablesCollection = FirebaseFirestore.instance.collection('timetables');
    QuerySnapshot querySnapshot = await timetablesCollection.get();
    
    List<TimetableModel> timetableList = querySnapshot.docs.map((doc) {
      List<dynamic> entries = doc['timetableEntries'];
      
      List<TimeTableEntryModel> timetableEntries = entries.map((entryMap) {
        return TimeTableEntryModel.fromMap(entryMap as Map<String, dynamic>);
      }).toList();
      
      return TimetableModel(
        id: doc['id'],
        courseName: doc['courseName'],
        timetableEntryModel: timetableEntries,
      );
    }).toList();

    return timetableList;
  }

static Future<void> deleteTimetableByCourseName({required String courseName}) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('timetables')
      .where('courseName', isEqualTo: courseName)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    String documentId = querySnapshot.docs.first.id;

    await FirebaseFirestore.instance.collection('timetables').doc(documentId).delete();
  }
}


  static Future<void> editTimetableInDatabase(TimetableModel updatedTimetable) async {
    CollectionReference timetables = FirebaseFirestore.instance.collection('timetables');
    
    List<Map<String, dynamic>> timetableEntries = updatedTimetable.timetableEntryModel.map((entry) => entry.toMap()).toList();
    
    await timetables.doc(updatedTimetable.id).update({
      'courseName': updatedTimetable.courseName.trim(),
      'timetableEntries': timetableEntries,
    });
  }

static Future<TimetableModel?> getTimetableByCourseName(String courseName) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('timetables')
      .where('courseName', isEqualTo: courseName)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    DocumentSnapshot doc = querySnapshot.docs.first; 
    List<dynamic> entries = doc['timetableEntries'];
    
    List<TimeTableEntryModel> timetableEntries = entries.map((entryMap) {
      return TimeTableEntryModel.fromMap(entryMap as Map<String, dynamic>);
    }).toList();

    return TimetableModel(
      id: doc['id'],
      courseName: doc['courseName'],
      timetableEntryModel: timetableEntries,
    );
  }
  return null; 
}

}
