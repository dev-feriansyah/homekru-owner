import 'package:flutter/material.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class InviteLinkScreen extends StatefulWidget {
  const InviteLinkScreen({super.key});

  @override
  State<InviteLinkScreen> createState() => _InviteLinkScreenState();
}

class _InviteLinkScreenState extends State<InviteLinkScreen> {
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
                                "Do you have an invite code?",
                                weight: FontWeight.w800,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: CText(
                                "Helper accounts require an invitation\nfrom a homeowner to sign up.",
                                textAlign: TextAlign.center,
                                color: appTheme.grey,
                                weight: FontWeight.w300,
                                size: 16,
                              ),
                            ),

                            SizedBox(height: SizeUtils.height * 0.1),
                            CustomElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    final formKey = GlobalKey<FormState>();
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      insetPadding: EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                      child: Form(
                                        key: formKey,
                                        child: SizedBox(
                                          width: SizeUtils.width * 0.7,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 25,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(width: 26),
                                                    CText(
                                                      "Enter Invite Code",
                                                      size: 16,
                                                      weight: FontWeight.bold,
                                                    ),
                                                    GestureDetector(
                                                      onTap:
                                                          () => Navigator.pop(
                                                            context,
                                                          ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          4,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              appTheme
                                                                  .lightBlueTwo,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                CText(
                                                  "Invite Code",
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(height: 10),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter your invite code',
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            appTheme
                                                                .veryLightGrey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            appTheme
                                                                .veryLightGrey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            appTheme
                                                                .veryLightGrey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 12,
                                                        ),
                                                  ),
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.isEmpty) {
                                                      return 'please enter code';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Your logic
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        AppNavigator.goNamed(
                                                          AppRoutes.login,
                                                        );
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          appTheme.primaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 14,
                                                          ),
                                                    ),
                                                    child: CText(
                                                      "Continue",
                                                      size: 16,
                                                      color: appTheme.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              text: "Yes, I have an invite",
                              buttonTextStyle: TextStyle(
                                color: appTheme.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              buttonStyle: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  appTheme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            CustomElevatedButton(
                              onPressed: () {
                                AppNavigator.pushNamed(
                                  AppRoutes.confirmPassword,
                                );
                              },
                              text: "Yes, I have an invite",
                              buttonTextStyle: TextStyle(
                                color: appTheme.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              buttonStyle: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  appTheme.white,
                                ),

                                side: WidgetStateProperty.all(
                                  BorderSide(color: appTheme.primaryColor),
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
          ],
        ),
      ),
    );
  }
}
