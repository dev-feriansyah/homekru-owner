import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class ActionItem extends StatelessWidget {
  final String label;
  final String value;

  const ActionItem({super.key, required this.label, required this.value});

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
        vGap(4),
        CText(
          value,
          color: appTheme.grey,
          size: 14.sp,
          weight: FontWeight.w400,
        ),
      ],
    );
  }
}
