import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          label,
          color: appTheme.textPrimary,
          size: 14.sp,
          weight: FontWeight.w600,
        ),
        SizedBox(height: 4.sp),
        CText(
          value,
          color: appTheme.mediumGrey,
          size: 14.sp,
          weight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
      ],
    );
  }
}
