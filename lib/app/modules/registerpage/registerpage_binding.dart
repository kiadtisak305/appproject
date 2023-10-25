import 'package:get/get.dart';

import 'registerpage_controller.dart';

class RegisterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPageController>(
      () => RegisterPageController(),
    );
  }
}
