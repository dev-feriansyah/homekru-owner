import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';

final formKey = GlobalKey<FormState>();
void redoParametersPopup(context) {
  String? selectedFrequency;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24),

        child: StatefulBuilder(
          builder: (context, setState) {
            // Create controller and set its text if we have a selected time
            final TextEditingController reasonController =
                TextEditingController();

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      CText(
                        "Define Redo Parameters",
                        size: 18.sp,
                        weight: FontWeight.w600,
                        color: appTheme.textPrimary,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // NavigatorService.goBack();
                          AppNavigator.pop();
                        },
                        child: CircleAvatar(
                          radius: 12.5,
                          backgroundColor: appTheme.lightBlue,
                          child: Icon(
                            Icons.close,
                            color: appTheme.primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  vGap(20),

                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomDropdownWidget(
                          items: ["Daily", "Weekly", "Monthly"],
                          hintText: "Select frequency",
                          selectedValue: selectedFrequency,
                          onChanged: (value) {
                            setState(() {
                              selectedFrequency = value;
                            });
                          },
                        ),
                        vGap(15),

                        CustomTextFormField(
                          controller: reasonController,
                          hintText: "Reason for redo/Description for helper",
                          maxLines: 4,
                          minLines: 4,
                        ),
                      ],
                    ),
                  ),

                  vGap(15),
                  CustomElevatedButton(
                    text: "Submit",
                    onPressed: () {
                      AppNavigator.pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
