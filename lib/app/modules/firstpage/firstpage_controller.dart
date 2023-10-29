import 'package:appproject/app/config/routes/app_pages.dart';
import 'package:appproject/app/services/firebase_services.dart';
import 'package:get/get.dart';

import '../../components/custom_snackbar.dart';
import '../../config/extensions/app_constants.dart';

class FirstPageController extends GetxController {

  Future<void> toLoginPage() async {
    Get.toNamed(Routes.LOAD);
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
    Get.toNamed(Routes.LOGIN);
  }

  Future<void> googleSignIn() async {
    FirebaseServices().signInWithGoogle()
    .then((user) async {
      Get.toNamed(Routes.LOAD);
      await Future.delayed(const Duration(seconds: 1));
      CustomSnackBar.showCustomSnackBar(
          title: AppConstants.instance.titlesucceed,
          message: AppConstants.instance.loginsucceed);
      return Get.offAllNamed(Routes.BASE);
    });
      
  }

  Future<void> toRegisterPage() async {
    Get.toNamed(Routes.LOAD);
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
    Get.toNamed(Routes.REGISTER);
  }
}
