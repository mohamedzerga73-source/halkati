import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> studentsForTeacher(String uid) =>
      _db.collection('students').where('teacherUid', isEqualTo: uid).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> studentsForGuardian(String uid) =>
      _db.collection('students').where('guardianUid', isEqualTo: uid).snapshots();

  Future<DocumentReference<Map<String, dynamic>>> addStudent(Map<String,dynamic> data) =>
      _db.collection('students').add(data);

  Future<void> addMemorization(Map<String,dynamic> data) =>
      _db.collection('memorization').add(data);

  Future<void> addReview(Map<String,dynamic> data) =>
      _db.collection('reviews').add(data);

  Future<void> saveAttendance(String id, Map<String,dynamic> data) =>
      _db.collection('attendance').doc(id).set(data);
}
