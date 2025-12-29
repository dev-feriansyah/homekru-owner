import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/features/bottom_navigation_bar/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});

  // Navigation + Icons list for Main section
  final List<Map<String, String>> mainNavigationItems = [
    {"title": "Action Items", "icon": ImageConstant.actionItem},
    {"title": "Attendance", "icon": ImageConstant.attendance},
    {"title": "Deduction", "icon": ImageConstant.deduction},
    {"title": "Overtime", "icon": ImageConstant.overtime},
    {"title": "Manage Subscription", "icon": ImageConstant.subscription},
    {"title": "Settings", "icon": ImageConstant.settings},
  ];

  // CMS pages section
  final List<Map<String, String>> cmsItems = [
    {"title": "Terms and Conditions", "icon": ImageConstant.termsCondition},
    {"title": "Privacy Policy", "icon": ImageConstant.policy},
    // {"title": "Blog", "icon": ImageConstant.blog},
    {"title": "FAQs", "icon": ImageConstant.faq},
  ];

  @override
  Widget build(BuildContext context) {
    return
    //  Scaffold(
    //   // backgroundColor: appTheme.primaryColor,
    //   body:
    Container(
      width: SizeUtils.width * 0.8,
      decoration: BoxDecoration(
        color: appTheme.primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<DashboardProvider>(
                    builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: GestureDetector(
                          onTap: () async {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Container(
                            // margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: appTheme.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 15,
                              color: appTheme.primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 20,
                ),
                child: InkWell(
                  onTap: () {
                    AppNavigator.pushNamed(AppRoutes.profile);
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Maria Johnson",
                            color: appTheme.white,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          CText(
                            "Homeowner",
                            color: appTheme.white.withOpacity(0.8),
                            size: 13,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CText(
                  "Main Navigation",
                  color: appTheme.white,
                  weight: FontWeight.bold,
                  fontFamily: "PoppinsMedium",
                ),
              ),
              const SizedBox(height: 10),
              ..._buildDrawerItems(context, mainNavigationItems),
              vGap(12),
              const Divider(color: Colors.white30),
              vGap(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: CText(
                  "About Us",
                  // "CMS Pages",
                  color: appTheme.white,
                  weight: FontWeight.bold,
                  fontFamily: "PoppinsMedium",
                ),
              ),
              const SizedBox(height: 10),
              ..._buildDrawerItems(context, cmsItems),

              vGap(40.h),
              const Divider(color: Colors.white30),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: SizedBox(
                    width: 170.w,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: CustomImageView(
                        imagePath: ImageConstant.logoutIcon,
                        height: 18,
                        width: 16,
                      ),
                      label: CText(
                        "Logout",
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: appTheme.primaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              vGap(10.h),
            ],
          ),
        ),
      ),
    )
    // )
    ;
  }

  List<Widget> _buildDrawerItems(
    BuildContext context,
    List<Map<String, String>> items,
  ) {
    return items.map((item) {
      String title = item["title"] ?? "";
      String iconPath = item["icon"] ?? "";

      return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        title: CText(
          title,
          color: appTheme.white,
          size: 14,
          weight: FontWeight.bold,
        ),
        leading: CustomImageView(
          imagePath: iconPath,
          height: 20,
          width: 20,
          color: Colors.white,
        ),
        onTap: () {
          // Basic navigation logic (expand if needed)
          if (title == "Action Items") {
            AppNavigator.pushNamed(AppRoutes.action);
          } else if (title == "Attendance") {
            AppNavigator.pushNamed(AppRoutes.attendance);
          } else if (title == "Overtime") {
            AppNavigator.pushNamed(AppRoutes.overtimeTracker);
          } else if (title == "Deduction") {
            AppNavigator.pushNamed(AppRoutes.deduction);
          } else if (title == "Manage Subscription") {
            AppNavigator.pushNamed(AppRoutes.manageSubscription);
          } else if (title == "Settings") {
            Scaffold.of(context).openEndDrawer();
            context.read<DashboardProvider>().onItemTapped(3);
          } else if (title == "Terms and Conditions") {
            AppNavigator.pushNamed(AppRoutes.termsConditions);
          } else if (title == "Privacy Policy") {
            AppNavigator.pushNamed(AppRoutes.privacyPolicy);
          } else if (title == "FAQs") {
            AppNavigator.pushNamed(AppRoutes.faqs);
            // } else if (title == "Blog") {
            //   // Navigate to Blog (if implemented)
          }
        },
      );
    }).toList();
  }
}
