import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseServices {
  // Authentication
  Future<bool> login({
    required String email,
    required String password,
  });
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();

  // Firestore
}
