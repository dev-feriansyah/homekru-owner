import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/widgets/add_fab.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/features/member/ui/widgets/member_card.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    /// 🔹 Members list ===================================
    final members = [
      Member(
        name: "Rina Kapoor",
        role: "Maid",
        imageUrl:
            "https://i.pinimg.com/736x/25/d6/87/25d6870c0ba2b640c4dafb837f5a9dd1.jpg",
        punctuality: "96%",
        tasks: "2/3",
        isCheckedIn: true,
        isDischarged: true,
      ),
      Member(
        name: "James Miller",
        role: "Cook",
        imageUrl:
            "https://i.pinimg.com/736x/67/d4/73/67d473ac5acd3069d909813c79d55942.jpg",
        punctuality: "89%",
        tasks: "3/3",
        isNotCheckedIn: true,
        isDischarged: true,
      ),
      Member(
        name: "Sarah Johnson",
        role: "Cleaner",
        imageUrl:
            "https://i.pinimg.com/736x/25/d6/87/25d6870c0ba2b640c4dafb837f5a9dd1.jpg",
        punctuality: "92%",
        tasks: "1/2",
        isDayOff: true,
        isDischarged: true,
      ),
      Member(
        name: "David Wilson",
        role: "Driver",
        imageUrl:
            "https://i.pinimg.com/736x/67/d4/73/67d473ac5acd3069d909813c79d55942.jpg",
        punctuality: "85%",
        tasks: "3/4",
        isCheckedIn: true,
        isDischarged: true,
      ),
      Member(
        name: "Maria Garcia",
        role: "Cook",
        imageUrl:
            "https://i.pinimg.com/736x/25/d6/87/25d6870c0ba2b640c4dafb837f5a9dd1.jpg",
        punctuality: "94%",
        tasks: "2/3",
        isNotCheckedIn: true,
        isDischarged: true,
      ),
      Member(
        name: "Lisa Chen",
        role: "Maid",
        imageUrl:
            "https://i.pinimg.com/736x/67/d4/73/67d473ac5acd3069d909813c79d55942.jpg",
        punctuality: "88%",
        tasks: "4/5",
        isDayOff: true,
        isDischarged: true,
      ),
    ];
    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      body: Stack(
        children: [
          /// 🔹 Background header image (sirf upar ke liye)
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.appHeaderBg),
                fit: BoxFit.fill,
              ),
            ),
          ),

          /// 🔹 Foreground content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h), // status bar ke liye spacing
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CText(
                  "Members List",
                  size: 18.sp,
                  weight: FontWeight.w600,
                  color: colorScheme.surface,
                ),
              ),
              SizedBox(height: 10.h),

              /// White background ke andar cards
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20.h),

                  itemCount: members.length,
                  itemBuilder:
                      (context, index) => GestureDetector(
                        onTap: () {
                          AppNavigator.pushNamed(AppRoutes.helperOverview);
                        },
                        child: MemberCard(member: members[index]),
                      ),
                ),
                // ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: AddFab(
        onPressed: () {
          AppNavigator.push(AppRoutes.addMember);
        },
      ),
    );

    //  Scaffold(
    //   // appBar:
    //   //  AppBar(title: const Text('Members')),
    //   body: Container(
    //     // height: 130.h,
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage(ImageConstant.appHeaderBg),
    //         // fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: Column(
    //       children: [
    //         CText(
    //           "Members List",
    //           size: 18.sp,
    //           weight: FontWeight.w600,
    //           color: appTheme.white,
    //         ),
    //         Expanded(
    //           child: ListView.builder(
    //             itemCount: members.length,
    //             itemBuilder:
    //                 (context, index) => GestureDetector(
    //                   onTap: () {
    //                     AppNavigator.pushNamed(AppRoutes.helperOverview);
    //                   },
    //                   child: MemberCard(member: members[index]),
    //                 ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: CommonFab(
    //     onPressed: () {
    //       AppNavigator.push(AppRoutes.addMember);
    //     },
    //   ),
    // );
  }
}
