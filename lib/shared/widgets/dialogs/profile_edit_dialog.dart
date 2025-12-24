import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/logger.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';

void showEditDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: appTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title + Close button
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(), // pushes "Edit" to the center
                  CText(
                    "Edit",
                    color: appTheme.textPrimary,
                    size: 18.sp,
                    weight: FontWeight.w600,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 25.w,
                      width: 25.w,
                      decoration: BoxDecoration(
                        color: appTheme.lightBlueTwo,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: appTheme.primaryColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                height: 57.h,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                decoration: ShapeDecoration(
                  color: appTheme.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: appTheme.offWhite),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: appTheme.shadowColor,
                      blurRadius: 50,
                      offset: const Offset(10, 20),
                      spreadRadius: 0,
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    CText(
                      "Image upload",
                      color: appTheme.grey,
                      size: 16.sp,
                      weight: FontWeight.w500,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: appTheme.lightGrey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Name field
              CustomTextFormField(
                controller: TextEditingController(),
                hintText: "Name",
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),

              // Dropdown field
              CustomDropdownWidget(
                selectedValue: "Live-in",
                hintText: "Live-in",
                items: ["Live-in", "Non Live-in"],
                borderColor: appTheme.offWhite,
                onChanged: (val) {
                  Log.d(val);
                },
              ),
              const SizedBox(height: 20),

              // Continue button
              CustomElevatedButton(
                text: AppStrings.continueText,
                height: 50.h,
                width: double.infinity,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    },
  );
}
