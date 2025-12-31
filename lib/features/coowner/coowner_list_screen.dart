import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';

class CoownerListScreen extends StatefulWidget {
  const CoownerListScreen({super.key});

  @override
  State<CoownerListScreen> createState() => _CoownerListScreenState();
}

class _CoownerListScreenState extends State<CoownerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: "Co-owners"),

      body: Stack(
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
          SizedBox(
            // color: appTheme.lightBlue,
            height: SizeUtils.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          "Co-owners List",
                          size: 18.sp,
                          weight: FontWeight.bold,
                          fontFamily: "PoppinsMedium",
                        ),
                      ],
                    ),
                    vGap(18.h),

                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          margin: EdgeInsets.only(bottom: 20.h),
                          width: SizeUtils.width,
                          decoration: BoxDecoration(
                            color: appTheme.white,
                            borderRadius: BorderRadius.circular(15.r),
                            // border: Border.all(
                            //   color: appTheme.offWhite,
                            //   width: 2.w,
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: appTheme.shadowColor,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CText(
                                "Co-owner Name ${index + 1}",
                                size: 16.sp,
                                color: appTheme.grey,
                                weight: FontWeight.w400,
                              ),
                              GestureDetector(
                                onTap:
                                    () => _showCoOwnerSettingsDialog(
                                      context,
                                      index,
                                    ),
                                child: Icon(
                                  Ionicons.settings_outline,
                                  size: 24.sp,
                                  color: appTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Add New Co-owner",
                          style: GoogleFonts.karla(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: appTheme.grey,
                          ),
                        ),

                        hGap(10.w),
                        GestureDetector(
                          onTap: () {
                            AppNavigator.pushNamed(AppRoutes.addCoOwner);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: appTheme.primaryColor,
                            ),
                            child: Icon(
                              Icons.add,
                              color: appTheme.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    vGap(40.h),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showCoOwnerSettingsDialog(BuildContext context, int index) {
    bool accessTask = false;
    bool accessActionItems = false;
    bool accessCheckInOut = false;
    bool accessOvertime = false;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: CText(
                    "Co-owner Settings",
                    size: 18.sp,
                    weight: FontWeight.w600,
                    color: appTheme.textPrimary,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "Access given for",
                        size: 16.sp,
                        weight: FontWeight.w500,
                        color: appTheme.textPrimary,
                      ),
                      SizedBox(height: 12.h),
                      _buildCheckbox(
                        value: accessTask,
                        onChanged:
                            (v) => setState(() => accessTask = v ?? false),
                        text:
                            'Task management access (create, edit and delete)',
                      ),
                      _buildCheckbox(
                        value: accessActionItems,
                        onChanged:
                            (v) =>
                                setState(() => accessActionItems = v ?? false),
                        text:
                            'Action items access (view, edit and mark completed)',
                      ),
                      _buildCheckbox(
                        value: accessCheckInOut,
                        onChanged:
                            (v) =>
                                setState(() => accessCheckInOut = v ?? false),
                        text:
                            'Check in check out access (discharge, create and edit check in and check out times)',
                      ),
                      _buildCheckbox(
                        value: accessOvertime,
                        onChanged:
                            (v) => setState(() => accessOvertime = v ?? false),
                        text: 'Overtime access (view and mark as paid)',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: CText(
                        "Cancel",
                        color: appTheme.grey,
                        weight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CText(
                              "Co-owner settings updated successfully!",
                              color: Colors.white,
                            ),
                            backgroundColor: appTheme.primaryColor,
                          ),
                        );
                      },
                      child: CText(
                        "Save",
                        color: appTheme.primaryColor,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
          ),
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.w,
            width: 24.w,
            child: Checkbox(
              checkColor: appTheme.white,
              activeColor: appTheme.primaryColor,
              value: value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(color: appTheme.lightGrey),
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: CText(
              text,
              size: 14.sp,
              color: appTheme.grey,
              weight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
