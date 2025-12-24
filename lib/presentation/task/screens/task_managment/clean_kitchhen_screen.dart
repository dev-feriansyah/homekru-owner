import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/date_time_utils.dart';
import 'package:homekru_owner/core/utils/logger.dart';
import 'package:homekru_owner/presentation/settings/settings_screen.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/presentation/task/provider/task_management_provider.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart';
import 'package:homekru_owner/shared/widgets/task_dropdown.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class CleanKitchenScreen extends StatefulWidget {
  final TaskManagementProvider provider;

  const CleanKitchenScreen({super.key, required this.provider});

  @override
  State<CleanKitchenScreen> createState() => _CleanKitchenScreenState();
}

final TextEditingController startTimeController = TextEditingController();

class _CleanKitchenScreenState extends State<CleanKitchenScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAssignToSection(widget.provider),
          vGap(24.h),
          _buildTaskDetailsSection(widget.provider),
          vGap(24.h),
          _buildSubTaskSection(widget.provider),
          vGap(24.h),
          _buildRequirePhotoSection(widget.provider),
          vGap(5.h),
          _buildRecurrenceSettingsSection(widget.provider),
          vGap(32.h),
          _buildActionButtons(widget.provider),
          vGap(32.h),
        ],
      ),
    );
  }

  Widget _buildAssignToSection(TaskManagementProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          'Assign To',
          size: 18.sp,
          weight: FontWeight.w600,
          color: appTheme.textPrimary,
        ),
        vGap(8.h),

        // Consumer<TaskManagementProvider>(
        //   builder:
        //       (context, provider, _) => TaskDropdown(
        //         hintText: "Select Assignee",
        //         selectedTask: provider.selectedAssignee,
        //         tasks: provider.assignees,
        //         onChanged: (value) => provider.updateAssignee(value!),
        //       ),
        // ),
        GestureDetector(
          onTap: () => _showAssigneeBottomSheet(provider),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: ShapeDecoration(
              color: appTheme.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0, color: appTheme.white),
                borderRadius: BorderRadius.circular(15),
              ),

              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                // BoxShadow(
                //   color: appTheme.shadowColor,
                //   blurRadius: 50,
                //   offset: const Offset(10, 20),
                //   spreadRadius: 0,
                // ),
              ],
            ),

            // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(15.r),
            //   border: Border.all(color: Colors.grey[300]!),
            // ),
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: appTheme.blueAccentCustom.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CText(
                      'KC',
                      size: 16.sp,
                      weight: FontWeight.w600,
                      color: appTheme.blueAccentCustom,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CText(
                    provider.currentAssignee,
                    size: 16.sp,
                    weight: FontWeight.w500,
                    color: appTheme.textPrimary,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: appTheme.grey,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDetailsSection(TaskManagementProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          'Tasks Details',
          size: 18.sp,
          weight: FontWeight.w500,
          color: appTheme.textPrimary,
        ),
        vGap(16.h),
        buildTextField(
          "Enter Task Name",
          provider.taskNameController,
          validator:
              (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Please enter task name'
                      : null,
          keyboardType: TextInputType.text,
          minLines: 1,
          maxLines: 1,
        ),
        vGap(14.h),

        Consumer<TaskManagementProvider>(
          builder:
              (context, provider, _) => TaskDropdown(
                hintText: "Select Assignee",
                selectedTask: provider.selectedAssignee,
                tasks: provider.assignees,
                onChanged: (value) => provider.updateAssignee(value!),
              ),
        ),

        vGap(14.h),
        buildTextField(
          "Add Task Description",
          provider.taskDescriptionController,
          validator:
              (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Please enter task description'
                      : null,
          keyboardType: TextInputType.text,
          minLines: 5,
          // maxLines: 1,
        ),

        // _buildTextAreaField(
        //   controller: provider.taskDescriptionController,
        //   hintText: 'Add Task description',
        // ),
      ],
    );
  }

  Widget _buildSubTaskSection(TaskManagementProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          'Sub Task',
          size: 18.sp,
          weight: FontWeight.w600,
          color: appTheme.textPrimary,
        ),
        vGap(5.h),
        CText(
          'Recommended preferences',
          size: 16.sp,
          weight: FontWeight.w400,
          color: appTheme.grey,
        ),
        vGap(12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children:
              provider.availablePrefs.map((preference) {
                final isSelected = provider.selectedPrefs.contains(preference);
                return GestureDetector(
                  onTap: () => provider.togglePreference(preference),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? appTheme.blueAccentCustom
                              : appTheme.offWhite,
                      borderRadius: BorderRadius.circular(9.r),
                      border: Border.all(
                        color:
                            isSelected
                                ? appTheme.blueAccentCustom
                                : appTheme.blueAccentCustom,
                        width: 1.0,
                      ),
                    ),
                    child: CText(
                      preference,
                      size: 16.sp,
                      color:
                          isSelected
                              ? appTheme.white
                              : appTheme.blueAccentCustom,
                      weight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
        ),
        vGap(22.h),
        GestureDetector(
          onTap: () => _showSubTasksModal(provider),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              color: appTheme.blueAccentCustom,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 20.sp),
                hGap(5.w),
                CText(
                  'Preference',
                  size: 18.sp,
                  weight: FontWeight.w600,
                  color: appTheme.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirePhotoSection(TaskManagementProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CText(
          'Require Photo',
          size: 18.sp,
          weight: FontWeight.w600,
          color: appTheme.textPrimary,
        ),
        hGap(5.w),
        Spacer(),
        CustomToggleSwitch(
          initialValue: true,
          onChanged: (val) {
            Log.d(val);
          },
        ),
        hGap(5.w),
      ],
    );
  }

  Widget _buildRecurrenceSettingsSection(TaskManagementProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          'Recurrence Settings',
          size: 16.sp,
          weight: FontWeight.w400,
          color: appTheme.grey,
        ),
        vGap(16.h),

        Consumer<TaskManagementProvider>(
          builder:
              (context, provider, _) => TaskDropdown(
                hintText: "Select Frequency",
                selectedTask: provider.selectedTime,
                tasks: provider.frequencyOptions,
                onChanged: (value) => provider.updateFrequency(value!),
              ),
        ),

        vGap(16.h),

        CustomTextFormField(
          hintText: AppStrings.startTime,
          controller: startTimeController,
          keyboardType: TextInputType.phone,
          readOnly: true,
          onTap: () async {
            TimeOfDay? pickedTime = await showCustomTimePicker(context);
            if (pickedTime != null) {
              startTimeController.text = DateTimeUtil.formatTime12Hour(
                pickedTime.toString(),
              );
            }
          },
          suffixIcon: Icon(Icons.access_time, color: appTheme.grey),
        ),
        vGap(16.h),
        Consumer<TaskManagementProvider>(
          builder:
              (context, provider, _) => TaskDropdown(
                hintText: "Select Duration",
                selectedTask: provider.selectedDuration,
                tasks: provider.durationOptions,
                onChanged: (value) => provider.updateDuration(value!),
              ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(TaskManagementProvider provider) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _addMoreTask(provider),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              color: appTheme.blueAccentCustom,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 20.sp),
                hGap(5.w),
                CText(
                  'Add More Task',
                  size: 18.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        vGap(16.h),
        GestureDetector(
          onTap: () => _assignTask(provider),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: appTheme.blueAccentCustom),
            ),
            child: Center(
              child: CText(
                'Assign Task',
                size: 18.sp,
                weight: FontWeight.w600,
                color: appTheme.blueAccentCustom,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper Methods
  void _showAssigneeBottomSheet(TaskManagementProvider provider) {
    // final assignees = [
    //   'James Miller',
    //   'Sarah Johnson',
    //   'John Doe',
    //   'Jane Smith',
    // ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                vGap(20.h),
                CText(
                  'Select Assignee',
                  size: 18.sp,
                  weight: FontWeight.w600,
                  color: appTheme.textPrimary,
                ),
                vGap(20.h),
                ...provider.assignees
                    .map(
                      (assignee) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: appTheme.blueAccentCustom
                              .withOpacity(0.2),
                          child: CText(
                            assignee.split(' ').map((e) => e[0]).join(),
                            size: 16.sp,
                            weight: FontWeight.w600,
                            color: appTheme.blueAccentCustom,
                          ),
                        ),
                        title: CText(
                          assignee,
                          size: 18.sp,
                          weight: FontWeight.w500,
                          color: appTheme.textPrimary,
                        ),
                        onTap: () {
                          provider.updateAssignee(assignee);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
    );
  }

  void _showSubTasksModal(TaskManagementProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                vGap(20.h),
                CText(
                  'Sub Tasks',
                  size: 20.sp,
                  weight: FontWeight.w600,
                  color: appTheme.textPrimary,
                ),
                vGap(20.h),
                _buildInputField(
                  controller: TextEditingController(
                    text: provider.subTaskInput,
                  ),
                  hintText: 'Enter your floor',
                  onChanged: (value) => provider.updateSubTaskInput(value),
                ),
                vGap(20.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: appTheme.blueAccentCustom,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                        CText(
                          'Add',
                          size: 18.sp,
                          weight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                vGap(20.h),
              ],
            ),
          ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    Function(String)? onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (suffixIcon != null) ...[
            SizedBox(width: 8.w),
            Icon(suffixIcon, color: Colors.grey[600], size: 20.sp),
          ],
        ],
      ),
    );
  }

  void _addMoreTask(TaskManagementProvider provider) {
    provider.clearForm();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CText(
          'Form cleared. Ready to add another task!',
          color: Colors.white,
        ),
        backgroundColor: appTheme.blueAccentCustom,
      ),
    );
  }

  void _assignTask(TaskManagementProvider provider) async {
    if (!provider.isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CText(
            'Please fill in all required fields',
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await provider.createTask();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CText('Task assigned successfully!', color: Colors.white),
        backgroundColor: appTheme.blueAccentCustom,
      ),
    );
    AppNavigator.pop();
  }
}
