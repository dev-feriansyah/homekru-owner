import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/utils/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/date_time_utils.dart';
import 'package:homekru_owner/presentation/settings/settings_screen.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_assign_dropdown.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/presentation/task/provider/task_management_provider.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart';
import 'package:homekru_owner/shared/widgets/task_dropdown.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class CreateFromScratchScreen extends StatefulWidget {
  final TaskManagementProvider provider;

  const CreateFromScratchScreen({super.key, required this.provider});

  @override
  State<CreateFromScratchScreen> createState() =>
      _CreateFromScratchScreenState();
}

final TextEditingController startTimeController = TextEditingController();

class _CreateFromScratchScreenState extends State<CreateFromScratchScreen> {
  String? selectedRoom;
  String? customRoom;
  bool showCustomRoomField = false;
  final TextEditingController customRoomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bottomWaveWidget(),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   child: CustomImageView(
        //     imagePath: ImageConstant.backgroundImage2,
        //     height: 200,
        //   ),
        // ),
        SingleChildScrollView(
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
        ),
      ],
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
        vGap(16.h),

        CustomAssignDropdown(
          borderColor: appTheme.offWhite,
          items: provider.assignees,
          hintText: "Select Assignee",
          selectedValue: provider.currentAssignee,

          onChanged: (value) {
            if (value != null) {
              provider.updateAssignee(value);
            }
          },
        ),
        vGap(24.h),
        CText(
          'Assigned For',
          size: 18.sp,
          weight: FontWeight.w600,
          color: appTheme.textPrimary,
        ),
        vGap(16.h),

        CustomDropdownWidget(
          borderColor: appTheme.offWhite,
          items: [
            "Bedroom 1",
            "Bedroom 2",
            "Kitchen",
            "Guest Bathroom 1",
            "Guest Bathroom 2",
            "Living Room",
            "Dining Room",
            "Custom Room",
          ],
          hintText: "Select room/zone",
          selectedValue: selectedRoom,
          onChanged: (value) {
            setState(() {
              selectedRoom = value;
              if (value == "Custom Room") {
                showCustomRoomField = true;
              } else {
                showCustomRoomField = false;
                customRoomController.clear();
              }
            });
          },
        ),

        // Custom Room Field
        if (showCustomRoomField) ...[
          SizedBox(height: 16.h),
          buildTextField(
            "Enter custom room name",
            customRoomController,
            validator: (value) {
              if (showCustomRoomField &&
                  (value == null || value.trim().isEmpty)) {
                return 'Please enter custom room name';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: 1,
          ),
        ],
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
          weight: FontWeight.w600,
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
          'Sub Tasks',
          size: 18.sp,
          weight: FontWeight.w600,
          color: appTheme.textPrimary,
        ),
        vGap(16.h),

        // Default 3 sub-task fields
        ...List.generate(provider.subTaskControllers.length, (index) {
          return Column(
            children: [
              buildTextField(
                "Sub Task ${index + 1}",
                provider.subTaskControllers[index],
                validator: null, // Sub tasks are optional
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 1,
              ),
              if (index < provider.subTaskControllers.length - 1) vGap(12.h),
            ],
          );
        }),

        vGap(16.h),

        // Add More Sub Tasks Button
        GestureDetector(
          onTap: () => _addSubTask(provider),
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
                  'Add More Sub Tasks',
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
          initialValue: provider.requirePhoto,
          onChanged: (val) {
            provider.setRequirePhoto(val);
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
          hintText: AppStrings.time,
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
          onTap: () => _assignTask(provider),
          child: Container(
            height: 50.h,
            width: double.infinity,
            // padding: EdgeInsets.symmetric(vertical: 12.h),
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
        vGap(16.h),
        GestureDetector(
          onTap: () => _addMoreTask(provider),
          child: Container(
            height: 50.h,
            width: double.infinity,
            // padding: EdgeInsets.symmetric(vertical: 12.h),
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
      ],
    );
  }

  // Helper Methods

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

  void _addSubTask(TaskManagementProvider provider) {
    provider.addSubTaskController();
    setState(() {}); // Refresh UI to show new field
  }

  void _assignTask(TaskManagementProvider provider) async {
    // Check if all required fields are filled
    bool isValid = true;
    String errorMessage = '';

    // Check task name
    if (provider.taskNameController.text.trim().isEmpty) {
      isValid = false;
      errorMessage = 'Please enter task name';
    }
    // Check task description
    else if (provider.taskDescriptionController.text.trim().isEmpty) {
      isValid = false;
      errorMessage = 'Please enter task description';
    }
    // Check assignee
    else if (provider.currentAssignee.isEmpty) {
      isValid = false;
      errorMessage = 'Please select an assignee';
    }
    // Check room selection
    else if (selectedRoom == null) {
      isValid = false;
      errorMessage = 'Please select a room';
    }
    // Check custom room if selected
    else if (selectedRoom == "Custom Room" &&
        customRoomController.text.trim().isEmpty) {
      isValid = false;
      errorMessage = 'Please enter custom room name';
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CText(errorMessage, color: Colors.white),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create task
    await provider.createTask();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CText('Task assigned successfully!', color: Colors.white),
        backgroundColor: appTheme.blueAccentCustom,
      ),
    );

    // Navigate to task list screen
    AppNavigator.pushNamed('/task-screen');
  }
}
