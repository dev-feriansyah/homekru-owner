import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

enum FilterType { helper, room, time, status }

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  FilterType? selectedFilterType;
  String? selectedSubOption;

  final List<String> helpers = [
    "Sarah Johnson",
    "James Miller",
    "Maria Garcia",
    "David Wilson",
    "Lisa Chen",
  ];

  final List<String> rooms = [
    "Kitchen",
    "Living Room",
    "Bedroom 1",
    "Bedroom 2",
    "Bathroom",
    "Dining Room",
  ];

  final List<String> timeOptions = [
    "Today",
    "Tomorrow",
    "This Week",
    "This Month",
    "Overdue",
  ];

  final List<String> statusOptions = [
    "Pending",
    "In Progress",
    "Completed",
    "Overdue",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            height: 40.h,
            width: 1.sw,
            decoration: BoxDecoration(
              color: appTheme.silver2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Center(
              child: Container(
                width: 90.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),

          vGap(20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                CText(
                  "Filter Tasks",
                  color: appTheme.textPrimary,
                  weight: FontWeight.w600,
                  size: 16.sp,
                ),
                SizedBox(height: 20.h),

                // Step 1: Filter Type Selection
                if (selectedFilterType == null) ...[
                  CText(
                    "Filter by:",
                    color: appTheme.textSecondary,
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 16.h),

                  // Filter type options
                  CustomRadioOption<FilterType>(
                    label: "Helper",
                    value: FilterType.helper,
                    groupValue: selectedFilterType,
                    onChanged: (value) {
                      setState(() {
                        selectedFilterType = value;
                        selectedSubOption = null;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),

                  CustomRadioOption<FilterType>(
                    label: "Room",
                    value: FilterType.room,
                    groupValue: selectedFilterType,
                    onChanged: (value) {
                      setState(() {
                        selectedFilterType = value;
                        selectedSubOption = null;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),

                  CustomRadioOption<FilterType>(
                    label: "Time",
                    value: FilterType.time,
                    groupValue: selectedFilterType,
                    onChanged: (value) {
                      setState(() {
                        selectedFilterType = value;
                        selectedSubOption = null;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),

                  CustomRadioOption<FilterType>(
                    label: "Status",
                    value: FilterType.status,
                    groupValue: selectedFilterType,
                    onChanged: (value) {
                      setState(() {
                        selectedFilterType = value;
                        selectedSubOption = null;
                      });
                    },
                  ),
                ],

                // Step 2: Sub-options Selection
                if (selectedFilterType != null) ...[
                  // Back button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilterType = null;
                            selectedSubOption = null;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 16.sp,
                              color: appTheme.primaryColor,
                            ),
                            SizedBox(width: 4.w),
                            CText(
                              "Back",
                              color: appTheme.primaryColor,
                              size: 14.sp,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Sub-options title
                  CText(
                    "Select ${_getFilterTypeName(selectedFilterType!)}:",
                    color: appTheme.textSecondary,
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 16.h),

                  // Sub-options list
                  ..._getSubOptions(selectedFilterType!).map(
                    (option) => Column(
                      children: [
                        CustomRadioOption<String>(
                          label: option,
                          value: option,
                          groupValue: selectedSubOption,
                          onChanged: (value) {
                            setState(() {
                              selectedSubOption = value;
                            });
                          },
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 24.h),

                // Apply Filter button
                if (selectedFilterType != null && selectedSubOption != null)
                  CustomElevatedButton(
                    text: "Apply Filter",
                    onPressed: () {
                      Navigator.pop(context, {
                        'filterType': selectedFilterType,
                        'subOption': selectedSubOption,
                      });
                    },
                  ),

                SizedBox(height: 12.h),

                // Clear action
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilterType = null;
                      selectedSubOption = null;
                    });
                  },
                  child: CText(
                    "Clear All",
                    color: appTheme.primaryColor,
                    weight: FontWeight.w500,
                    size: 14.sp,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterTypeName(FilterType type) {
    switch (type) {
      case FilterType.helper:
        return "Helper";
      case FilterType.room:
        return "Room";
      case FilterType.time:
        return "Time Period";
      case FilterType.status:
        return "Status";
    }
  }

  List<String> _getSubOptions(FilterType type) {
    switch (type) {
      case FilterType.helper:
        return helpers;
      case FilterType.room:
        return rooms;
      case FilterType.time:
        return timeOptions;
      case FilterType.status:
        return statusOptions;
    }
  }
}

Future<dynamic> showFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => const FilterBottomSheet(),
  );
}
