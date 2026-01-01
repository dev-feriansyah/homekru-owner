import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

import '../widgets/password_text_field.dart';

class ConfirmPasswordScreen extends HookWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            CustomImageView(
              imagePath: ImageConstant.homeKruLogo,
              height: 1.sw * 0.2,
            ),
            SizedBox(height: 50),
            Expanded(
              child: Form(
                key: formKey,
                child: Container(
                  // alignment: Alignment.center,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CText(
                                  "Change Password",
                                  weight: FontWeight.w800,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: CText(
                                  "Re-enter your new password to confirm.",
                                  color: appTheme.grey,
                                  weight: FontWeight.w300,
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 30),

                              CText(
                                "Password",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              PasswordTextField(
                                controller: passwordController,
                                hintText: "Enter your password",
                              ),
                              SizedBox(height: 25),
                              CText(
                                "Confirm Password",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              PasswordTextField(
                                controller: confirmPasswordController,
                                hintText: "Enter your confirm password",
                              ),
                              SizedBox(height: 30),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // NavigatorService.pushNamedAndRemoveUntil(
                                    //   AppRoutes.loginScreen,
                                    // );
                                    AppNavigator.goNamed(AppRoutes.login);
                                  } else {}
                                },
                                text: "Update Password",
                                buttonTextStyle: TextStyle(
                                  color: appTheme.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                buttonStyle: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    appTheme.primaryColor,
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
