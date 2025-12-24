import 'package:flutter/material.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/utils/image_constant.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/presentation/auth/provider/create_household_provider.dart';
import 'package:homekru_owner/presentation/auth/provider/login_provider.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CreateHouseholdScreen extends StatefulWidget {
  const CreateHouseholdScreen({super.key});

  @override
  State<CreateHouseholdScreen> createState() => _CreateHouseholdScreenState();
}

class _CreateHouseholdScreenState extends State<CreateHouseholdScreen> {
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
                                "Create House Hold",
                                weight: FontWeight.w800,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: CText(
                                "Let's set up your household details",
                                textAlign: TextAlign.center,
                                color: appTheme.grey,
                                weight: FontWeight.w300,
                                size: 16,
                              ),
                            ),
                            SizedBox(height: 35),
                            CText(
                              "Household Name",
                              textAlign: TextAlign.start,
                              weight: FontWeight.w400,
                              size: 16,
                            ),
                            SizedBox(height: 5),
                            CustomTextField("Enter household name", "password"),
                            SizedBox(height: 20),
                            CText(
                              "Household Type",
                              textAlign: TextAlign.start,
                              weight: FontWeight.w400,
                              size: 16,
                            ),
                            SizedBox(height: 5),
                            Consumer<CreateHouseholdProvider>(
                              builder: (
                                BuildContext context,
                                value,
                                Widget? child,
                              ) {
                                return CustomDropdownField(
                                  items: value.houseHoldType,
                                  selectedItem:
                                      value.houseHoldType.contains(
                                            value.houseHoldTypeValue,
                                          )
                                          ? value.houseHoldTypeValue
                                          : null,
                                  onChanged:
                                      (val) => value.selectHouseHoldType(val),
                                  hintText: "Select type",
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            CText(
                              "Number of Residents",
                              textAlign: TextAlign.start,
                              weight: FontWeight.w400,
                              size: 16,
                            ),
                            SizedBox(height: 5),
                            Consumer<CreateHouseholdProvider>(
                              builder: (
                                BuildContext context,
                                value,
                                Widget? child,
                              ) {
                                return CustomDropdownField(
                                  items: value.noOfResidentsList,
                                  selectedItem:
                                      value.houseHoldType.contains(
                                            value.noOfResidentsValue,
                                          )
                                          ? value.noOfResidentsValue
                                          : null,
                                  onChanged:
                                      (val) => value.selectnoOfResidents(val),
                                  hintText: "Select number",
                                );
                              },
                            ),

                            SizedBox(height: 30),
                            CustomElevatedButton(
                              onPressed: () {
                                AppNavigator.pushNamed(AppRoutes.inviteLink);
                              },
                              text: "Continue",
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
          ],
        ),
      ),
    );
  }

  Widget CustomTextField(hintText, label) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return TextField(
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
        );
      },
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;
  final String hintText;

  const CustomDropdownField({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: items.contains(selectedItem) ? selectedItem : null,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appTheme.veryLightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appTheme.veryLightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appTheme.veryLightGrey),
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down, color: appTheme.lightGrey),
      style: TextStyle(color: appTheme.lightGrey, fontSize: 14),
      hint: CText(hintText, size: 14, color: appTheme.lightGrey),
      items:
          items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: CText(
                item,
                color: appTheme.lightGrey,
                size: 15,
                weight: FontWeight.w400,
              ),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
