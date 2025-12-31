import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
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
                                  "Verification",
                                  weight: FontWeight.w800,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: CText(
                                  "Enter 6 digits verification code we have send to homekru12@gmail.com",
                                  textAlign: TextAlign.center,
                                  color: appTheme.grey,
                                  weight: FontWeight.w300,
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 35),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OtpTextField(
                                    numberOfFields: 6,
                                    borderColor: appTheme.grey,
                                    focusedBorderColor: appTheme.primaryColor,
                                    fieldWidth: 50,
                                    borderRadius: BorderRadius.circular(15),
                                    showFieldAsBox: true,
                                    onCodeChanged: (String code) {
                                      // Handle intermediate changes if needed
                                    },
                                    onSubmit: (String verificationCode) {
                                      // Handle final submit
                                      debugPrint(
                                        "OTP Entered: $verificationCode",
                                      );
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(height: 30),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // All validations passed
                                    AppNavigator.pushNamed(
                                      AppRoutes.confirmPassword,
                                    );
                                  } else {
                                    // Validation failed, show errors
                                    // Optionally: show a snackbar or toast
                                    print("Validation failed");
                                  }
                                },
                                text: "Verify OTP",
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
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Didn't Receive Code? ",
                                    style: TextStyle(
                                      color: appTheme.grey,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Resend Now",
                                        style: TextStyle(
                                          color: appTheme.primaryColor,
                                          fontFamily: "PoppinsMedium",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
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
