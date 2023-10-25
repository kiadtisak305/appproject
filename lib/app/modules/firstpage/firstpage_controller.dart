import 'package:appproject/app/config/routes/app_pages.dart';
import 'package:appproject/app/services/firebase_services.dart';
import 'package:get/get.dart';

class FirstPageController extends GetxController {

  Future<void> toLoginPage() async {
    Get.toNamed(Routes.LOAD);
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
    Get.toNamed(Routes.LOGIN);
  }

  Future<void> toRegisterPage() async {
    FirebaseServices().signInWithGoogle()
    .then((user) async {
      Get.toNamed(Routes.LOAD);
      await Future.delayed(const Duration(seconds: 2));
      return Get.offAllNamed(Routes.BASE);
    });
      
  }
}
