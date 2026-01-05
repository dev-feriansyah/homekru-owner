import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class MemberTaskCard extends StatelessWidget {
  final String title;
  final String timeRange;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final VoidCallback? onRemind;

  const MemberTaskCard({
    super.key,
    required this.title,
    required this.timeRange,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    this.onRemind,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.h),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: colorScheme.surfaceContainerHighest),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 50,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                title,
                color: colorScheme.onSurface,
                size: 16.sp,
                weight: FontWeight.w600,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: ShapeDecoration(
                  color: statusBgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: CText(
                  status,
                  textAlign: TextAlign.center,
                  color: statusColor,
                  size: 14.sp,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          vGap(6.h),

          // Time
          CText(
            timeRange,
            color: appColors.grey,
            size: 16.sp,
            weight: FontWeight.w500,
          ),
          vGap(4.h),

          // Remind action
          if (onRemind != null)
            GestureDetector(
              onTap: onRemind,
              child: CText(
                'Remind >',
                color: colorScheme.primary,
                size: 14.sp,
                weight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
