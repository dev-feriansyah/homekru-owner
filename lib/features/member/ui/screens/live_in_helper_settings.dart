import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/shared/domain/value_objects/frequency_options.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/logger.dart';
import 'package:homekru_owner/features/member/ui/providers/add_member_form_provider.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_dropdown_widget.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_toggle_switch.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveInHelperSettings extends ConsumerWidget {
  const LiveInHelperSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    final state = ref.watch(addMemberFormProvider);
    final notifier = ref.read(addMemberFormProvider.notifier);

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: CustomCommonAppBar(title: AppStrings.liveInHelperSettings),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          // SizedBox(height: 20.h),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0x333B70B9), width: 1),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  blurRadius: 50,
                  offset: Offset(10, 20),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomImageView(
                      imagePath: ImageConstant.maskGroup,
                      width: 1.sw * 0.55,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      // Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: colorScheme.primary,
                              width: 1,
                            ),
                          ),
                        ),
                        // padding: EdgeInsets.all(1.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CustomImageView(
                            imagePath: ImageConstant.profile,
                            // "https://i.pinimg.com/736x/bf/50/e2/bf50e22082af5810b2976308c721ee5b.jpg",
                            width: 59.w,
                            height: 59.w,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Text info
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: CText(
                                "James Miller",
                                color: colorScheme.onSurface,
                                size: 16.sp,
                                fontFamily: "Poppins",
                                weight: FontWeight.w600,
                                height: 1.38,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CText(
                              AppStrings.maidNonLiveIn,
                              color: appColors.grey,
                              size: 12.sp,
                              weight: FontWeight.w500,
                              height: 1.50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          CText(
            AppStrings.workingHours,
            color: colorScheme.onSurface,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 18.h),
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
            suffixIcon: Icon(Icons.access_time, color: appColors.grey),
          ),
          SizedBox(height: 15.h),
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

          // * Check-in/Check-out Frequency
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                AppStrings.noEndTime,
                color: colorScheme.onSurface,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              CustomToggleSwitch(
                initialValue: true,
                onChanged: (val) {
                  Log.d(val);
                },
              ),
            ],
          ),
          SizedBox(height: 14.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                AppStrings.entitledForDayOff,
                color: colorScheme.onSurface,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              CustomToggleSwitch(
                initialValue: state.entitledForDayOff,
                onChanged: (val) {
                  notifier.toggleEntitledForDayOff(val);
                },
              ),
            ],
          ),
          if (state.entitledForDayOff) ...[
            SizedBox(height: 15.h),
            CustomDropdownWidget(
              selectedValue: null,
              hintText: AppStrings.numberOfDays,
              items: FrequencyOptions.values.map((e) => e.label).toList(),
              onChanged: (val) {
                Log.d(val);
              },
            ),
            SizedBox(height: 15.h),
            CustomRadioOption<CheckInOutFrequency>(
              value: CheckInOutFrequency.daily,
              groupValue: state.checkInOutFrequency,
              onChanged: (val) => notifier.setCheckInOutFrequency(val),
              label: AppStrings.daily,
            ),
            SizedBox(height: 15.h),
            CustomRadioOption<CheckInOutFrequency>(
              value: CheckInOutFrequency.weekly,
              groupValue: state.checkInOutFrequency,
              onChanged: (val) => notifier.setCheckInOutFrequency(val),
              label: AppStrings.weekly,
            ),
            SizedBox(height: 15.h),
            CustomRadioOption<CheckInOutFrequency>(
              value: CheckInOutFrequency.custom,
              groupValue: state.checkInOutFrequency,
              onChanged: (val) => notifier.setCheckInOutFrequency(val),
              label: AppStrings.custom,
            ),
          ],
          SizedBox(height: 20.h),

          //  ___Continue Button_____
          SizedBox(height: 15.h),

          CustomElevatedButton(
            text: AppStrings.continueText,
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
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

// LEGACY CODE: if unused, remove later
// final formKey = GlobalKey<FormState>();
    // void reminderPopup(context) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       final TextEditingController timeController = TextEditingController();
    //       return Dialog(
    //         child: StatefulBuilder(
    //           builder: (context, setState) {
    //             return Container(
    //               padding: EdgeInsets.all(20),
    //               decoration: BoxDecoration(
    //                 color: appTheme.white,
    //                 borderRadius: BorderRadius.circular(25),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       SizedBox(width: 32),
    //                       Expanded(
    //                         child: CText(
    //                           "Custom Time",
    //                           textAlign: TextAlign.center,
    //                           size: 18,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       GestureDetector(
    //                         onTap: () {
    //                           // NavigatorService.goBack();
    //                           AppNavigator.pop();
    //                         },
    //                         child: CircleAvatar(
    //                           radius: 16,
    //                           backgroundColor: appTheme.lightBlueTwo,
    //                           child: Icon(
    //                             Icons.close,
    //                             color: appTheme.primaryColor,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(height: 10),
    //                   CText("Check-in", size: 15, weight: FontWeight.bold),
    //                   SizedBox(height: 10),
    //                   Form(
    //                     key: formKey,
    //                     child: TextFormField(
    //                       controller: timeController,
    //                       readOnly: true,
    //                       onTap: () async {
    //                         final time = await showTimePicker(
    //                           context: context,
    //                           initialTime: TimeOfDay.now(),
    //                           builder: (context, child) {
    //                             return Theme(
    //                               data: Theme.of(context).copyWith(
    //                                 timePickerTheme: TimePickerThemeData(
    //                                   backgroundColor: Colors.white,
    //                                   hourMinuteTextColor:
    //                                       appTheme.primaryColor,
    //                                   hourMinuteColor: appTheme.primaryColor
    //                                       .withValues(alpha: 0.2),
    //                                   dayPeriodTextColor: appTheme.primaryColor,
    //                                   dayPeriodColor: appTheme.primaryColor
    //                                       .withValues(alpha: 0.2),
    //                                   dialHandColor: appTheme.primaryColor,
    //                                   dialBackgroundColor: appTheme.primaryColor
    //                                       .withValues(alpha: 0.2),
    //                                   entryModeIconColor: appTheme.primaryColor,
    //                                 ),
    //                                 textButtonTheme: TextButtonThemeData(
    //                                   style: TextButton.styleFrom(
    //                                     foregroundColor:
    //                                         appTheme
    //                                             .primaryColor, // Cancel/OK button color
    //                                   ),
    //                                 ),
    //                                 colorScheme: ColorScheme.light(
    //                                   primary:
    //                                       appTheme.primaryColor, // Active dial
    //                                   onPrimary: Colors.white,
    //                                   onSurface: Colors.black, // Numbers
    //                                 ),
    //                               ),
    //                               child: child!,
    //                             );
    //                           },
    //                         );

    //                         if (time != null) {
    //                           setState(() {
    //                             timeController.text = time.format(context);
    //                           });
    //                         }
    //                       },

    //                       decoration: InputDecoration(
    //                         hintText: "Time",
    //                         suffixIcon: Icon(Icons.access_time),
    //                         contentPadding: EdgeInsets.symmetric(
    //                           horizontal: 16,
    //                           vertical: 12,
    //                         ),
    //                         border: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(12),
    //                           borderSide: BorderSide(
    //                             color: appTheme.grey.withValues(alpha: 0.2),
    //                           ),
    //                         ),
    //                         enabledBorder: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(12),
    //                           borderSide: BorderSide(
    //                             color: appTheme.grey.withValues(alpha: 0.2),
    //                           ),
    //                         ),
    //                         focusedBorder: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(12),
    //                           borderSide: BorderSide(
    //                             color: appTheme.grey.withValues(alpha: 0.2),
    //                           ),
    //                         ),
    //                       ),
    //                       validator: (val) {
    //                         if (val == null || val.isEmpty) {
    //                           return 'Please select time.';
    //                         }
    //                         return null;
    //                       },
    //                     ),
    //                   ),

    //                   SizedBox(height: 15),
    //                   GestureDetector(
    //                     onTap: () {
    //                       if (formKey.currentState!.validate()) {
    //                         // NavigatorService.goBack();
    //                         AppNavigator.pop();
    //                       } else {}
    //                     },

    //                     child: Container(
    //                       width: 1.sw,
    //                       padding: EdgeInsets.symmetric(vertical: 15),
    //                       decoration: BoxDecoration(
    //                         color: appTheme.primaryColor,
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       child: CText(
    //                         'Save',
    //                         textAlign: TextAlign.center,
    //                         size: 16,
    //                         color: appTheme.white,
    //                         weight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //     },
    //   );
    // }