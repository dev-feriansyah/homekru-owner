import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/features/action_item/widgets/redo_parameters_dialog.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtils.width,
      margin: EdgeInsets.only(bottom: 16.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          width: 1.w,
          color: appTheme.primaryColor.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.shadowColor,
            blurRadius: 50.r,
            offset: Offset(10.w, 20.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Image
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1.w, color: appTheme.primaryColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Image.network(
                  member.imageUrl,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            hGap(12),

            /// Details Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        member.name,
                        color: appTheme.textPrimary,
                        size: 16.sp,
                        weight: FontWeight.w600,
                        height: 1.38,
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: appTheme.textPrimary,
                      ),
                    ],
                  ),
                  vGap(4),

                  /// Role
                  CText(
                    member.role,
                    color: appTheme.grey,
                    size: 12.sp,
                    weight: FontWeight.w500,
                    height: 1.50,
                  ),
                  vGap(6),

                  /// Punctuality + Tasks
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        'Punctuality - ${member.punctuality}',
                        color: appTheme.grey,
                        size: 12.sp,
                        weight: FontWeight.w500,
                        height: 1.50,
                      ),
                      CText(
                        'Tasks - ${member.tasks}',
                        color: appTheme.grey,
                        size: 12.sp,
                        weight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ],
                  ),

                  vGap(8),

                  /// Status Chips
                  Wrap(spacing: 13.w, children: _buildStatusChips(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds status chips based on member status
  List<Widget> _buildStatusChips(BuildContext context) {
    final chips = <Widget>[];

    if (member.isCheckedIn) {
      chips.add(
        _buildChip(
          dischargeOnTap: () {},
          label: "Checked-in",
          bgColor: appTheme.lightBlue,
          textColor: appTheme.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (member.isNotCheckedIn) {
      chips.add(
        _buildChip(
          dischargeOnTap: () {},
          label: "Not checked-in",
          bgColor: appTheme.lightPink.withValues(alpha: 0.4),
          textColor: appTheme.darkRed,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (member.isDayOff) {
      chips.add(
        _buildChip(
          dischargeOnTap: () {},
          label: "Day-off",
          bgColor: appTheme.mintGreen,
          textColor: appTheme.darkGreen,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (member.isDischarged) {
      chips.add(
        _buildChip(
          dischargeOnTap: () => _showDischargeDialog(context),
          label: "Discharge",
          bgColor: appTheme.lightPink.withValues(alpha: 0.4),
          textColor: appTheme.darkRed,
        ),
      );
    }

    return chips;
  }

  Widget _buildChip({
    required String label,
    required Color bgColor,
    required Color textColor,
    FontWeight fontWeight = FontWeight.w500,
    required VoidCallback dischargeOnTap,
  }) {
    return GestureDetector(
      onTap: dischargeOnTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9.r),
        ),
        child: CText(label, color: textColor, size: 14.sp, weight: fontWeight),
      ),
    );
  }

  void _showDischargeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),

          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appTheme.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 32),
                    Expanded(
                      child: CText(
                        "Discharge",
                        textAlign: TextAlign.center,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // NavigatorService.goBack();
                        AppNavigator.pop();
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: appTheme.lightBlueTwo,
                        child: Icon(Icons.close, color: appTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CText(
                  "Is tomorrow’s check-in time the same as default or custom?",
                  textAlign: TextAlign.center,
                  size: 15,
                  weight: FontWeight.w500,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6), // half of 12
                        child: Material(
                          child: OutlinedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              side: WidgetStateProperty.all(
                                BorderSide(color: appTheme.primaryColor),
                              ),
                            ),
                            onPressed: () {
                              // NavigatorService.goBack();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 15,
                              ),
                              child: CText(
                                "Default",
                                size: 14,
                                color: appTheme.primaryColor,
                                weight: FontWeight.bold,
                                fontFamily: "PoppinsMedium",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6), // half of 12
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              appTheme.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            AppNavigator.pop();
                            reminderPopup(formKey: formKey, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 15,
                            ),
                            child: CText(
                              "Custom",
                              color: appTheme.white,
                              size: 14,
                              weight: FontWeight.bold,
                              fontFamily: "PoppinsMedium",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDischarge(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CText(
          '${member.name} has been discharged successfully',
          color: Colors.white,
        ),
        backgroundColor: appTheme.darkRed,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class Member {
  final String name;
  final String role;
  final String imageUrl;
  final String punctuality;
  final String tasks;
  final bool isCheckedIn;
  final bool isNotCheckedIn;
  final bool isDayOff;
  final bool isDischarged;

  Member({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.punctuality,
    required this.tasks,
    this.isCheckedIn = false,
    this.isNotCheckedIn = false,
    this.isDayOff = false,
    this.isDischarged = false,
  });
}

void reminderPopup(context, {required GlobalKey<FormState> formKey}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController timeController = TextEditingController();
      return Dialog(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 32),
                      Expanded(
                        child: CText(
                          "Custom Time",
                          textAlign: TextAlign.center,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // NavigatorService.goBack();
                          AppNavigator.pop();
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: appTheme.lightBlueTwo,
                          child: Icon(
                            Icons.close,
                            color: appTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CText("Check-in", size: 15, weight: FontWeight.bold),
                  SizedBox(height: 10),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: timeController,
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
                                  hourMinuteColor: appTheme.primaryColor
                                      .withOpacity(0.2),
                                  dayPeriodTextColor: appTheme.primaryColor,
                                  dayPeriodColor: appTheme.primaryColor
                                      .withOpacity(0.2),
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
                            timeController.text = time.format(context);
                          });
                        }
                      },

                      decoration: InputDecoration(
                        hintText: "Time",
                        suffixIcon: Icon(Icons.access_time),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: appTheme.grey.withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: appTheme.grey.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: appTheme.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please select time.';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // NavigatorService.goBack();
                        AppNavigator.pop();
                      } else {}
                    },

                    child: Container(
                      width: SizeUtils.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CText(
                        'Save',
                        textAlign: TextAlign.center,
                        size: 16,
                        color: appTheme.white,
                        weight: FontWeight.bold,
                      ),
                    ),
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
