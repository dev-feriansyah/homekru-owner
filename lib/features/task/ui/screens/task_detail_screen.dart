import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/features/task/ui/widgets/actiton_card.dart';
import 'package:homekru_owner/features/task/ui/widgets/task_detail_card.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_home_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // Mock data - in real app this would come from API/provider
  final bool isTaskCompleted = true; // Set to true to show approval CTAs
  final bool hasTaskProof = true; // Set to true if task requires image proof

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF3F9),
      appBar: CustomAppBar(title: "Clean Kitchen"),
      body: Stack(
        children: [
          bottomWaveWidget(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              vGap(20),

              CText(
                AppStrings.taskDetail,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              vGap(15),
              TaskDetailCard(
                assignedTo: "James Miller",
                assignedInitials: "KC",
                roomZone: "Kitchen",
                description:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                subTask: "Bedroom, Drawing room",
                frequency: "Daily",
                time: "10:00 AM",
                duration: "30 mins",
              ),

              vGap(20),

              CText(
                AppStrings.action,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              vGap(15),

              const ActitonCard(
                resourceType: "Cleaning Supplies",
                specificItems: "Bathroom cleaner , Glass cleaner",
                urgency: "Standard",
              ),
              vGap(20),

              // Task Approval CTAs for completed tasks
              if (isTaskCompleted && hasTaskProof) _buildTaskApprovalSection(),

              vGap(20),
            ],
          ),
        ],
      ),
    );
  }

  // Task Approval Section for Completed Tasks
  Widget _buildTaskApprovalSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: appTheme.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Task Completion Approval",
            color: appTheme.textPrimary,
            size: 16.sp,
            weight: FontWeight.w600,
          ),
          SizedBox(height: 8.h),
          CText(
            "This task has been completed and requires your approval.",
            color: appTheme.textSecondary,
            size: 14.sp,
          ),
          SizedBox(height: 16.h),

          // Task Proof Image Section
          _buildTaskProofImage(),

          vGap(18),

          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: AppStrings.approve,
                  onPressed: _approveTaskCompletion,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomElevatedButton(
                    text: AppStrings.reject,
                    onPressed: _rejectTaskCompletion,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Approve Task Completion
  void _approveTaskCompletion() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: CText(
              "Approve Task",
              color: appTheme.textPrimary,
              size: 18.sp,
              weight: FontWeight.w600,
            ),
            content: CText(
              "Are you sure you want to approve this task completion?",
              color: appTheme.textSecondary,
              size: 14.sp,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: CText(
                  "Cancel",
                  color: appTheme.textSecondary,
                  size: 14.sp,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task completion approved successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: CText(
                  "Approve",
                  color: Colors.green,
                  size: 14.sp,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
    );
  }

  // Reject Task Completion
  void _rejectTaskCompletion() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: CText(
              "Reject Task",
              color: appTheme.textPrimary,
              size: 18.sp,
              weight: FontWeight.w600,
            ),
            content: CText(
              "Are you sure you want to reject this task completion?",
              color: appTheme.textSecondary,
              size: 14.sp,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: CText(
                  "Cancel",
                  color: appTheme.textSecondary,
                  size: 14.sp,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task completion rejected."),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                child: CText(
                  "Reject",
                  color: Colors.red,
                  size: 14.sp,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
    );
  }

  // Task Proof Image Section
  Widget _buildTaskProofImage() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: appTheme.grey.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: appTheme.lightBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.image, color: appTheme.primaryColor, size: 20.sp),
                SizedBox(width: 8.w),
                CText(
                  "Task Proof Image",
                  color: appTheme.textPrimary,
                  size: 14.sp,
                  weight: FontWeight.w600,
                ),
                Spacer(),
                CText(
                  "Tap to view full size",
                  color: appTheme.textSecondary,
                  size: 12.sp,
                ),
              ],
            ),
          ),

          // Image Display
          GestureDetector(
            onTap: _showFullSizeImage,
            child: Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
                child: CustomImageView(
                  imagePath:
                      ImageConstant
                          .cleanKitchen, // Mock image - replace with actual task proof
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show Full Size Image Dialog
  void _showFullSizeImage() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                // Full screen image
                Center(
                  child: Container(
                    width: 1.sw * 0.9,
                    height: 1.sh * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CustomImageView(
                        imagePath: ImageConstant.cleanKitchen,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Close button
                Positioned(
                  top: 50.h,
                  right: 20.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
