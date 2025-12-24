import 'package:flutter/material.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/utils/image_constant.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/presentation/auth/provider/login_provider.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                              CustomTextField(
                                "Enter your full name",
                                "name",
                                TextInputType.name,
                              ),
                              SizedBox(height: 25),
                              CText(
                                "Phone Number",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                "Enter your phone number",
                                "phone",
                                TextInputType.number,
                              ),
                              SizedBox(height: 25),
                              CText(
                                "Email",
                                textAlign: TextAlign.start,
                                weight: FontWeight.w400,
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                "Enter your email",
                                "email",
                                TextInputType.emailAddress,
                              ),
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
                                TextInputType.emailAddress,
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
                                TextInputType.emailAddress,
                              ),
                              SizedBox(height: 8),
                              SizedBox(height: 30),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
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

  Widget CustomTextField(hintText, label, keyboardType) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return TextFormField(
          cursorColor: appTheme.lightGrey,
          controller:
              (label == "password")
                  ? provider.password
                  : (label == "confirm-password")
                  ? provider.confirmPassword
                  : null,
          obscureText:
              (label == "password")
                  ? provider.passwordVisibility
                  : (label == "confirm-password")
                  ? provider.confirPasswordVisibility
                  : false,
          keyboardType: keyboardType ?? TextInputType.none,
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
            suffixIcon:
                (label == "password" || label == "confirm-password")
                    ? IconButton(
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
                    )
                    : null,
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
