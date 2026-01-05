import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/features/action_item/widgets/redo_parameters_dialog.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    return Container(
      width: 1.sw,
      margin: EdgeInsets.only(bottom: 16.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          width: 1.w,
          color: colorScheme.primary.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
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
                border: Border.all(width: 1.w, color: colorScheme.primary),
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
                        color: colorScheme.onSurface,
                        size: 16.sp,
                        weight: FontWeight.w600,
                        height: 1.38,
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: colorScheme.onSurface,
                      ),
                    ],
                  ),
                  vGap(4),

                  /// Role
                  CText(
                    member.role,
                    color: appColors.grey,
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
                        color: appColors.grey,
                        size: 12.sp,
                        weight: FontWeight.w500,
                        height: 1.50,
                      ),
                      CText(
                        'Tasks - ${member.tasks}',
                        color: appColors.grey,
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
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;
    final chips = <Widget>[];

    if (member.isCheckedIn) {
      chips.add(
        _buildChip(
          dischargeOnTap: () {},
          label: "Checked-in",
          bgColor: colorScheme.primaryContainer,
          textColor: colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (member.isNotCheckedIn) {
      chips.add(
        _buildChip(
          dischargeOnTap: () {},
          label: "Not checked-in",
          bgColor: appColors.lightPink.withValues(alpha: 0.4),
          textColor: colorScheme.error,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (member.isDayOff) {
      chips.add(
        _buildChip(
          dischargeOnTap: () {},
          label: "Day-off",
          bgColor: appColors.mintGreen,
          textColor: appColors.darkGreen,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (member.isDischarged) {
      chips.add(
        _buildChip(
          dischargeOnTap: () => _showDischargeDialog(context),
          label: "Discharge",
          bgColor: appColors.lightPink.withValues(alpha: 0.4),
          textColor: colorScheme.error,
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
        final colorScheme = Theme.of(context).colorScheme;
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),

          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
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
                        backgroundColor: colorScheme.secondaryContainer,
                        child: Icon(Icons.close, color: colorScheme.primary),
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
                                BorderSide(color: colorScheme.primary),
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
                                color: colorScheme.primary,
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
                              colorScheme.primary,
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
                              color: colorScheme.surface,
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

  // void _confirmDischarge(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: CText(
  //         '${member.name} has been discharged successfully',
  //         color: Colors.white,
  //       ),
  //       backgroundColor: colorScheme.error,
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }
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
      final colorScheme = Theme.of(context).colorScheme;
      final appColors = context.appColorExtension;

      return Dialog(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
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
                          backgroundColor: colorScheme.secondaryContainer,
                          child: Icon(Icons.close, color: colorScheme.primary),
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
                                  hourMinuteTextColor: colorScheme.primary,
                                  hourMinuteColor: colorScheme.primary
                                      .withValues(alpha: 0.2),
                                  dayPeriodTextColor: colorScheme.primary,
                                  dayPeriodColor: colorScheme.primary
                                      .withValues(alpha: 0.2),
                                  dialHandColor: colorScheme.primary,
                                  dialBackgroundColor: colorScheme.primary
                                      .withValues(alpha: 0.2),
                                  entryModeIconColor: colorScheme.primary,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        colorScheme
                                            .primary, // Cancel/OK button color
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
                            color: appColors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: appColors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: appColors.grey.withValues(alpha: 0.2),
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
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CText(
                        'Save',
                        textAlign: TextAlign.center,
                        size: 16,
                        color: colorScheme.surface,
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
