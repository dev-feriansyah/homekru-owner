import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    return Container(
      width: 1.sw * 0.28, // using ScreenUtil (same as yours)
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
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
              color: colorScheme.primaryContainer.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 22.sp),
          ),
          SizedBox(height: 15.h),

          // Value
          CText(
            value,
            color: colorScheme.primary,
            size: 20.sp,
            weight: FontWeight.w600,
          ),
          // SizedBox(height: 4.h),

          // Label
          CText(
            label,
            color: appColors.grey,
            size: 13.sp,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
