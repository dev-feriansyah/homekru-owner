import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';
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
            hourMinuteTextColor: appColors.primaryColor,
            hourMinuteColor: appColors.primaryColor.withValues(alpha: 0.2),
            dayPeriodTextColor: appColors.primaryColor,
            dayPeriodColor: appColors.primaryColor.withValues(alpha: 0.2),
            dialHandColor: appColors.primaryColor,
            dialBackgroundColor: appColors.primaryColor.withValues(alpha: 0.2),
            entryModeIconColor: appColors.primaryColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: appColors.primaryColor, // Cancel/OK button color
            ),
          ),
          colorScheme: ColorScheme.light(
            primary: appColors.primaryColor, // Active dial
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
      width: width ?? 1.sw * 0.6,
      fit: BoxFit.fill,
    ),
  );
}
