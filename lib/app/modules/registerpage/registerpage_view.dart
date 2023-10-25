import 'package:appproject/app/components/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'registerpage_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "ลงทะเบียน"),
      body: SafeArea(child: Container())
    );
  }
}
