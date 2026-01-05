import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class EligibilityWidget extends StatelessWidget {
  final String title;
  final String value;
  const EligibilityWidget({
    super.key,
    required this.title,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorScheme.surfaceContainerHighest, width: 1),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 50,
            offset: Offset(10, 20),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CText(
            title,
            color: colorScheme.onSurface.withValues(alpha: 0.8),
            size: 16.sp,
            weight: FontWeight.w600,
          ),
          CText(
            value,
            textAlign: TextAlign.right,
            color: appColors.grey.withValues(alpha: 0.8),
            size: 16.sp,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
