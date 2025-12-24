import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class NoteDialog extends StatelessWidget {
  const NoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Close Button
            vGap(10.h),

            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 25.w),
                Center(
                  child: CText(
                    AppStrings.note,
                    size: 20.sp,
                    weight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: appTheme.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 18),
                  ),
                ),
              ],
            ),
            vGap(16.h),

            /// Description
            CText(
              AppStrings.helperProfileSetupLaterNote,
              textAlign: TextAlign.center,
              size: 14.sp,
              color: appTheme.grey,
              weight: FontWeight.w400,
            ),
            vGap(24.h),

            /// Continue Button
            CustomElevatedButton(
              text: AppStrings.continueText,
              height: 50.h,
              width: double.infinity,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            vGap(20.h),
          ],
        ),
      ),
    );
  }
}

void showNoteDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const NoteDialog());
}
