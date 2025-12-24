import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/size_utils.dart' show SizeUtils;
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

enum FilterType { time, status }

class SortByFilterBottomSheet extends StatefulWidget {
  const SortByFilterBottomSheet({super.key});

  @override
  State<SortByFilterBottomSheet> createState() =>
      _SortByFilterBottomSheetState();
}

class _SortByFilterBottomSheetState extends State<SortByFilterBottomSheet> {
  FilterType? _selectedRole = FilterType.time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Drag indicator
        Container(
          height: 40.h,
          width: SizeUtils.width,
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
        vGap(14.h),

        /// Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CText(
            AppStrings.sortBy,
            size: 20.sp,
            weight: FontWeight.w600,
            textAlign: TextAlign.center,
            color: appTheme.textPrimary,
          ),
        ),
        vGap(20.h),

        /// Time option
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomRadioOption<FilterType>(
            value: FilterType.time,
            groupValue: _selectedRole,
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            label: AppStrings.time,
            width: double.infinity,
          ),
        ),
        vGap(12.h),

        /// Status option
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomRadioOption<FilterType>(
            value: FilterType.status,
            groupValue: _selectedRole,
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            label: AppStrings.status,
            width: double.infinity,
          ),
        ),
        vGap(24.h),

        /// Continue button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomElevatedButton(
            text: AppStrings.filter,
            height: 50.h,
            width: double.infinity,
            onPressed: () {},
          ),
        ),
        SizedBox(height: 12.h),

        // Clear action
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedRole = null;
            });
          },
          child: CText(
            "Clear",
            color: appTheme.primaryColor,
            weight: FontWeight.w500,
            size: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        vGap(20.h),
      ],
    );
  }
}

/// Call this function from anywhere
void showSortByFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => const SortByFilterBottomSheet(),
  );
}
