import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

import '../widgets/auth_custom_text_field.dart';

class CreateHouseholdScreen extends HookWidget {
  const CreateHouseholdScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> houseHoldType = ["abc", "xyz", "pqr"];
    final List<String> noOfResidentsList = ["1", "2", "3", "4", "5"];

    final householdController = useTextEditingController();
    final houseHoldTypeController = useState('');
    final noOfResidentsController = useState('');

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
                            AuthCustomTextField(
                              controller: householdController,
                              hintText: 'Enter household name',
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 20),
                            CText(
                              "Household Type",
                              textAlign: TextAlign.start,
                              weight: FontWeight.w400,
                              size: 16,
                            ),
                            SizedBox(height: 5),
                            CustomDropdownField(
                              items: houseHoldType,
                              selectedItem:
                                  houseHoldType.contains(
                                        houseHoldTypeController.value,
                                      )
                                      ? houseHoldTypeController.value
                                      : null,
                              onChanged:
                                  (val) =>
                                      houseHoldTypeController.value = val ?? '',
                              hintText: "Select type",
                            ),
                            SizedBox(height: 20),
                            CText(
                              "Number of Residents",
                              textAlign: TextAlign.start,
                              weight: FontWeight.w400,
                              size: 16,
                            ),
                            SizedBox(height: 5),
                            CustomDropdownField(
                              items: noOfResidentsList,
                              selectedItem:
                                  houseHoldType.contains(
                                        noOfResidentsController.value,
                                      )
                                      ? noOfResidentsController.value
                                      : null,
                              onChanged:
                                  (val) =>
                                      noOfResidentsController.value = val ?? '',
                              hintText: "Select number",
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
          ],
        ),
      ),
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
      initialValue: items.contains(selectedItem) ? selectedItem : null,

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
