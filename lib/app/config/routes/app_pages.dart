import 'package:get/get.dart';

import '../../modules/base/base_binding.dart';
import '../../modules/base/base_view.dart';
import '../../modules/firstpage/firstpage_binding.dart';
import '../../modules/firstpage/firstpage_view.dart';
import '../../modules/home/home_binding.dart';
import '../../modules/home/home_view.dart';
import '../../modules/settings/settings_binding.dart';
import '../../modules/settings/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FIRST;

  static final routes = [
    GetPage(
      name: _Paths.FIRST,
      page: () => const FirstPageView(),
      binding: FirstPageBinding(),
    ),
    GetPage(
      name: _Paths.BASE,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
