import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/utils/logger.dart';
import 'package:homekru_owner/presentation/task/widgets/dialogs/frequency_dialog.dart';
import 'package:homekru_owner/presentation/task/widgets/dialogs/scope_of_work_dialog.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_assign_dropdown.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/presentation/task/provider/task_management_provider.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart'
    show CustomToggleSwitch;

class SuggestedTasksScreen extends StatefulWidget {
  final TaskManagementProvider provider;

  const SuggestedTasksScreen({super.key, required this.provider});

  @override
  State<SuggestedTasksScreen> createState() => _SuggestedTasksScreenState();
}

class _SuggestedTasksScreenState extends State<SuggestedTasksScreen> {
  String? selectedRoom;
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
              vGap(16.h),
              CustomDropdownWidget(
                borderColor: appTheme.offWhite,
                items: [
                  "Bedroom",
                  "Kitchen",
                  "Bathroom",
                  "Dining room",
                  "Drawing room",
                ],
                hintText: "Select room/zone",
                selectedValue: selectedRoom,
                onChanged: (value) {
                  setState(() {
                    selectedRoom = value;
                  });
                },
              ),

              vGap(24.h),
              _buildSuggestedTasksSection(widget.provider),
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
          'Helper',
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

        // GestureDetector(
        //   onTap: () => _showAssigneeBottomSheet(provider),
        //   child: Container(
        //     width: double.infinity,
        //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        //     decoration: ShapeDecoration(
        //       color: appTheme.white,
        //       shape: RoundedRectangleBorder(
        //         side: BorderSide(width: 0, color: appTheme.white),
        //         borderRadius: BorderRadius.circular(15),
        //       ),

        //       shadows: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.05),
        //           blurRadius: 8,
        //           offset: const Offset(0, 2),
        //         ),
        //       ],
        //     ),

        //     // ),
        //     child: Row(
        //       children: [
        //         Container(
        //           width: 32.w,
        //           height: 32.h,
        //           decoration: BoxDecoration(
        //             color: appTheme.blueAccentCustom.withOpacity(0.2),
        //             shape: BoxShape.circle,
        //           ),
        //           child: Center(
        //             child: CText(
        //               'KC',
        //               size: 16.sp,
        //               weight: FontWeight.w600,
        //               color: appTheme.blueAccentCustom,
        //             ),
        //           ),
        //         ),
        //         SizedBox(width: 12.w),
        //         Expanded(
        //           child: CText(
        //             provider.currentAssignee,
        //             size: 16.sp,
        //             weight: FontWeight.w500,
        //             color: appTheme.textPrimary,
        //           ),
        //         ),
        //         Icon(
        //           Icons.keyboard_arrow_down,
        //           color: appTheme.grey,
        //           size: 20.sp,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSuggestedTasksSection(TaskManagementProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CText(
                'Based on scope of work and recent tasks',
                size: 16.sp,
                weight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            hGap(16.w),
            GestureDetector(
              onTap: () => {scopeOfWorkPopup(context)},
              // _showScopeOfWorkModal(provider),
              child: Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: appTheme.blueAccentCustom,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: appTheme.white,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
        vGap(16.h),
        ...provider.suggestedTasks.asMap().entries.map((entry) {
          final index = entry.key;
          final task = entry.value;
          return _buildSuggestedTaskItem(provider, index, task);
        }).toList(),
        vGap(16.h),
        _buildSelectFrequencyRow(provider),
      ],
    );
  }

  Widget _buildSuggestedTaskItem(
    TaskManagementProvider provider,
    int index,
    Map<String, dynamic> task,
  ) {
    return Column(
      children: [
        Row(
          children: [
            // hGap(12.w),
            Expanded(
              child: CText(
                task['title'],
                size: 16.sp,
                weight: FontWeight.w500,
                color: appTheme.grey,
              ),
            ),
            GestureDetector(
              onTap: () => provider.toggleSuggestedTask(index),
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  // color:
                  //     task['isSelected']
                  //         ? appTheme.blueAccentCustom
                  //         : Colors.white,
                  border: Border.all(
                    color:
                        task['isSelected']
                            ? appTheme.blueAccentCustom
                            : Colors.grey[400]!,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child:
                    task['isSelected']
                        ? Padding(
                          padding: EdgeInsets.all(3.5.w),
                          child: Image.asset(
                            ImageConstant.blueCheck,
                            width: 12.w,
                            height: 12.h,
                          ),
                        )
                        : null,
              ),
            ),

            hGap(40.w),
          ],
        ),
        vGap(12.h),
        _buildRequirePhotoSection(provider),
      ],
    );
  }

  Widget _buildSelectFrequencyRow(TaskManagementProvider provider) {
    return GestureDetector(
      onTap: () {
        addFrequencyPopup(context);
      },
      //  _showSelectFrequencyModal(provider),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CText(
              'Select Frequency',
              size: 16.sp,
              weight: FontWeight.w500,
              color: Colors.black87,
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirePhotoSection(TaskManagementProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CText(
          'Require Photo',
          size: 15.sp,
          weight: FontWeight.w600,
          color: appTheme.grey,
        ),
        hGap(10.w),
        const Spacer(),
        CustomToggleSwitch(
          initialValue: true,
          onChanged: (val) {
            Log.d(val);
          },
        ),
        hGap(40.w),
      ],
    );
  }

  Widget _buildActionButtons(TaskManagementProvider provider) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => {},
          //  _assignTask(provider),
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
          onTap: () => {},

          child: Container(
            width: double.infinity,
            height: 50.h,
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
  void _showAssigneeBottomSheet(TaskManagementProvider provider) {
    final assignees = [
      'James Miller',
      'Sarah Johnson',
      'John Doe',
      'Jane Smith',
    ];

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
                  color: Colors.black87,
                ),
                vGap(20.h),
                ...assignees
                    .map(
                      (assignee) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: appTheme.blueAccentCustom
                              .withOpacity(0.2),
                          child: CText(
                            assignee.split(' ').map((e) => e[0]).join(),
                            size: 14.sp,
                            weight: FontWeight.w600,
                            color: appTheme.blueAccentCustom,
                          ),
                        ),
                        title: CText(
                          assignee,
                          size: 16.sp,
                          weight: FontWeight.w500,
                          color: Colors.black87,
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

  // void _showScopeOfWorkModal(TaskManagementProvider provider) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
  //     ),
  //     builder:
  //         (context) => Container(
  //           padding: EdgeInsets.all(20.w),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 width: 40.w,
  //                 height: 4.h,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[300],
  //                   borderRadius: BorderRadius.circular(2.r),
  //                 ),
  //               ),
  //               SizedBox(height: 20.h),
  //               CText(
  //                 'Scope of work',
  //                 size: 18.sp,
  //                 weight: FontWeight.w600,
  //                 color: Colors.black87,
  //               ),
  //               SizedBox(height: 20.h),
  //               _buildDropdownField('Select helper', provider.selectedHelper, (
  //                 value,
  //               ) {
  //                 provider.updateSelectedHelper(value);
  //               }),
  //               SizedBox(height: 16.h),
  //               _buildDropdownField('Select room', provider.selectedRoom, (
  //                 value,
  //               ) {
  //                 provider.updateSelectedRoom(value);
  //               }),
  //               SizedBox(height: 16.h),
  //               CText(
  //                 'Already added',
  //                 size: 16.sp,
  //                 weight: FontWeight.w600,
  //                 color: Colors.black87,
  //               ),
  //               SizedBox(height: 8.h),
  //               Wrap(
  //                 spacing: 8.w,
  //                 runSpacing: 8.h,
  //                 children:
  //                     provider.alreadyAddedTasks.map((task) {
  //                       return Container(
  //                         padding: EdgeInsets.symmetric(
  //                           horizontal: 12.w,
  //                           vertical: 6.h,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: appTheme.blueAccentCustom,
  //                           borderRadius: BorderRadius.circular(16.r),
  //                         ),
  //                         child: Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             CText(
  //                               task,
  //                               size: 14.sp,
  //                               weight: FontWeight.w500,
  //                               color: Colors.white,
  //                             ),
  //                             SizedBox(width: 4.w),
  //                             GestureDetector(
  //                               onTap: () => provider.removeTaskFromScope(task),
  //                               child: Icon(
  //                                 Icons.close,
  //                                 color: Colors.white,
  //                                 size: 16.sp,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     }).toList(),
  //               ),
  //               SizedBox(height: 16.h),
  //               _buildInputField(
  //                 controller: TextEditingController(text: provider.floorInput),
  //                 hintText: 'Enter your floor',
  //                 onChanged: (value) => provider.updateFloorInput(value),
  //               ),
  //               SizedBox(height: 20.h),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: double.infinity,
  //                   padding: EdgeInsets.symmetric(vertical: 12.h),
  //                   decoration: BoxDecoration(
  //                     color: appTheme.blueAccentCustom,
  //                     borderRadius: BorderRadius.circular(8.r),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(Icons.add, color: Colors.white, size: 20.sp),
  //                       SizedBox(width: 8.w),
  //                       CText(
  //                         'Add',
  //                         size: 16.sp,
  //                         weight: FontWeight.w600,
  //                         color: Colors.white,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20.h),
  //             ],
  //           ),
  //         ),
  //   );
  // }

  // void _showSelectFrequencyModal(TaskManagementProvider provider) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
  //     ),
  //     builder:
  //         (context) => Container(
  //           padding: EdgeInsets.all(20.w),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 width: 40.w,
  //                 height: 4.h,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[300],
  //                   borderRadius: BorderRadius.circular(2.r),
  //                 ),
  //               ),
  //               SizedBox(height: 20.h),
  //               CText(
  //                 'Select Frequency',
  //                 size: 18.sp,
  //                 weight: FontWeight.w600,
  //                 color: Colors.black87,
  //               ),
  //               SizedBox(height: 20.h),

  //               SizedBox(height: 16.h),
  //               _buildInputField(
  //                 controller: TextEditingController(
  //                   text: provider.selectedTime,
  //                 ),
  //                 hintText: 'Time',
  //                 suffixIcon: Icons.access_time,
  //                 onChanged: (value) => provider.updateTime(value),
  //               ),
  //               SizedBox(height: 16.h),
  //               // _buildDropdownField('Duration', provider.selectedDuration, (
  //               //   value,
  //               // ) {
  //               //   provider.updateDuration(value);
  //               // }),
  //               SizedBox(height: 20.h),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: double.infinity,
  //                   padding: EdgeInsets.symmetric(vertical: 12.h),
  //                   decoration: BoxDecoration(
  //                     color: appTheme.blueAccentCustom,
  //                     borderRadius: BorderRadius.circular(8.r),
  //                   ),
  //                   child: Center(
  //                     child: CText(
  //                       'Save',
  //                       size: 16.sp,
  //                       weight: FontWeight.w600,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20.h),
  //             ],
  //           ),
  //         ),
  //   );
  // }

  // Widget _buildInputField({
  //   required TextEditingController controller,
  //   required String hintText,
  //   IconData? suffixIcon,
  //   Function(String)? onChanged,
  // }) {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8.r),
  //       border: Border.all(color: Colors.grey[300]!),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             controller: controller,
  //             onChanged: onChanged,
  //             decoration: InputDecoration(
  //               hintText: hintText,
  //               hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
  //               border: InputBorder.none,
  //               contentPadding: EdgeInsets.zero,
  //             ),
  //           ),
  //         ),
  //         if (suffixIcon != null) ...[
  //           SizedBox(width: 8.w),
  //           Icon(suffixIcon, color: Colors.grey[600], size: 20.sp),
  //         ],
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDropdownField(
  //   String label,
  //   String value,
  //   Function(String) onChanged,
  // ) {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8.r),
  //       border: Border.all(color: Colors.grey[300]!),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: CText(
  //             value.isEmpty ? label : value,
  //             size: 16.sp,
  //             weight: FontWeight.w500,
  //             color: value.isEmpty ? Colors.grey[500] : Colors.black87,
  //           ),
  //         ),
  //         Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 20.sp),
  //       ],
  //     ),
  //   );
  // }

  // void _addMoreTask(TaskManagementProvider provider) {
  //   provider.clearForm();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: CText(
  //         'Form cleared. Ready to add another task!',
  //         color: Colors.white,
  //       ),
  //       backgroundColor: appTheme.blueAccentCustom,
  //     ),
  //   );
  // }

  // void _assignTask(TaskManagementProvider provider) async {
  //   if (!provider.isFormValid()) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: CText(
  //           'Please fill in all required fields',
  //           color: Colors.white,
  //         ),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   await provider.createTask();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: CText('Task assigned successfully!', color: Colors.white),
  //       backgroundColor: appTheme.blueAccentCustom,
  //     ),
  //   );
  //   AppNavigator.pop();
  // }
}
