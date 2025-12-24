import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';

Widget vGap(double height) {
  return SizedBox(height: height.h);
}

Widget hGap(double width) {
  return SizedBox(width: width.w);
}

Future<TimeOfDay?> showCustomTimePicker(BuildContext context) async {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            hourMinuteTextColor: appTheme.primaryColor,
            hourMinuteColor: appTheme.primaryColor.withOpacity(0.2),
            dayPeriodTextColor: appTheme.primaryColor,
            dayPeriodColor: appTheme.primaryColor.withOpacity(0.2),
            dialHandColor: appTheme.primaryColor,
            dialBackgroundColor: appTheme.primaryColor.withOpacity(0.2),
            entryModeIconColor: appTheme.primaryColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: appTheme.primaryColor, // Cancel/OK button color
            ),
          ),
          colorScheme: ColorScheme.light(
            primary: appTheme.primaryColor, // Active dial
            onPrimary: Colors.white,
            onSurface: Colors.black, // Numbers
          ),
        ),
        child: child!,
      );
    },
  );
}

Widget bottomWaveWidget({double? height, double? width}) {
  return Positioned(
    bottom: 0,
    left: 0,
    child: CustomImageView(
      imagePath: ImageConstant.bottomWave2,
      height: height,
      width: width ?? SizeUtils.width * 0.6,
      fit: BoxFit.fill,
    ),
  );
}
