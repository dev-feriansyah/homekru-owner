import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/features/dashboard/ui/providers/dashboard_index.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/invite_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/features/home_screen/ui/widgets/household_stats_dashboard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final List<Map<String, dynamic>> actionItemLists = [
  {
    "icon": ImageConstant.camera,
    "title": "Task Proof",
    "subtitle": "Verify Kitchen Cleaning Proof",
  },
  {
    "icon": ImageConstant.deadline,
    "title": "Deadline extension",
    "subtitle": "Verify Kitchen Cleaning Proof",
  },
  {
    "icon": ImageConstant.resource,
    "title": "Resource request",
    "subtitle": "Verify Kitchen Cleaning Proof",
  },
  {
    "icon": ImageConstant.person,
    "title": "Leave request",
    "subtitle": "Verify Kitchen Cleaning Proof",
  },
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardIndexNotifier = ref.read(dashboardIndexProvider.notifier);

    return Scaffold(
      // key: _scaffoldKey,
      // drawer: Sidebar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add member/helper screen
          showInviteBottomSheet(context);
          // AppNavigator.pushNamed(AppRoutes.addMember);
        },
        backgroundColor: appTheme.primaryColor,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(Icons.person_add, color: Colors.white, size: 28.sp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        height: SizeUtils.height,
        width: SizeUtils.width,
        decoration: BoxDecoration(
          color: appTheme.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),

        child: SingleChildScrollView(
          // physics: ( Provider.of<BottomNaviagtionProvider>(context,listen: false).isDrawerOpen)?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomImageView(
                  imagePath: ImageConstant.ellipse,
                  height: SizeUtils.height * 0.45, // 🔹 Control height here
                  width: SizeUtils.width,
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 50),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: appTheme.lightBlue,
                                  width: 2,
                                ),
                                // image: DecorationImage(image: AssetImage())
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.profile,
                              ),
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Hello",
                                  size: 24,
                                  weight: FontWeight.bold,
                                  color: appTheme.white,
                                  fontFamily: "PoppinsMedium",
                                ),
                                CText(
                                  "Maria Johnson",
                                  size: 18.sp,
                                  weight: FontWeight.w500,
                                  color: appTheme.white,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.pushNamed(AppRoutes.notification);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: appTheme.primaryColor.withValues(
                                  alpha: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.notification,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CText(
                              "Action Items",
                              size: 18,
                              color: appTheme.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AppNavigator.pushNamed(AppRoutes.action);
                              // AppNavigator.pushNamed(AppRoutes.taskDetail);
                              // showInviteBottomSheet(context);
                              // showInviteEmailBottomSheet(context);
                            },
                            child: CText(
                              // "Invite",
                              "View All",
                              size: 15,
                              color: appTheme.white,
                              weight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 7),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: appTheme.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      // height: 230,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: actionItemLists.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = actionItemLists[index];
                          return ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: appTheme.veryLightGrey,
                              child: CustomImageView(
                                imagePath: item["icon"],
                                //  ImageConstant.camera,
                              ),
                            ),
                            title: CText(
                              item["title"],
                              // "Task Proof",
                              size: 16.sp,
                              weight: FontWeight.bold,
                            ),
                            subtitle: CText(
                              item["subtitle"],
                              // "Verify Kitchen Cleaning Proof",
                              weight: FontWeight.w500,
                              size: 10,
                              color: appTheme.grey,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            "Today's tasks",
                            size: 16.sp,
                            weight: FontWeight.w600,
                            color: appTheme.textPrimary,
                          ),
                          GestureDetector(
                            onTap: () {
                              // provider.onItemTapped(1);
                              AppNavigator.pushNamed(AppRoutes.taskManagement);
                              // showAddRoomBottomSheet(context);
                              // showInviteBottomSheet(context);
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => const NoteDialog(),
                              // );

                              // showHelperDetailsBottomSheet(context);
                            },
                            child: Icon(
                              Icons.add_circle,
                              color: appTheme.primaryColor,
                              size: 30.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUserList(),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _buildTaskList(
                              onViewAllTap: () {
                                dashboardIndexNotifier.set(1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CText(
                          "Current Live Status",
                          size: 16.sp,
                          weight: FontWeight.w600,
                          color: appTheme.textPrimary,
                          // fontFamily: "PoppinsMedium",
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: SizeUtils.height * 0.14,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          // physics: ,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                AppNavigator.pushNamed(
                                  AppRoutes.helperOverview,
                                );
                              },
                              child: Container(
                                width: SizeUtils.width * 0.65,
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  right: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: SizeUtils.height * 0.08,
                                      width: 4,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF83E888),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Avatar
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.profile,
                                        height: 68.h,
                                        width: 68.w,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    // User Info
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            'Rina',
                                            size: 14,
                                            weight: FontWeight.w600,
                                            color: appTheme.textPrimary,
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              hGap(3.w),
                                              CText(
                                                '2h 15m today',
                                                size: 12,
                                                weight: FontWeight.w500,
                                                color: appTheme.grey,
                                              ),
                                            ],
                                          ),
                                          vGap(6.h),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: appTheme.bgGreen,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomImageView(
                                                  imagePath:
                                                      ImageConstant.rightIcon,
                                                  height: 6,
                                                  width: 9,
                                                ),
                                                // Icon(
                                                //   Icons.check,
                                                //   size: 16,
                                                //   color: Colors.black,
                                                // ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Check In",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                  ),
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
                            );
                          },
                        ),
                      ),
                    ),
                    // Household Stats Dashboard
                    const HouseholdStatsDashboard(),
                    // SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return Column(
      children: [
        _buildUserCard("Rina", "8 tasks today", ImageConstant.profile, () {
          AppNavigator.pushNamed(AppRoutes.helperOverview);
        }),
        const SizedBox(height: 12),
        _buildUserCard("Budi", "6 tasks today", ImageConstant.profile, () {
          AppNavigator.pushNamed(AppRoutes.helperOverview);
        }),
      ],
    );
  }

  Widget _buildUserCard(
    String name,
    String task,
    String imageUrl,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 10,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: appTheme.blueAccentCustom.withValues(
              alpha: 0.5,
            ), // Border color
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: appTheme.blueAccentCustom.withValues(
                alpha: 0.03,
              ), // Shadow color
              offset: const Offset(12, 25), // X, Y
              blurRadius: 50, // Blur
              spreadRadius: 0, // Spread
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(imageUrl)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  name,
                  size: 14,
                  weight: FontWeight.w600,
                  color: appTheme.textPrimary,
                ),
                // CText(name, weight: FontWeight.bold, size: 14),
                CText(task, size: 10, color: appTheme.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList({Function? onViewAllTap}) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          //       ListView.builder(
          //         padding: EdgeInsets.all(0),
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         itemCount: 3,
          //         itemBuilder: (context,index){
          //           return Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 6.0),
          //   child: Row(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(6),
          //         decoration: BoxDecoration(
          //           color: appTheme.grey.withValues(alpha: .2),
          //           shape: BoxShape.circle
          //         ),
          //         child: Icon(Icons.error_outline, color: appTheme.grey, size: 18)),
          //       const SizedBox(width: 8),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             CustomText(  "Vaccum",
          //                 weight: FontWeight.bold, size: 12),
          //             CustomText(  "Vina",
          //              size: 10, color: appTheme.grey),
          //           ],
          //         ),
          //       ),
          //       CustomText(  "Due 10AM",
          //         size: 12, color: appTheme.grey),
          //     ],
          //   ),
          // );
          //       },),
          _buildTaskItem(
            ImageConstant.vacuum,
            // Colors.red,
            "Vacuum",
            "Vina",
            "10 AM",
          ),
          _buildTaskItem(
            ImageConstant.feedDog,
            // Colors.green,
            "Feed Dog",
            "Vina",
            "11 AM",
          ),
          _buildTaskItem(
            ImageConstant.cleanKitchen,
            // Colors.grey,
            "Clean Kitchen",
            "Vina",
            "12 AM",
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (onViewAllTap != null) {
                  onViewAllTap();
                }
              },
              child: CText(
                "View All >",
                size: 12,
                color: appTheme.primaryColor,
                weight: FontWeight.bold,
              ),
            ),
            // ),
          ),
          vGap(8.h),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    String? icon,
    // Color iconColor,
    String title,
    String user,
    String time,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            // backgroundColor: ,
            child: CustomImageView(
              imagePath: icon,
              //  ImageConstant.camera,
            ),
          ),
          // Icon(icon, color: iconColor, size: 18..sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  title,
                  weight: FontWeight.w500,
                  size: 12.sp,
                  color: appTheme.textPrimary,
                ),
                Row(
                  children: [
                    // CText(
                    //   user,
                    //   size: 10.sp,
                    //   color: appTheme.grey,
                    //   weight: FontWeight.w500,
                    // ),
                    // hGap(4.w),
                    CText(
                      "Due $time",
                      size: 10.sp,
                      weight: FontWeight.w500,
                      color: appTheme.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
