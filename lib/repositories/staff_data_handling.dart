import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ttg/models/models.dart'; 

class StaffDataHandling {
  static Future<void> addStaffToDatabase(String name, String courseName, List<String> subjects) async {
    CollectionReference staffs = FirebaseFirestore.instance.collection('staffs');

    DocumentReference docRef = staffs.doc();
    TutorsModel tutor = TutorsModel(
      id: docRef.id, 
      name: name,
      courseName: courseName,
      subjects: subjects,
    );

    await docRef.set(tutor.toFirestore());
  }

 
  static Future<List<TutorsModel>> getAllStaffFromDatabase() async {
    CollectionReference staffsCollection = FirebaseFirestore.instance.collection('staffs');
    QuerySnapshot querySnapshot = await staffsCollection.get();

    List<TutorsModel> staffList = querySnapshot.docs.map((doc) {
      return TutorsModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    return staffList;
  }

  static Future<void> deleteStaffFromDatabase({required String documentId}) async {
    CollectionReference staffs = FirebaseFirestore.instance.collection('staffs');
    await staffs.doc(documentId).delete();
  }

  static Future<void> editStaffDataFromDatabase(
    String staffId, 
    String name,
    String courseName,
    List<String> subjects,
  ) async {
    CollectionReference staffs = FirebaseFirestore.instance.collection('staffs');
    
    await staffs.doc(staffId).update({
      'name': name.trim(),
      'courseName': courseName.trim(),
      'subjects': subjects,
    });
  }
}
