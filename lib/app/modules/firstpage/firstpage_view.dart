import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/screen_title.dart';
import 'firstpage_controller.dart';


class FirstPageView extends GetView<FirstPageController> {
  const FirstPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Home',
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
