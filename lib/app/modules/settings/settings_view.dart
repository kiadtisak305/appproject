import 'package:appproject/app/components/custom_appbar.dart';
import 'package:appproject/app/components/popup/popups.dart';
import 'package:appproject/component/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/screen_title.dart';
import '../../config/extensions/constants.dart';
import '../../services/firebase_services.dart';
import 'settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    if (controller.userName == null) {
      return const LoadingScreen();
    } else {
      return Scaffold(
        appBar: const CustomAppbar(title: "การตั้งค่า"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            20.verticalSpace,
            Text(
              'บัญชี',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              )
            ),
            20.verticalSpace,
            SettingsItem(
              title: FirebaseServices().auth.currentUser!.displayName.toString(),
              icon: Constants.userIcon,
              isAccount: true,
            ),
            30.verticalSpace,
            Text(
              'ตั้งค่า',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              )
            ),
            20.verticalSpace,
            const SettingsItem(
              title: 'โหมดมืด',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            // const SettingsItem(
            //   title: 'Language',
            //   icon: Constants.languageIcon,
            // ),
            // 25.verticalSpace,
            // const SettingsItem(
            //   title: 'Help',
            //   icon: Constants.helpIcon,
            // ),
            // 25.verticalSpace,
            InkWell(
              child: const SettingsItem(
                title: 'ออกจากระบบ',
                icon: Constants.logoutIcon,
              ),
              onTap: () => PopupUtils.logOutPopup(context),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
    }
    
  }
}
