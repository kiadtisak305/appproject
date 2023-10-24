import 'package:get/get.dart';

import 'firstpage_controller.dart';

class FirstPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstPageController>(
      () => FirstPageController(),
    );
  }
}
