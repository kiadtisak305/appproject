import 'package:appproject/app/config/enums/icon_enums.dart';
import 'package:appproject/app/config/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoData extends StatelessWidget {
  final String? text;
  const NoData({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        80.verticalSpace,
        Image.asset(IconEnums.noData.iconName.toPng),
        20.verticalSpace,
        Text(text ?? 'No Data', style: context.textTheme.displayMedium),
      ],
    );
  }
}
