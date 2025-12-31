import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/domain/value_objects/live_in_status.dart';
import 'package:homekru_owner/shared/domain/value_objects/user_role.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/features/settings/settings_screen.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/task_dropdown.dart';

class AddHelperScreen extends HookWidget {
  const AddHelperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    void onSubmit() {
      if (formKey.currentState?.validate() ?? false) {
        // For now, just pop after validation. Hook API here later.
        AppNavigator.pop();
      }
    }

    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: const CustomCommonAppBar(title: "Add Helper"),
      body: Stack(
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
          SizedBox(
            // color: appTheme.lightBlue,
            height: SizeUtils.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SingleChildScrollView(
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 20,
                //   vertical: 16,
                // ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "Helper",
                        size: 18,
                        weight: FontWeight.bold,
                        fontFamily: "PoppinsMedium",
                      ),
                      vGap(18.h),
                      buildTextField(
                        "Full Name",
                        nameController,
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter full name'
                                    : null,
                      ),

                      vGap(12.h),
                      buildTextField(
                        "Email",
                        emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          final emailRegex = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      vGap(12.h),
                      TaskDropdown(
                        hintText: "Role/Position",
                        selectedTask: null,
                        tasks: UserRole.values.map((e) => e.label).toList(),
                        onChanged: (value) => {},
                      ),
                      vGap(12.h),
                      TaskDropdown(
                        hintText: "Live-in Status",
                        selectedTask: null,
                        tasks: LiveInStatus.values.map((e) => e.label).toList(),
                        onChanged: (value) => {},
                      ),
                      vGap(12.h),
                      TaskDropdown(
                        hintText: "Working House",
                        selectedTask: null,
                        tasks: ['Yes', 'No'],
                        onChanged: (value) => {},
                      ),
                      vGap(12.h),
                      vGap(24.h),
                      CustomElevatedButton(text: 'Submit', onPressed: onSubmit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
