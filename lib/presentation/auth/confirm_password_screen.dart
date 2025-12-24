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

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
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
                              CustomTextField(
                                "Enter your password",
                                "password",
                              ),
                              SizedBox(height: 25),
                              CText(
                                "Confirm Password",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                "Enter your confirm password",
                                "confirm-password",
                              ),

                              SizedBox(height: 30),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
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
          controller:
              (label == "password")
                  ? provider.password
                  : provider.confirmPassword,
          obscureText:
              (label == "password")
                  ? provider.passwordVisibility
                  : (label == "confirm-password")
                  ? provider.confirPasswordVisibility
                  : false,
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
            suffixIcon: IconButton(
              onPressed: () {
                provider.changeVisibility(label);
              },
              icon: Icon(
                (label == "password" && provider.passwordVisibility) ||
                        (label == "confirm-password" &&
                            provider.confirPasswordVisibility)
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: appTheme.lightGrey,
                size: 20,
              ),
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return '$label is required';
            }
            if (label == "confirm-password" &&
                provider.password.text != provider.confirmPassword.text) {
              return "Passwords do not match";
            }
            return null;
          },
        );
      },
    );
  }
}
