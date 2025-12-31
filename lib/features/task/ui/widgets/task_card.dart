import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/features/task/ui/widgets/status_chip.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String assignedTo;
  final String time;
  final String status;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.sp),
      width: SizeUtils.width,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0x333B70B9), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0x143B70B9),
            blurRadius: 50.r,
            offset: Offset(10.w, 20.sp),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left side → title + description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: SizeUtils.width * 0.5,
                child: CText(
                  title,
                  color: appTheme.textPrimary,
                  size: 14.sp,
                  weight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: SizeUtils.width * 0.5,
                child: CText(
                  description,
                  color: appTheme.grey,
                  size: 14.sp,
                  weight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),

          SizedBox(width: 8.w),

          /// Right side → assignedTo + time + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CText(
                assignedTo,
                color: appTheme.textSecondary,
                size: 12.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 5.sp),
              CText(
                time,
                color: appTheme.primaryColor,
                size: 12.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 8.sp),
              StatusChip(status),
            ],
          ),
        ],
      ),
    );
  }
}
