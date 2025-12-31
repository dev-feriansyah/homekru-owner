import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart' show SizeUtils;
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/access_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

enum InviteRole { coOwner, helper }

class InviteEmailBottomSheet extends StatefulWidget {
  const InviteEmailBottomSheet({super.key});

  @override
  State<InviteEmailBottomSheet> createState() => _InviteEmailBottomSheetState();
}

class _InviteEmailBottomSheetState extends State<InviteEmailBottomSheet> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
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
            vGap(20.h),

            /// Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: CText(
                AppStrings.pleaseEnterEmail,
                size: 20.sp,
                weight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: appTheme.textPrimary,
              ),
            ),
            vGap(20.h),

            /// Co-owner option

            /// Helper option
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: buildTextFormField(
                AppStrings.enterYourEmail,
                _emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.pleaseEnterEmail;
                  }
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return AppStrings.enterValidEmail;
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            vGap(24.h),

            /// Continue button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: CustomElevatedButton(
                text: AppStrings.proceedText,
                height: 50.h,
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    showAccessBottomSheet(context);
                  }
                },
              ),
            ),
            vGap(20.h),
          ],
        ),
      ),
    );
  }
}

/// Call this function from anywhere
void showInviteEmailBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder:
        (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const InviteEmailBottomSheet(),
        ),
  );
}

Widget buildTextFormField(
  String label,
  TextEditingController controller, {
  FormFieldValidator<String>? validator,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    readOnly: false,
    style: TextStyle(
      color: appTheme.grey,
      fontSize: 14.sp,
      fontFamily: "Poppins",
    ),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      // label  label,
      hintText: label,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: appTheme.grey,
        // fontFamily: "Poppins",
      ),

      filled: true,
      fillColor: appTheme.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appTheme.offWhite, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appTheme.offWhite, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appTheme.offWhite, width: 2),
      ),
    ),
    validator: validator,
  );
}
