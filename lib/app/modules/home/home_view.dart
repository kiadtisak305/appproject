import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../components/custom_appbar.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "หน้าหลัก"),
      body: SafeArea(child: Container())
    );
  }
}
