import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

import '../widgets/auth_custom_text_field.dart';
import '../widgets/password_text_field.dart';

class SignupScreen extends HookWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return Scaffold(
      body: Container(
        width: SizeUtils.width,
        height: SizeUtils.height,
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
              height: SizeUtils.width * 0.2,
            ),
            SizedBox(height: 50),
            Expanded(
              child: Form(
                key: formKey,
                child: Container(
                  // alignment: Alignment.center,
                  width: SizeUtils.width,
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
                                  "Create Account",
                                  weight: FontWeight.w800,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: CText(
                                  "Enter your details to get started",
                                  color: appTheme.grey,
                                  weight: FontWeight.w300,
                                  size: 14,
                                ),
                              ),
                              SizedBox(height: 30),
                              CText(
                                "Full Name",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              AuthCustomTextField(
                                controller: fullNameController,
                                hintText: 'Enter your full name',
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(height: 25),
                              CText(
                                "Phone Number",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              AuthCustomTextField(
                                controller: phoneNumberController,
                                hintText: 'Enter your phone number',
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 25),
                              CText(
                                "Email",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              AuthCustomTextField(
                                controller: emailController,
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }

                                  final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  );

                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 25),
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
                              SizedBox(height: 8),
                              SizedBox(height: 30),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AppNavigator.goNamed(
                                      AppRoutes.wouldYouLike,
                                    );
                                  }
                                },
                                text: "Sign Up",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1.3,
                                    width: 85,
                                    color: appTheme.veryLightGrey,
                                  ),
                                  SizedBox(width: 10),
                                  CText(
                                    "Or",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 1.3,
                                    width: 85,
                                    color: appTheme.veryLightGrey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.fbIcon,
                                    height: SizeUtils.height * 0.09,
                                  ),
                                  SizedBox(width: 25),
                                  CustomImageView(
                                    imagePath: ImageConstant.googleIcon,
                                    height: SizeUtils.height * 0.09,
                                  ),
                                  SizedBox(width: 25),
                                  CustomImageView(
                                    imagePath: ImageConstant.appleIcon,
                                    height: SizeUtils.height * 0.09,
                                  ),
                                ],
                              ),
                              SizedBox(height: 35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CText(
                                    "Already have an account? ",
                                    size: 15,
                                    color: appTheme.grey,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigator.goNamed(AppRoutes.login);
                                    },
                                    child: CText(
                                      "Sign In",
                                      size: 15,
                                      color: appTheme.primaryColor,
                                      weight: FontWeight.w900,
                                    ),
                                  ),
                                ],
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
