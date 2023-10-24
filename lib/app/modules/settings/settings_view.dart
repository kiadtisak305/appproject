import 'package:appproject/app/config/enums/icon_enums.dart';
import 'package:appproject/app/config/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/screen_title.dart';
import 'settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Settings',
              dividerEndIndent: 230,
            ),
            20.verticalSpace,
            Text(
              'Account',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              )
            ),
            20.verticalSpace,
            SettingsItem(
              title: 'Mike Tyson',
              icon: IconEnums.user.iconName.toSvg,
              isAccount: true,
            ),
            30.verticalSpace,
            Text(
              'Settings',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              )
            ),
            20.verticalSpace,
            SettingsItem(
              title: 'Dark Mode',
              icon: IconEnums.theme.iconName.toSvg,
              isDark: true,
            ),
            25.verticalSpace,
            SettingsItem(
              title: 'Language',
              icon: IconEnums.language.iconName.toSvg,
            ),
            25.verticalSpace,
            SettingsItem(
              title: 'Help',
              icon: IconEnums.help.iconName.toSvg,
            ),
            25.verticalSpace,
            SettingsItem(
              title: 'Sign Out',
              icon: IconEnums.logout.iconName.toSvg,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
