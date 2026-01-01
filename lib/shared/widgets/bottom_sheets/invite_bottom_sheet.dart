import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/helper_detail_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/invite_email_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

enum InviteRole { coOwner, helper }

class InviteBottomSheet extends StatefulWidget {
  const InviteBottomSheet({super.key});

  @override
  State<InviteBottomSheet> createState() => _InviteBottomSheetState();
}

class _InviteBottomSheetState extends State<InviteBottomSheet> {
  InviteRole? _selectedRole = InviteRole.coOwner;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Drag indicator
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

        /// Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CText(
            AppStrings.wouldYouLikeToInvite,
            size: 20.sp,
            weight: FontWeight.w600,
            textAlign: TextAlign.center,
            color: appTheme.textPrimary,
          ),
        ),
        vGap(20.h),

        /// Co-owner option
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomRadioOption<InviteRole>(
            value: InviteRole.coOwner,
            groupValue: _selectedRole,
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            label: AppStrings.coOwner,
            width: double.infinity,
          ),
        ),
        vGap(12.h),

        /// Helper option
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomRadioOption<InviteRole>(
            value: InviteRole.helper,
            groupValue: _selectedRole,
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            label: AppStrings.helper,
            width: double.infinity,
          ),
        ),
        vGap(24.h),

        /// Continue button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomElevatedButton(
            text: AppStrings.continueText,
            height: 50.h,
            width: double.infinity,
            onPressed: () {
              if (_selectedRole == InviteRole.coOwner) {
                // AppNavigator.pushNamed(AppRoutes.coOwner);
                Navigator.pop(context);
                showInviteEmailBottomSheet(context);
              } else {
                Navigator.pop(context);
                showHelperDetailsBottomSheet(context);
              }
            },
          ),
        ),
        vGap(20.h),
      ],
    );
  }
}

/// Call this function from anywhere
void showInviteBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => const InviteBottomSheet(),
  );
}
