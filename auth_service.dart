import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> register({required String email, required String password,
    required String name, required String role}) async {
    final c = await _auth.createUserWithEmailAndPassword(
      email: email.trim(), password: password);
    await _db.collection('users').doc(c.user!.uid).set({
      'name': name.trim(), 'email': email.trim(), 'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  Future<void> signOut() => _auth.signOut();
}
