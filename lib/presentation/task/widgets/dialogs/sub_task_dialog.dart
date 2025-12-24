import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';

final formKey = GlobalKey<FormState>();
void addSubTaskPopup(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController subTaskController = TextEditingController();
      return Dialog(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      hGap(32),
                      Expanded(
                        child: CText(
                          "Sub Tasks",
                          textAlign: TextAlign.start,
                          size: 18.sp,
                          weight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // NavigatorService.goBack();
                          AppNavigator.pop();
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: appTheme.lightBlue,
                          child: Icon(
                            Icons.close,
                            color: appTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  vGap(20),

                  Form(
                    key: formKey,
                    child: CustomTextFormField(
                      controller: subTaskController,
                      hintText: "Enter your task",
                    ),
                  ),

                  vGap(15),
                  CustomElevatedButton(
                    text: "+ Add Task",
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
