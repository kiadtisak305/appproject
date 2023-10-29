import 'package:appproject/app/components/custom_appbar.dart';
import 'package:appproject/screen/login.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'loginpage_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: const Color(0xff283593),
      appBar: const CustomAppbar(title: "เข้าสู่ระบบ"),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xff4B1F4D).withOpacity(0.1),
            BlendMode.color,
          ),
        ),
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: theme.backgroundColor
                ),
                child: const LoginScreen()
              ),
            )
          ],
        ),
      )
    );
  }
}
