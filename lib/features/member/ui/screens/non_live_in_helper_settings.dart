import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/features/member/ui/providers/add_member_form_provider.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NonLiveInHelperSettings extends ConsumerWidget {
  const NonLiveInHelperSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    final state = ref.watch(addMemberFormProvider);
    final notifier = ref.read(addMemberFormProvider.notifier);

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: CustomCommonAppBar(title: AppStrings.nonLiveInHelperSettings),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          // GPS Based Check-in/Check-out Section
          CText(
            AppStrings.gpsBasedCheckInOut,
            color: colorScheme.onSurface,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 18.h),

          // Start Time
          CustomTextFormField(
            hintText: AppStrings.startTime,
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
                        hourMinuteTextColor: colorScheme.primary,
                        hourMinuteColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        dayPeriodTextColor: colorScheme.primary,
                        dayPeriodColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        dialHandColor: colorScheme.primary,
                        dialBackgroundColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        entryModeIconColor: colorScheme.primary,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              colorScheme.primary, // Cancel/OK button color
                        ),
                      ),
                      colorScheme: ColorScheme.light(
                        primary: colorScheme.primary, // Active dial
                        onPrimary: Colors.white,
                        onSurface: Colors.black, // Numbers
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (time != null) {
                // set start time with time.format(context)
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
            suffixIcon: Icon(Icons.access_time, color: appColors.grey),
          ),
          SizedBox(height: 15.h),

          // End Time
          CustomTextFormField(
            hintText: AppStrings.endTime,
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
                        hourMinuteTextColor: colorScheme.primary,
                        hourMinuteColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        dayPeriodTextColor: colorScheme.primary,
                        dayPeriodColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        dialHandColor: colorScheme.primary,
                        dialBackgroundColor: colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        entryModeIconColor: colorScheme.primary,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              colorScheme.primary, // Cancel/OK button color
                        ),
                      ),
                      colorScheme: ColorScheme.light(
                        primary: colorScheme.primary, // Active dial
                        onPrimary: Colors.white,
                        onSurface: Colors.black, // Numbers
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (time != null) {
                // set start time with time.format(context)
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
            suffixIcon: Icon(Icons.access_time, color: appColors.grey),
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
                  notifier.setDowntimePreference(val ?? '');
                },
              ),

              CText(
                "Downtime Preference",
                color: colorScheme.onSurface,
                size: 16.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 4.h),
              CText(
                "Downtime between end time and start time next day",
                color: appColors.grey,
                size: 12.sp,
                weight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                hintText: "Enter hours (e.g., 10 hours)",
                initialValue: state.downtimePreference,
                keyboardType: TextInputType.number,
                onChanged: notifier.setDowntimePreference,
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Check-in/Check-out Frequency Section
          CText(
            AppStrings.checkInCheckOutFrequency,
            color: colorScheme.onSurface,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 18.h),

          CustomRadioOption<CheckInOutFrequency>(
            value: CheckInOutFrequency.daily,
            groupValue: state.checkInOutFrequency,
            onChanged: notifier.setCheckInOutFrequency,
            label: AppStrings.daily,
          ),
          SizedBox(height: 15.h),
          CustomRadioOption<CheckInOutFrequency>(
            value: CheckInOutFrequency.weekly,
            groupValue: state.checkInOutFrequency,
            onChanged: notifier.setCheckInOutFrequency,
            label: AppStrings.weekly,
          ),
          SizedBox(height: 15.h),
          CustomRadioOption<CheckInOutFrequency>(
            value: CheckInOutFrequency.custom,
            groupValue: state.checkInOutFrequency,
            onChanged: notifier.setCheckInOutFrequency,
            label: AppStrings.custom,
          ),
          SizedBox(height: 20.h),

          // Overtime Settings Section
          CText(
            AppStrings.overtimeSettings,
            color: colorScheme.onSurface,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 18.h),

          // Eligible for Overtime Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
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
                  color: colorScheme.onSurface,
                  size: 16.sp,
                  weight: FontWeight.w500,
                ),
                CustomToggleSwitch(
                  initialValue: state.eligibleForOvertime,
                  onChanged: notifier.toggleEligibleForOvertime,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          if (state.eligibleForOvertime) ...[
            // Keep track of overtime based on check-out time Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CText(
                      "Would you like us to keep track of Maria's overtime based on check-out time?",
                      color: colorScheme.onSurface,
                      size: 16.sp,
                      weight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  CustomToggleSwitch(
                    initialValue: state.trackOvertimeBasedOnCheckout,
                    onChanged: notifier.toggleTrackOvertimeBasedOnCheckout,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            if (state.trackOvertimeBasedOnCheckout) ...[
              CustomTextFormField(
                hintText: AppStrings.overtimeRatePerHour,
                initialValue: state.overtimeRate,
                onChanged: notifier.setOvertimeRate,
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
                color: colorScheme.onSurface,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              CustomToggleSwitch(
                initialValue: state.deductionSettings,
                onChanged: notifier.toggleDeductionSettings,
              ),
            ],
          ),
          if (state.deductionSettings) ...[
            SizedBox(height: 15.h),
            CustomTextFormField(
              hintText: AppStrings.enterYourDeductionRate,
              initialValue: state.deductionRate,
              onChanged: notifier.setDeductionRate,
              keyboardType: TextInputType.number,
            ),
          ],
          SizedBox(height: 30.h),

          CustomElevatedButton(
            text: AppStrings.continueText,
            height: 50.h,
            width: double.infinity,
            isLoading: state.isLoading,
            onPressed: () async {
              await notifier.submit();

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CText(
                    'Helper added successfully!',
                    color: Colors.white,
                  ),
                  backgroundColor: colorScheme.primary,
                  duration: Duration(seconds: 2),
                ),
              );

              AppNavigator.pop();
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
