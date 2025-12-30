import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/features/member/ui/widgets/member_task_card.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/sort_by_filter_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class MemberTasksScreen extends StatelessWidget {
  MemberTasksScreen({super.key});
  final tasks = [
    {
      "title": "Laundry",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Pending",
      "statusColor": Colors.amber,
      "statusBgColor": appTheme.lightYellow,
    },
    {
      "title": "Kitchen Cleaning",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Done",
      "statusColor": appTheme.darkGreen,
      "statusBgColor": appTheme.mintGreen,
    },
    {
      "title": "Laundry",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Pending",
      "statusColor": Colors.amber,
      "statusBgColor": appTheme.lightYellow,
    },
    {
      "title": "Kitchen Cleaning",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Done",
      "statusColor": appTheme.darkGreen,
      "statusBgColor": appTheme.mintGreen,
    },
    {
      "title": "Laundry",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Pending",
      "statusColor": Colors.amber,
      "statusBgColor": appTheme.lightYellow,
    },
    {
      "title": "Kitchen Cleaning",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Done",
      "statusColor": appTheme.darkGreen,
      "statusBgColor": appTheme.mintGreen,
    },
    {
      "title": "Laundry",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Pending",
      "statusColor": Colors.amber,
      "statusBgColor": appTheme.lightYellow,
    },
    {
      "title": "Kitchen Cleaning",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Done",
      "statusColor": appTheme.darkGreen,
      "statusBgColor": appTheme.mintGreen,
    },
    {
      "title": "Laundry",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Pending",
      "statusColor": Colors.amber,
      "statusBgColor": appTheme.lightYellow,
    },
    {
      "title": "Kitchen Cleaning",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Done",
      "statusColor": appTheme.darkGreen,
      "statusBgColor": appTheme.mintGreen,
    },
    {
      "title": "Laundry",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Pending",
      "statusColor": Colors.amber,
      "statusBgColor": appTheme.lightYellow,
    },
    {
      "title": "Kitchen Cleaning",
      "timeRange": "10:00 AM - 3:00 PM",
      "status": "Done",
      "statusColor": appTheme.darkGreen,
      "statusBgColor": appTheme.mintGreen,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: AppStrings.memberTasks),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            bottomWaveWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CText(
                      AppStrings.allTasks,
                      size: 18.sp,
                      weight: FontWeight.w600,
                      color: appTheme.textPrimary,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showSortByFilterBottomSheet(context);
                      },
                      child: Container(
                        width: 80.w,
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        decoration: ShapeDecoration(
                          color: appTheme.white.withValues(alpha: 0.10),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: appTheme.primaryColor.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(9.r),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10.w,
                          children: [
                            Icon(
                              Icons.filter_list,
                              color: appTheme.primaryColor,
                              size: 14.sp,
                            ),
                            CText(
                              AppStrings.filter,
                              textAlign: TextAlign.center,
                              size: 14.sp,
                              weight: FontWeight.w500,
                              color: appTheme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                vGap(18.h),

                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AppNavigator.pushNamed(AppRoutes.action);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: MemberTaskCard(
                            title: tasks[index]["title"] as String,
                            timeRange: tasks[index]["timeRange"] as String,
                            status: tasks[index]["status"] as String,
                            statusColor: tasks[index]["statusColor"] as Color,
                            statusBgColor:
                                tasks[index]["statusBgColor"] as Color,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
