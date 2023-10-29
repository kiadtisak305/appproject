import 'package:appproject/app/config/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/firebase_services.dart';
import '../button/custom_button.dart';
import '../text/custom_text.dart';

@immutable
class PopupUtils {
  const PopupUtils._();

  static Future<dynamic> mainPopup(
    BuildContext context, {
    double height = 170,
    double width = double.infinity,
    required Widget child,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final theme = context.theme;
        return ScaleTransition(
          scale: Tween<double>(begin: .5, end: 1).animate(animation),
          child: AlertDialog(
            backgroundColor: Colors.white,
            insetPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                // color: theme.cardColor,
                width: 1.5,
              ),
            ),
            content: SizedBox(
              height: height.h,
              width: width,
              child: child,
            ),
          ),
        );
      },
    );
  }

  static logOutPopup(BuildContext context) {
    return mainPopup(
      context,
      width: 170,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              "ยืนยันการออกจากระบบ?",
              textStyle: context.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: () {
                    FirebaseServices().signOut();
                  },
                  text: "ยืนยัน",
                  width: 80,
                  height: 50,
                ),
                CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  text: "ยกเลิก",
                  width: 80,
                  height: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
