import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/custom_snackbar.dart';
import '../config/enums/firebase_enums.dart';
import '../config/extensions/app_constants.dart';
import '../config/routes/app_pages.dart';
import '../data/model/user_model.dart';
import 'i_firebase_services.dart';

class FirebaseServices extends IFirebaseServices {

  String? errormessage;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

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
    await GoogleSignIn().signOut();
    auth.signOut();
    Get.toNamed(Routes.LOAD);
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(Routes.FIRST);
  }
  
  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var user = await auth.signInWithEmailAndPassword(email: email, password: password);
      log(user.toString());
      log(user.user!.uid);
      Get.toNamed(Routes.LOAD);
      await Future.delayed(const Duration(seconds: 1));
      CustomSnackBar.showCustomSnackBar(
          title: AppConstants.instance.titlesucceed,
          message: AppConstants.instance.loginsucceed);
      Get.offAllNamed(Routes.BASE);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'weak-password') {
        errormessage = AppConstants.instance.passvaridate;
      } else {
        errormessage = AppConstants.instance.passvaridatefail;
      }
      CustomSnackBar.showCustomErrorSnackBar(
          title: AppConstants.instance.titleerror + e.code,
          message: errormessage.toString());
      return false;
    }
  }

  @override
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var doc =
          FirebaseFirestore.instance.collection(FirebaseEnums.user.value).doc();
      var user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user.user?.displayName == null) {
        user.user!.updateDisplayName(name);
      }
      final saveUser = UserModel(
        id: user.user!.uid,
        email: email,
        name: name,
      );
      await doc.set(saveUser.toJson());
      log("NEW TOKEN : ${user.user?.uid}");
      await Future.delayed(const Duration(seconds: 1));
      CustomSnackBar.showCustomSnackBar(
          title: AppConstants.instance.titlesucceed,
          message: AppConstants.instance.registersucceed);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'weak-password') {
        errormessage = AppConstants.instance.passvaridate;
      } else if (e.code == 'email-already-in-use') {
        errormessage = AppConstants.instance.emailvaridatefail;
      } else {
        errormessage = AppConstants.instance.varidatefail;
      }
      CustomSnackBar.showCustomErrorSnackBar(
          title: AppConstants.instance.titleerror + e.code,
          message: errormessage.toString());
      return false;
    }
  }
}
