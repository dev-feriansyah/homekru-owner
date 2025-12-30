import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class AttendenceLogScreen extends StatelessWidget {
  const AttendenceLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: AppStrings.attendanceTime),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CText(
              'Maria Johnson',
              color: appTheme.textPrimary,
              size: 18.sp,
              weight: FontWeight.w600,
              height: 1.56,
            ),
          ),
          vGap(10.h),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: AttendenceLogWidget(),
                );
              },
            ),
          ),

          vGap(20.h),
        ],
      ),
    );
  }
}

class AttendenceLogWidget extends StatelessWidget {
  const AttendenceLogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtils.width,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: appTheme.primaryColor.withValues(alpha: 0.2),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with date badge
          vGap(15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      'Check-in: 8:15 AM',
                      color: appTheme.grey,
                      size: 14.sp,
                      weight: FontWeight.w500,
                      height: 1.29,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3ECF7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CText(
                        "12/03/2025",
                        color: appTheme.primaryColor,
                        size: 12.sp,
                        weight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                vGap(5.h),
                // Expected check-out
                CText(
                  'Expected check-out: 5:00 PM',
                  color: appTheme.grey,
                  size: 14.sp,
                  weight: FontWeight.w500,
                  height: 1.29,
                ),
              ],
            ),
          ), // Bottom grey strip with address
          vGap(15.h),
          Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffBDBDBD).withValues(alpha: 0.2), // 10% opacity
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20.sp, color: appTheme.grey),
                hGap(10.w),
                CText(
                  '123 Main St (within geo-fence)',
                  color: appTheme.grey,
                  size: 14.sp,
                  weight: FontWeight.w400,
                  height: 1.29,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
