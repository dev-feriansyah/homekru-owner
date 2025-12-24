import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/utils/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/date_time_utils.dart';
import 'package:homekru_owner/presentation/bottom_navigation_bar/provider/dashboard_provider.dart';
import 'package:homekru_owner/presentation/member/provider/add_member_provider.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class NonLiveInHelperSettings extends StatefulWidget {
  const NonLiveInHelperSettings({super.key});

  @override
  State<NonLiveInHelperSettings> createState() =>
      _NonLiveInHelperSettingsState();
}

class _NonLiveInHelperSettingsState extends State<NonLiveInHelperSettings> {
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController downtimeController = TextEditingController();
  final TextEditingController overtimeRateController = TextEditingController();
  final TextEditingController deductionRateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMemberProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: appTheme.lightBlue,
          appBar: CustomCommonAppBar(title: AppStrings.nonLiveInHelperSettings),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              // GPS Based Check-in/Check-out Section
              CText(
                AppStrings.gpsBasedCheckInOut,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 18.h),

              // Start Time
              CustomTextFormField(
                hintText: AppStrings.startTime,
                controller: startTimeController,
                keyboardType: TextInputType.phone,
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          timePickerTheme: TimePickerThemeData(
                            backgroundColor: Colors.white,
                            hourMinuteTextColor: appTheme.primaryColor,
                            hourMinuteColor: appTheme.primaryColor.withOpacity(
                              0.2,
                            ),
                            dayPeriodTextColor: appTheme.primaryColor,
                            dayPeriodColor: appTheme.primaryColor.withOpacity(
                              0.2,
                            ),
                            dialHandColor: appTheme.primaryColor,
                            dialBackgroundColor: appTheme.primaryColor
                                .withOpacity(0.2),
                            entryModeIconColor: appTheme.primaryColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  appTheme
                                      .primaryColor, // Cancel/OK button color
                            ),
                          ),
                          colorScheme: ColorScheme.light(
                            primary: appTheme.primaryColor, // Active dial
                            onPrimary: Colors.white,
                            onSurface: Colors.black, // Numbers
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (time != null) {
                    setState(() {
                      startTimeController.text = time.format(context);
                    });
                  }
                },

                // onTap: () async {
                //   TimeOfDay? pickedTime = await showCustomTimePicker(context);
                //   if (pickedTime != null) {
                //     startTimeController.text = DateTimeUtil.formatTime12Hour(
                //       pickedTime.toString(),
                //     );
                //   }
                // },
                suffixIcon: Icon(Icons.access_time, color: appTheme.grey),
              ),
              SizedBox(height: 15.h),

              // End Time
              CustomTextFormField(
                hintText: AppStrings.endTime,
                controller: endTimeController,
                keyboardType: TextInputType.phone,
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          timePickerTheme: TimePickerThemeData(
                            backgroundColor: Colors.white,
                            hourMinuteTextColor: appTheme.primaryColor,
                            hourMinuteColor: appTheme.primaryColor.withOpacity(
                              0.2,
                            ),
                            dayPeriodTextColor: appTheme.primaryColor,
                            dayPeriodColor: appTheme.primaryColor.withOpacity(
                              0.2,
                            ),
                            dialHandColor: appTheme.primaryColor,
                            dialBackgroundColor: appTheme.primaryColor
                                .withOpacity(0.2),
                            entryModeIconColor: appTheme.primaryColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  appTheme
                                      .primaryColor, // Cancel/OK button color
                            ),
                          ),
                          colorScheme: ColorScheme.light(
                            primary: appTheme.primaryColor, // Active dial
                            onPrimary: Colors.white,
                            onSurface: Colors.black, // Numbers
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (time != null) {
                    setState(() {
                      endTimeController.text = time.format(context);
                    });
                  }
                },

                // onTap: () async {
                //   TimeOfDay? pickedTime = await showCustomTimePicker(context);
                //   if (pickedTime != null) {
                //     endTimeController.text = DateTimeUtil.formatTime12Hour(
                //       pickedTime.toString(),
                //     );
                //   }
                // },
                suffixIcon: Icon(Icons.access_time, color: appTheme.grey),
              ),
              SizedBox(height: 15.h),

              // Downtime Preference Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownWidget(
                    selectedValue: null,
                    hintText: AppStrings.downtimePreference,
                    items: [
                      AppStrings.downtimePreference,
                      AppStrings.downtimePreference,
                    ],
                    onChanged: (val) {
                      provider.setDowntimePreference(val ?? '');
                    },
                  ),

                  CText(
                    "Downtime Preference",
                    color: appTheme.textPrimary,
                    size: 16.sp,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 4.h),
                  CText(
                    "Downtime between end time and start time next day",
                    color: appTheme.grey,
                    size: 12.sp,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    hintText: "Enter hours (e.g., 10 hours)",
                    controller: downtimeController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => provider.setDowntimePreference(value),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Check-in/Check-out Frequency Section
              CText(
                AppStrings.checkInCheckOutFrequency,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 18.h),

              CustomRadioOption<CheckInOutFrequency>(
                value: CheckInOutFrequency.daily,
                groupValue: provider.checkInOutFrequency,
                onChanged: (val) => provider.setCheckInOutFrequency(val),
                label: AppStrings.daily,
              ),
              SizedBox(height: 15.h),
              CustomRadioOption<CheckInOutFrequency>(
                value: CheckInOutFrequency.weekly,
                groupValue: provider.checkInOutFrequency,
                onChanged: (val) => provider.setCheckInOutFrequency(val),
                label: AppStrings.weekly,
              ),
              SizedBox(height: 15.h),
              CustomRadioOption<CheckInOutFrequency>(
                value: CheckInOutFrequency.custom,
                groupValue: provider.checkInOutFrequency,
                onChanged: (val) => provider.setCheckInOutFrequency(val),
                label: AppStrings.custom,
              ),
              SizedBox(height: 20.h),

              // Overtime Settings Section
              CText(
                AppStrings.overtimeSettings,
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 18.h),

              // Eligible for Overtime Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: appTheme.white,
                  borderRadius: BorderRadius.circular(15.r),
                  // border: Border.all(
                  //   color: appTheme.primaryColor.withValues(alpha: 0.2),
                  //   width: 1.w,
                  // ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      AppStrings.eligibleForOvertime,
                      color: appTheme.textPrimary,
                      size: 16.sp,
                      weight: FontWeight.w500,
                    ),
                    CustomToggleSwitch(
                      initialValue: provider.eligibleForOvertime,
                      onChanged:
                          (val) => provider.toggleEligibleForOvertime(val),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              if (provider.eligibleForOvertime) ...[
                // Keep track of overtime based on check-out time Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: appTheme.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CText(
                          "Would you like us to keep track of Maria's overtime based on check-out time?",
                          color: appTheme.textPrimary,
                          size: 16.sp,
                          weight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      CustomToggleSwitch(
                        initialValue: provider.trackOvertimeBasedOnCheckout,
                        onChanged:
                            (val) => provider
                                .toggleTrackOvertimeBasedOnCheckout(val),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                if (provider.trackOvertimeBasedOnCheckout) ...[
                  CustomTextFormField(
                    hintText: AppStrings.overtimeRatePerHour,
                    controller: overtimeRateController,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ],
              SizedBox(height: 15.h),

              // Deduction Settings Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    AppStrings.deductionSettings,
                    color: appTheme.textPrimary,
                    size: 18.sp,
                    weight: FontWeight.w500,
                  ),
                  CustomToggleSwitch(
                    initialValue: provider.deductionSettings,
                    onChanged: (val) => provider.toggleDeductionSettings(val),
                  ),
                ],
              ),
              if (provider.deductionSettings) ...[
                SizedBox(height: 15.h),
                CustomTextFormField(
                  hintText: AppStrings.enterYourDeductionRate,
                  controller: deductionRateController,
                  keyboardType: TextInputType.number,
                ),
              ],
              SizedBox(height: 30.h),

              CustomElevatedButton(
                text: AppStrings.continueText,
                height: 50.h,
                width: double.infinity,
                isLoading: provider.isLoading,
                onPressed: () => _handleContinue(provider),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  void _handleContinue(AddMemberProvider provider) async {
    // Show loading
    provider.setLoading(true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Check if widget is still mounted
    if (!mounted) return;

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CText('Helper added successfully!', color: Colors.white),
        backgroundColor: appTheme.primaryColor,
        duration: Duration(seconds: 2),
      ),
    );

    // Clear form
    provider.clearForm();

    // Navigate to members list
    // context.read<DashboardProvider>().onItemTapped(3);
    AppNavigator.pop();
    AppNavigator.pop();
    // AppNavigator.pushNamed(AppRoutes.member);

    // Stop loading
    provider.setLoading(false);
  }
}
