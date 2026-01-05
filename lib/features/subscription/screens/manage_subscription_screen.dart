import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  State<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  String selectedPlan = 'Premium Plan'; // Default selected plan
  String selectedDuration = '6 months'; // Default selected duration

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Height of screen excluding status bar + bottom system insets
    final bodyHeight =
        mediaQuery.size.height -
        mediaQuery.viewPadding.top -
        mediaQuery.viewPadding.bottom;

    return Scaffold(
      appBar: const CustomCommonAppBar(title: 'Manage Subscription'),
      backgroundColor: appColors.lightBlue,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: bodyHeight,
              padding: EdgeInsets.symmetric(horizontal: 20.w),

              child: Column(
                children: [
                  CText(
                    'Choose a plan',
                    textAlign: TextAlign.center,
                    color: appColors.textPrimary,
                    size: 28.sp,
                    weight: FontWeight.w600,
                  ),
                  vGap(8),
                  CText(
                    'Pick the right plan for you',
                    textAlign: TextAlign.center,
                    color: appColors.grey,
                    size: 15.sp,
                    weight: FontWeight.w400,
                  ),
                  vGap(22.h),
                  _PlanCard(
                    title: 'Basic Plan',
                    priceText: '\$299.00',
                    durationText: '/ 3 months',
                    selected: selectedPlan == 'Basic Plan',
                    savePercentage: 'Save 0%',
                    selectedDuration:
                        selectedPlan == 'Basic Plan'
                            ? selectedDuration
                            : '3 months',
                    gradient:
                        selectedPlan == 'Basic Plan'
                            ? const LinearGradient(
                              colors: [
                                Color(0xFF6BA5F5),
                                Color(0xFF2E5BA2),
                                Color(0xFF2E5BA2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                    onTap: () {
                      setState(() {
                        selectedPlan = 'Basic Plan';
                        selectedDuration = '3 months';
                      });
                    },
                  ),
                  vGap(16),
                  _PlanCard(
                    title: 'Premium Plan',
                    priceText: '\$549.00',
                    durationText: '/ 6 months',
                    selected: selectedPlan == 'Premium Plan',
                    savePercentage: 'Save 25%',
                    selectedDuration:
                        selectedPlan == 'Premium Plan'
                            ? selectedDuration
                            : '6 months',
                    gradient:
                        selectedPlan == 'Premium Plan'
                            ? const LinearGradient(
                              colors: [
                                Color(0xFF6BA5F5),
                                Color(0xFF2E5BA2),
                                Color(0xFF2E5BA2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                    onTap: () {
                      setState(() {
                        selectedPlan = 'Premium Plan';
                        selectedDuration = '6 months';
                      });
                    },
                  ),
                  vGap(30.h),
                  CustomElevatedButton(text: 'Subscribe Now', onPressed: () {}),
                  vGap(20.h),
                  CustomElevatedButton(
                    buttonTextStyle: TextStyle(
                      color: appColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                    text: 'Upgrade Plan',
                    buttonStyle: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor: WidgetStateProperty.all(
                        appColors.primaryColor,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: appColors.primaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  // vGap(100.h), // Space for background image
                ],
              ),
            ),
          ),
          // Background wave image
          bottomWaveWidget(),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: CustomImageView(
          //     imagePath: ImageConstant.backgroundImage2,
          //     height: 200.h,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String priceText;
  final String durationText;
  final bool selected;
  final String savePercentage;
  final String selectedDuration;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const _PlanCard({
    required this.title,
    required this.priceText,
    required this.durationText,
    required this.selected,
    required this.savePercentage,
    required this.selectedDuration,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        selected ? appColors.primaryColor : appColors.grey;
    final bool isGradient = gradient != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: gradient,
          borderRadius: BorderRadius.circular(20.r),
          border:
              !isGradient ? Border.all(color: borderColor, width: 1.5) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CText(
                  title,
                  size: 18.sp,
                  weight: FontWeight.w600,
                  color: isGradient ? appColors.white : appColors.textPrimary,
                ),
                hGap(8),
                // Save percentage badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color:
                        isGradient
                            ? appColors.lightYellow
                            : const Color(0x26BDBDBD).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  child: CText(
                    savePercentage,
                    size: 10.sp,
                    weight: FontWeight.w500,
                    color: isGradient ? appColors.amber : appColors.grey,
                  ),
                ),
                Spacer(),
                hGap(8),
                // Radio button
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isGradient ? Colors.white : const Color(0xFF9E9E9E),
                  size: 30.sp,
                ),
              ],
            ),
            vGap(14.h),
            // Duration chips
            Wrap(
              spacing: 8.w,
              children: [
                _Chip(
                  label: 'Monthly',
                  isSelected: selectedDuration == 'Monthly',
                  isGradient: isGradient,
                  onTap: () {
                    if (onTap != null) {
                      // Update duration for current plan
                      if (title == 'Basic Plan') {
                        onTap!();
                      }
                    }
                  },
                ),
                _Chip(
                  label: '3 months',
                  isSelected: selectedDuration == '3 months',
                  isGradient: isGradient,
                  onTap: () {
                    if (onTap != null) {
                      // Update duration for current plan
                      if (title == 'Basic Plan') {
                        onTap!();
                      }
                    }
                  },
                ),
                _Chip(
                  label: '6 months',
                  isSelected: selectedDuration == '6 months',
                  isGradient: isGradient,
                  onTap: () {
                    if (onTap != null) {
                      // Update duration for current plan
                      if (title == 'Premium Plan') {
                        onTap!();
                      }
                    }
                  },
                ),
              ],
            ),
            vGap(14.h),
            // Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CText(
                  priceText,
                  size: 28.sp,
                  weight: FontWeight.w600,
                  color: isGradient ? appColors.white : appColors.textPrimary,
                ),
                SizedBox(width: 6.w),
                CText(
                  durationText,
                  size: 18.sp,
                  weight: FontWeight.w500,
                  color: isGradient ? appColors.white : appColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isGradient;
  final VoidCallback? onTap;

  const _Chip({
    required this.label,
    required this.isSelected,
    required this.isGradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? (isGradient ? Colors.white : appColors.primaryColor)
                  : (isGradient
                      ? Color(0xFFBDBDBD).withValues(alpha: 0.40)
                      : Color(0xFFBDBDBD).withValues(alpha: 0.40)),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color:
                isSelected
                    ? (isGradient ? Colors.white : appColors.primaryColor)
                    : (isGradient ? Colors.white : Color(0xFFBDBDBD)),
          ),
        ),
        child: CText(
          label,
          size: 12.sp,
          color:
              isSelected
                  ? (isGradient ? appColors.primaryColor : Colors.white)
                  : (isGradient ? Colors.white : const Color(0xFF616161)),
          weight: FontWeight.w500,
        ),
      ),
    );
  }
}
