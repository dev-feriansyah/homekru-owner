import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/features/member/ui/widgets/member_task_card.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/sort_by_filter_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class MemberTasksScreen extends StatelessWidget {
  const MemberTasksScreen({super.key});

  List<Map<String, dynamic>> _getTasks(BuildContext context) {
    final appColors = context.appColorExtension;

    return [
      {
        "title": "Laundry",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Pending",
        "statusColor": Colors.amber,
        "statusBgColor": appColors.lightYellow,
      },
      {
        "title": "Kitchen Cleaning",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Done",
        "statusColor": appColors.darkGreen,
        "statusBgColor": appColors.mintGreen,
      },
      {
        "title": "Laundry",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Pending",
        "statusColor": Colors.amber,
        "statusBgColor": appColors.lightYellow,
      },
      {
        "title": "Kitchen Cleaning",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Done",
        "statusColor": appColors.darkGreen,
        "statusBgColor": appColors.mintGreen,
      },
      {
        "title": "Laundry",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Pending",
        "statusColor": Colors.amber,
        "statusBgColor": appColors.lightYellow,
      },
      {
        "title": "Kitchen Cleaning",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Done",
        "statusColor": appColors.darkGreen,
        "statusBgColor": appColors.mintGreen,
      },
      {
        "title": "Laundry",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Pending",
        "statusColor": Colors.amber,
        "statusBgColor": appColors.lightYellow,
      },
      {
        "title": "Kitchen Cleaning",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Done",
        "statusColor": appColors.darkGreen,
        "statusBgColor": appColors.mintGreen,
      },
      {
        "title": "Laundry",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Pending",
        "statusColor": Colors.amber,
        "statusBgColor": appColors.lightYellow,
      },
      {
        "title": "Kitchen Cleaning",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Done",
        "statusColor": appColors.darkGreen,
        "statusBgColor": appColors.mintGreen,
      },
      {
        "title": "Laundry",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Pending",
        "statusColor": Colors.amber,
        "statusBgColor": appColors.lightYellow,
      },
      {
        "title": "Kitchen Cleaning",
        "timeRange": "10:00 AM - 3:00 PM",
        "status": "Done",
        "statusColor": appColors.darkGreen,
        "statusBgColor": appColors.mintGreen,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tasks = _getTasks(context);

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
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
                      color: colorScheme.onSurface,
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
                          color: colorScheme.surface.withValues(alpha: 0.10),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: colorScheme.primary.withValues(alpha: 0.5),
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
                              color: colorScheme.primary,
                              size: 14.sp,
                            ),
                            CText(
                              AppStrings.filter,
                              textAlign: TextAlign.center,
                              size: 14.sp,
                              weight: FontWeight.w500,
                              color: colorScheme.primary,
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
