import 'package:flutter/material.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';

import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/presentation/auth/provider/login_provider.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                key: _formKey,
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
                                  "Welcome Back",
                                  weight: FontWeight.w800,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: CText(
                                  "Login to your account",
                                  color: appTheme.grey,
                                  weight: FontWeight.w300,
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 30),
                              CText(
                                "Email",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              CustomTextField("Enter your email", "email"),
                              SizedBox(height: 25),
                              CText(
                                "Password",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                "Enter your password",
                                "password",
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Consumer<LoginProvider>(
                                        builder: (context, provider, child) {
                                          return Checkbox(
                                            activeColor: appTheme.primaryColor,
                                            value: provider.keepMeLoggedIn,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            side: BorderSide(
                                              color: appTheme.lightGrey,
                                            ),
                                            onChanged: (bool? newValue) {
                                              provider.changeLogin();
                                            },
                                          );
                                        },
                                      ),

                                      CText(
                                        "Keep me logged in",
                                        color: appTheme.mediumGrey,
                                        size: 12,
                                      ),
                                    ],
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      AppNavigator.pushNamed(
                                        AppRoutes.forgetPassword,
                                      );
                                    },
                                    child: CText(
                                      "Forgot Password?",
                                      weight: FontWeight.bold,
                                      color: appTheme.primaryColor,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // All validations passed
                                    print("+++++++++++++login++++++++++++++");
                                    AppNavigator.goNamed(AppRoutes.dashboard);
                                  } else {
                                    // Validation failed, show errors
                                    // Optionally: show a snackbar or toast
                                    print("Validation failed");
                                  }
                                },
                                text: "Login",
                                buttonTextStyle: TextStyle(
                                  color: appTheme.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                buttonStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    appTheme.primaryColor,
                                  ),
                                  shape: MaterialStateProperty.all(
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
                                    "Don't have an account? ",
                                    size: 15,
                                    color: appTheme.grey,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigator.pushNamed(AppRoutes.signup);
                                    },
                                    child: CText(
                                      "Sign Up",
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

  Widget CustomTextField(hintText, label) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return TextFormField(
          cursorColor: appTheme.lightGrey,
          obscureText:
              (label != "password") ? false : provider.passwordVisibility,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: appTheme.lightGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            // filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appTheme.veryLightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),

              borderSide: BorderSide(color: appTheme.veryLightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appTheme.veryLightGrey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon:
                (label != "password")
                    ? null
                    : IconButton(
                      onPressed: () {
                        provider.changeVisibility(label);
                      },
                      icon: Icon(
                        (provider.passwordVisibility)
                            ? Icons.visibility_off_outlined
                            : Icons.remove_red_eye_outlined,
                      ),
                      color: appTheme.lightGrey,
                      iconSize: 20,
                    ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return '$label is required';
            }

            if (label == "email") {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(val)) {
                return 'Enter a valid email';
              }
            }

            if (label == "password") {
              if (val.length < 6) {
                return 'Password must be at least 6 characters';
              }
            }

            return null;
          },
        );
      },
    );
  }
}
