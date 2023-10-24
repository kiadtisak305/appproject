import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../config/enums/firebase_enums.dart';
import '../data/model/user_model.dart';
import 'i_firebase_services.dart';

class FirebaseServices extends IFirebaseServices {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      // scopes: <String>[FirebaseEnums.email.value],
    ).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    log("TOKEN : ${credential.accessToken}");
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }
  
  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log(user.toString());
      log(user.user!.uid);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var doc =
        FirebaseFirestore.instance.collection(FirebaseEnums.user.value).doc();
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (user.user?.displayName == null) {
      user.user!.updateDisplayName(name);
    }
    try {
      final yeniUser = UserModel(
        id: user.user!.uid,
        email: email,
        name: name,
      );
      await doc.set(yeniUser.toJson());
      log("NEW TOKEN : ${user.user?.uid}");
      return true;
    } catch (e) {
      return false;
    }
  }
}
