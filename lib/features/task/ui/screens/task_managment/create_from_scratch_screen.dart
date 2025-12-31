import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/domain/value_objects/frequency_options.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/shared/utils/date_time_utils.dart';
import 'package:homekru_owner/features/settings/settings_screen.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_assign_dropdown.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart';
import 'package:homekru_owner/shared/widgets/task_dropdown.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';

List<String> assignees = ['James Miller', 'John Doe', 'Jane Smith'];
List<Map<String, dynamic>> suggestedTasks = [
  {'title': 'Clean Kitchen', 'isSelected': true, 'requirePhoto': false},
];

class CreateFromScratchScreen extends HookWidget {
  const CreateFromScratchScreen({super.key});
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
              _buildAssignToSection(),
              vGap(24.h),
              _buildTaskDetailsSection(),
              vGap(24.h),
              _buildSubTaskSection(),
              vGap(24.h),
              _buildRequirePhotoSection(),
              vGap(5.h),
              _buildRecurrenceSettingsSection(context),
              vGap(32.h),
              _buildActionButtons(context),
              vGap(32.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssignToSection() {
    final currentAssignee = useState<String?>('James Miller');
    final selectedRoom = useState<String>('Kitchen');
    final showCustomRoomField = useState<bool>(false);
    final TextEditingController customRoomController =
        useTextEditingController();

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
          items: assignees,
          hintText: "Select Assignee",
          selectedValue: currentAssignee.value,
          onChanged: (value) {
            if (value != null) {
              currentAssignee.value = value;
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
          selectedValue: selectedRoom.value,
          onChanged: (value) {
            selectedRoom.value = value ?? "";

            if (value == "Custom Room") {
              showCustomRoomField.value = true;
            } else {
              showCustomRoomField.value = false;
              customRoomController.clear();
            }
          },
        ),

        // Custom Room Field
        if (showCustomRoomField.value) ...[
          SizedBox(height: 16.h),
          buildTextField(
            "Enter custom room name",
            customRoomController,
            validator: (value) {
              if (showCustomRoomField.value &&
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

  Widget _buildTaskDetailsSection() {
    final TextEditingController taskNameController = useTextEditingController();
    final TextEditingController taskDescriptionController =
        useTextEditingController();

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
          taskNameController,
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
          taskDescriptionController,
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

  Widget _buildSubTaskSection() {
    final List<TextEditingController> subTaskControllers = [
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
    ];

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
        ...List.generate(subTaskControllers.length, (index) {
          return Column(
            children: [
              buildTextField(
                "Sub Task ${index + 1}",
                subTaskControllers[index],
                validator: null, // Sub tasks are optional
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 1,
              ),
              if (index < subTaskControllers.length - 1) vGap(12.h),
            ],
          );
        }),

        vGap(16.h),

        // Add More Sub Tasks Button
        GestureDetector(
          onTap: () => {subTaskControllers.add(TextEditingController())},
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

  Widget _buildRequirePhotoSection() {
    final requirePhoto = useState<bool>(false);
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
          initialValue: requirePhoto.value,
          onChanged: (val) {
            requirePhoto.value = val;
          },
        ),
        hGap(5.w),
      ],
    );
  }

  Widget _buildRecurrenceSettingsSection(BuildContext context) {
    final TextEditingController startTimeController =
        useTextEditingController();
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

        TaskDropdown(
          hintText: "Select Frequency",
          selectedTask: null,
          tasks: FrequencyOptions.values.map((e) => e.label).toList(),
          onChanged: (value) => {},
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
        TaskDropdown(
          hintText: "Select Duration",
          selectedTask: null,
          tasks: ['1 hour', '2 hours', '3 hours', '4 hours'],
          onChanged: (value) => {},
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap:
              () => {
                // maybe need refactor
                // _assignTask()
              },
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
          onTap: () => _addMoreTask(context),
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

  void _addMoreTask(BuildContext context) {
    // provider.clearForm();
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

  // void _assignTask() async {
  //   // Check if all required fields are filled
  //   bool isValid = true;
  //   String errorMessage = '';

  //   // Check task name
  //   if (provider.taskNameController.text.trim().isEmpty) {
  //     isValid = false;
  //     errorMessage = 'Please enter task name';
  //   }
  //   // Check task description
  //   else if (provider.taskDescriptionController.text.trim().isEmpty) {
  //     isValid = false;
  //     errorMessage = 'Please enter task description';
  //   }
  //   // Check assignee
  //   else if (provider.currentAssignee.isEmpty) {
  //     isValid = false;
  //     errorMessage = 'Please select an assignee';
  //   }
  //   // Check room selection
  //   else if (selectedRoom == null) {
  //     isValid = false;
  //     errorMessage = 'Please select a room';
  //   }
  //   // Check custom room if selected
  //   else if (selectedRoom == "Custom Room" &&
  //       customRoomController.text.trim().isEmpty) {
  //     isValid = false;
  //     errorMessage = 'Please enter custom room name';
  //   }

  //   if (!isValid) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: CText(errorMessage, color: Colors.white),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Create task
  //   await provider.createTask();

  //   // Show success message
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: CText('Task assigned successfully!', color: Colors.white),
  //       backgroundColor: appTheme.blueAccentCustom,
  //     ),
  //   );

  //   // Navigate to task list screen
  //   AppNavigator.pushNamed('/task-screen');
  // }
}
