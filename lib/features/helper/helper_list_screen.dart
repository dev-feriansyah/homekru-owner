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

class HelperListScreen extends StatefulWidget {
  const HelperListScreen({super.key});

  @override
  State<HelperListScreen> createState() => _HelperListScreenState();
}

class _HelperListScreenState extends State<HelperListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: "Helper"),

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
                          "Helper List",
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
                              // BoxShadow(
                              //   color: appTheme.shadowColor,
                              //   blurRadius: 50,
                              //   offset: const Offset(10, 20),
                              //   spreadRadius: 0,
                              // ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CText(
                                "Helper Name ${index + 1}",
                                size: 16.sp,
                                color: appTheme.grey,
                                weight: FontWeight.w400,
                              ),
                              GestureDetector(
                                onTap:
                                    () => _showHelperSettingsDialog(
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
                          "Add New Helper",
                          style: GoogleFonts.karla(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: appTheme.grey,
                          ),
                        ),
                        hGap(10.w),
                        GestureDetector(
                          onTap: () {
                            AppNavigator.pushNamed(AppRoutes.addMember);
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

  void _showHelperSettingsDialog(BuildContext context, int index) {
    final nameController = TextEditingController(
      text: "Helper Name ${index + 1}",
    );
    final phoneController = TextEditingController(text: "+1 (555) 123-4567");
    String selectedRole = "Helper";
    String liveInStatus = "Live-in";

    final roles = ["Helper", "Senior Helper", "Supervisor"];
    final liveInOptions = ["Live-in", "Non Live-in"];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.shadowColor,
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Handle bar
                            Center(
                              child: Container(
                                width: 40.w,
                                height: 4.h,
                                margin: EdgeInsets.only(bottom: 20.h),
                                decoration: BoxDecoration(
                                  color: appTheme.lightGrey,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),

                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CText(
                                  "Helper Settings",
                                  size: 20.sp,
                                  weight: FontWeight.w600,
                                  color: appTheme.textPrimary,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: appTheme.lightGrey.withValues(
                                        alpha: 0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 20.sp,
                                      color: appTheme.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Helper Name
                            CText(
                              "Helper Name",
                              size: 16.sp,
                              weight: FontWeight.w500,
                              color: appTheme.textPrimary,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(
                                color: appTheme.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: appTheme.offWhite),
                                boxShadow: [
                                  BoxShadow(
                                    color: appTheme.shadowColor,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: nameController,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: appTheme.textPrimary,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter helper's full name",
                                  hintStyle: TextStyle(
                                    color: appTheme.grey,
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Phone Number
                            CText(
                              "Phone Number",
                              size: 16.sp,
                              weight: FontWeight.w500,
                              color: appTheme.textPrimary,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(
                                color: appTheme.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: appTheme.offWhite),
                                boxShadow: [
                                  BoxShadow(
                                    color: appTheme.shadowColor,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: appTheme.textPrimary,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter helper's phone number",
                                  hintStyle: TextStyle(
                                    color: appTheme.grey,
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Role
                            CText(
                              "Role",
                              size: 16.sp,
                              weight: FontWeight.w500,
                              color: appTheme.textPrimary,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(
                                color: appTheme.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: appTheme.offWhite),
                                boxShadow: [
                                  BoxShadow(
                                    color: appTheme.shadowColor,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedRole,
                                decoration: InputDecoration(
                                  hintText: "Select role",
                                  hintStyle: TextStyle(
                                    color: appTheme.grey,
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                                items:
                                    roles
                                        .map(
                                          (role) => DropdownMenuItem(
                                            value: role,
                                            child: CText(
                                              role,
                                              size: 16.sp,
                                              color: appTheme.textPrimary,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (value) =>
                                        setState(() => selectedRole = value!),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Live-in Status
                            CText(
                              "Live-in Status",
                              size: 16.sp,
                              weight: FontWeight.w500,
                              color: appTheme.textPrimary,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(
                                color: appTheme.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: appTheme.offWhite),
                                boxShadow: [
                                  BoxShadow(
                                    color: appTheme.shadowColor,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                initialValue: liveInStatus,
                                decoration: InputDecoration(
                                  hintText: "Select live-in status",
                                  hintStyle: TextStyle(
                                    color: appTheme.grey,
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                                items:
                                    liveInOptions
                                        .map(
                                          (status) => DropdownMenuItem(
                                            value: status,
                                            child: CText(
                                              status,
                                              size: 16.sp,
                                              color: appTheme.textPrimary,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (value) =>
                                        setState(() => liveInStatus = value!),
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Note
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: appTheme.lightBlue.withValues(
                                  alpha: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CText(
                                "Settings: All fields that the user set up when initially adding the helper profile",
                                size: 12.sp,
                                color: appTheme.grey,
                                weight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                      side: BorderSide(color: appTheme.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                    ),
                                    child: CText(
                                      "Cancel",
                                      color: appTheme.grey,
                                      size: 16.sp,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: CText(
                                            "Helper settings updated successfully!",
                                            color: Colors.white,
                                            size: 14.sp,
                                          ),
                                          backgroundColor:
                                              appTheme.primaryColor,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appTheme.primaryColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: CText(
                                      "Save",
                                      color: Colors.white,
                                      size: 16.sp,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ), // Bottom padding for safe area
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          ),
    );
  }
}
