import 'package:appproject/app/components/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'loginpage_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "เข้าสู่ระบบ"),
      body: SafeArea(child: Container())
    );
  }
}
