import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/shared/utils/date_time_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';

final formKey = GlobalKey<FormState>();
void addFrequencyPopup(context) {
  // State variables declared outside StatefulBuilder to persist across rebuilds
  String? selectedFrequency;
  String? selectedDuration;
  String? selectedTime;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: StatefulBuilder(
          builder: (context, setState) {
            // Create controller and set its text if we have a selected time
            final TextEditingController timeController =
                TextEditingController();
            if (selectedTime != null) {
              timeController.text = selectedTime!;
            }
            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      hGap(42),
                      Expanded(
                        child: CText(
                          "Select Frequency",
                          textAlign: TextAlign.start,
                          size: 18.sp,
                          weight: FontWeight.w600,
                          color: appTheme.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // NavigatorService.goBack();
                          AppNavigator.pop();
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: appTheme.lightBlue,
                          child: Icon(
                            Icons.close,
                            color: appTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  vGap(20),

                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomDropdownWidget(
                          items: ["Daily", "Weekly", "Monthly"],
                          hintText: "Select frequency",
                          selectedValue: selectedFrequency,
                          onChanged: (value) {
                            setState(() {
                              selectedFrequency = value;
                            });
                          },
                        ),
                        vGap(15),
                        CustomTextFormField(
                          hintText: AppStrings.time,
                          controller: timeController,
                          keyboardType: TextInputType.phone,
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showCustomTimePicker(
                              context,
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedTime =
                                    DateTimeUtil.formatTimeOfDayTo12Hour(
                                      pickedTime,
                                    );
                              });
                            }
                          },
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: appTheme.grey,
                          ),
                        ),
                        vGap(15),
                        CustomDropdownWidget(
                          items: [
                            "15 minutes",
                            "30 minutes",
                            "45 minutes",
                            "1 hour",
                          ],
                          hintText: "Select duration",
                          selectedValue: selectedDuration,
                          onChanged: (value) {
                            setState(() {
                              selectedDuration = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  vGap(15),
                  CustomElevatedButton(
                    text: "Save",
                    onPressed: () {
                      AppNavigator.pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
