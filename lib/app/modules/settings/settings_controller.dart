
import 'package:appproject/app/services/firebase_services.dart';
import 'package:get/get.dart';

import '../../config/theme/my_theme.dart';
import '../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {

  // get is light theme from shared pref
  var isLightTheme = MySharedPref.getThemeIsLight();
  String? userName;

  @override
  void onInit() {
    userName = FirebaseServices().auth.currentUser?.displayName.toString();
    super.onInit();
  }

  /// change the system theme
  changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }

}
