import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/utils/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/image_constant.dart';
import 'package:homekru_owner/core/utils/logger.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/presentation/member/provider/day_off_eligibility_provider.dart';
import 'package:homekru_owner/presentation/member/widget/circular_progress.dart';
import 'package:homekru_owner/presentation/member/widget/eligibility_widget.dart';
import 'package:homekru_owner/presentation/member/widget/helper_profile_card.dart';
import 'package:homekru_owner/presentation/member/widget/member_info_card.dart';
import 'package:homekru_owner/presentation/member/widget/member_task_card.dart';
import 'package:homekru_owner/presentation/task/widgets/action_task_card.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/dialogs/profile_edit_dialog.dart';
import 'package:provider/provider.dart';

class HelperOverviewScreen extends StatelessWidget {
  HelperOverviewScreen({super.key});
  final ActionTask myTask = ActionTask(
    initials: "MJ",
    title: "Kitchen Cleaning",
    subtitle: "Rina uploaded photo Proof",
    time: "Today - 10:15 AM",
    type: "Cleaning Supplies",
    items: "Bathroom cleaner, Mop head",
    urgency: "Standard",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: AppStrings.helperOverview),
      body: Stack(
        children: [
          bottomWaveWidget(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              HelperProfileCard(
                imageUrl: ImageConstant.profile,
                // "https://i.pinimg.com/736x/bf/50/e2/bf50e22082af5810b2976308c721ee5b.jpg",
                name: "James Miller",
                role: "Maid Non live-in",
                score: "95%",
                statusText: AppStrings.checkedIn,
                onEdit: () => showEditDialog(context),
                onStatusTap: () {
                  // handle status click
                },
              ),
              vGap(14.h),
              PunctualityCard(percentage: 0.85, title: 'Performance'),
              vGap(14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                    icon: Icons.list_alt,
                    iconBgColor: appTheme.lightBlue,
                    value: "8/9",
                    label: "Tasks",
                  ),
                  InfoCard(
                    icon: Icons.access_time,
                    iconBgColor: appTheme.lightBlue,
                    value: "40H",
                    label: "Hours",
                  ),
                  InfoCard(
                    icon: Icons.check_circle,
                    iconBgColor: appTheme.lightBlue,
                    value: "30",
                    label: "Completion",
                  ),
                ],
              ),
              vGap(20.h),
              CText(
                AppStrings.todaysTasks,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              vGap(18.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final tasks = [
                    {
                      "title": "Laundry",
                      "timeRange": "10:00 AM - 3:00 PM",
                      "status": AppStrings.pending,
                      "statusColor": appTheme.amber,
                      "statusBgColor": appTheme.lightYellow,
                      "onRemind": () {
                        print("Remind clicked!");
                      },
                    },
                    {
                      "title": "Clean Kitchen",
                      "timeRange": "10:00 AM - 8:00 PM",
                      "status": AppStrings.done,
                      "statusColor": appTheme.darkGreen,
                      "statusBgColor": appTheme.mintGreen,
                      "onRemind": null,
                    },
                  ];
                  final task = tasks[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: MemberTaskCard(
                      title: task["title"] as String,
                      timeRange: task["timeRange"] as String,
                      status: task["status"] as String,
                      statusColor: task["statusColor"] as Color,
                      statusBgColor: task["statusBgColor"] as Color,
                      onRemind: task["onRemind"] as VoidCallback?,
                    ),
                  );
                },
              ),

              vGap(20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    AppStrings.dayOffEligibility,
                    color: appTheme.textPrimary,
                    size: 18.sp,
                    weight: FontWeight.w500,
                  ),
                  GestureDetector(
                    onTap: () => _showDayOffEligibilityDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 5,
                      ),
                      decoration: ShapeDecoration(
                        color: appTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: CText(
                        AppStrings.edit,
                        textAlign: TextAlign.center,
                        color: appTheme.white,
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              vGap(18.h),
              Consumer<DayOffEligibilityProvider>(
                builder:
                    (context, provider, _) => EligibilityWidget(
                      title: AppStrings.frequency,
                      value: provider.selectedFrequency ?? "Weekly",
                    ),
              ),
              vGap(15.h),
              Consumer<DayOffEligibilityProvider>(
                builder:
                    (context, provider, _) => EligibilityWidget(
                      title: AppStrings.allocatedLeaves,
                      value: provider.allocatedLeaves.toString(),
                    ),
              ),
              vGap(20.h),

              CText(
                AppStrings.resourceRequests,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              vGap(18.h),
              ActionTaskCard(
                task: myTask,
                onApprove: () => Log.d("Approved"),
                onReject: () => Log.d("Rejected"),
                onViewDetails: () => Log.d("Viewing details"),
              ),
              vGap(20.h),

              /// Continue Button
              CustomElevatedButton(
                text: AppStrings.viewAllTasks,
                height: 50.h,
                width: double.infinity,
                isLoading: false,
                onPressed: () {
                  AppNavigator.pushNamed(AppRoutes.memberTasks);
                },
              ),

              SizedBox(height: 20.h),
              CustomElevatedButton(
                text: AppStrings.viewAttendanceLog,
                height: 50.h,
                width: double.infinity,
                isOutline: true,
                isLoading: false,
                onPressed: () {
                  AppNavigator.pushNamed(AppRoutes.attendenceLog);
                },
              ),
              vGap(50.h),
            ],
          ),
        ],
      ),
    );
  }

  void _showDayOffEligibilityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: appTheme.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Consumer<DayOffEligibilityProvider>(
              builder:
                  (context, provider, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 32.w),
                          Expanded(
                            child: CText(
                              "Day Off Eligibility",
                              textAlign: TextAlign.center,
                              size: 18.sp,
                              weight: FontWeight.bold,
                              color: appTheme.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: CircleAvatar(
                              radius: 16.r,
                              backgroundColor: appTheme.lightBlueTwo,
                              child: Icon(
                                Icons.close,
                                color: appTheme.primaryColor,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Frequency Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Frequency",
                            size: 16.sp,
                            weight: FontWeight.w500,
                            color: appTheme.textPrimary,
                          ),
                          SizedBox(height: 8.h),
                          CustomDropdownWidget(
                            borderColor: appTheme.offWhite,
                            items: provider.frequencyOptions,
                            hintText: "Select Frequency",
                            selectedValue: provider.selectedFrequency,
                            onChanged: (value) {
                              if (value != null) {
                                provider.updateFrequency(value);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Allocated Leaves Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Allocated Leaves",
                            size: 16.sp,
                            weight: FontWeight.w500,
                            color: appTheme.textPrimary,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              // Remove button
                              GestureDetector(
                                onTap: provider.decrementLeaves,
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.lightPink.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: appTheme.lightPink,
                                      width: 1.w,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: appTheme.darkRed,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),

                              // Value display
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.lightBlue,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: CText(
                                  provider.allocatedLeaves.toString(),
                                  size: 18.sp,
                                  color: appTheme.primaryColor,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 16.w),

                              // Add button
                              GestureDetector(
                                onTap: provider.incrementLeaves,
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.mintGreen.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: appTheme.mintGreen,
                                      width: 1.w,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: appTheme.darkGreen,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 6.w),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                  side: WidgetStateProperty.all(
                                    BorderSide(color: appTheme.primaryColor),
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: CText(
                                    "Cancel",
                                    size: 14.sp,
                                    color: appTheme.primaryColor,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    appTheme.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: CText(
                                        'Day off eligibility updated successfully!',
                                        color: Colors.white,
                                      ),
                                      backgroundColor: appTheme.primaryColor,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: CText(
                                    "Save",
                                    color: appTheme.white,
                                    size: 14.sp,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ),
          ),
        );
      },
    );
  }
}

class PunctualityCard extends StatelessWidget {
  final double percentage;
  final String title;

  const PunctualityCard({
    super.key,
    this.percentage = 0.85,
    this.title = AppStrings.punctuality,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: appTheme.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: appTheme.primaryColor.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: [
          BoxShadow(
            color: appTheme.shadowColor,
            blurRadius: 50,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Transform.flip(
                flipY: true,
                child: CustomImageView(
                  imagePath: ImageConstant.maskGroup,
                  width: SizeUtils.width * 0.55,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            child: Row(
              children: [
                // Profile Image
                CircularProgress(
                  scoreValue: percentage,
                  animationDuration: const Duration(milliseconds: 2000),
                  strokeWidth: 8.0,
                  label: AppStrings.score,
                ),
                hGap(12),
                // Info section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "85%",
                        color: appTheme.primaryColor,
                        size: 30.sp,
                        weight: FontWeight.w600,
                      ),
                      vGap(3),
                      CText(
                        AppStrings.punctuality,
                        color: appTheme.grey,
                        size: 18.sp,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
