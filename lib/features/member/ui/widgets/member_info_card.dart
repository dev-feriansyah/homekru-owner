import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String value;
  final String label;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtils.width * 0.28, // using ScreenUtil (same as yours)
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: appTheme.primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.shadowColor,
            blurRadius: 50,
            offset: Offset(10, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon background
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: appTheme.lightBlue.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(icon, color: appTheme.primaryColor, size: 22.sp),
          ),
          SizedBox(height: 15.h),

          // Value
          CText(
            value,
            color: appTheme.primaryColor,
            size: 20.sp,
            weight: FontWeight.w600,
          ),
          // SizedBox(height: 4.h),

          // Label
          CText(
            label,
            color: appTheme.grey,
            size: 13.sp,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
