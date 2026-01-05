import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/add_room_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class HomeSetupScreen extends StatelessWidget {
  const HomeSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCommonAppBar(title: 'Home Setup'),
      backgroundColor: appColors.lightBlue,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          _Section(
            title: 'Common Rooms',
            onAdd: () async {
              final result = await showAddRoomBottomSheet(context);
              if (result != null) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Room "${result['roomName']}" added successfully!',
                    ),
                    backgroundColor: appColors.primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }
            },
            items: [
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'kitchen', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'kitchen', image: ImageConstant.room),
            ],
          ),
          const SizedBox(height: 10),
          _Section(
            title: 'Bedrooms',
            onAdd: () async {
              final result = await showAddRoomBottomSheet(context);
              if (result != null) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Room "${result['roomName']}" added successfully!',
                    ),
                    backgroundColor: appColors.primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }
            },
            items: [
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'kitchen', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'kitchen', image: ImageConstant.room),
            ],
          ),
          const SizedBox(height: 10),
          _Section(
            title: 'Outdoor',
            onAdd: () async {
              final result = await showAddRoomBottomSheet(context);
              if (result != null) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Room "${result['roomName']}" added successfully!',
                    ),
                    backgroundColor: appColors.primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }
            },
            items: [
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'kitchen', image: ImageConstant.room),
            ],
          ),
          const SizedBox(height: 10),
          _Section(
            title: 'Pet',
            onAdd: () async {
              final result = await showAddRoomBottomSheet(context);
              if (result != null) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Room "${result['roomName']}" added successfully!',
                    ),
                    backgroundColor: appColors.primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }
            },
            items: [
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'Living Room', image: ImageConstant.room),
              _RoomItem(title: 'kitchen', image: ImageConstant.room),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final VoidCallback onAdd;
  final List<_RoomItem> items;
  const _Section({
    required this.title,
    required this.onAdd,
    required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: CText(
                  title,
                  size: 18.sp,
                  weight: FontWeight.w500,
                  color: appColors.textPrimary,
                ),
              ),
              InkWell(
                onTap: onAdd,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: appColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
        vGap(10.h),
        SizedBox(
          height: 252.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(width: 170.w, child: items[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _RoomItem extends StatelessWidget {
  final String title;
  final String image;
  const _RoomItem({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return
    // Container(
    // decoration: BoxDecoration(
    //   color: Colors.white,
    //   borderRadius: BorderRadius.circular(16),
    //   boxShadow: [
    //     BoxShadow(
    //       color: Colors.black.withValues(alpha: 0.06),
    //       blurRadius: 10,
    //       offset: const Offset(0, 3),
    //     ),
    //   ],
    // ),
    // clipBehavior: Clip.antiAlias,
    // child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: AspectRatio(
              aspectRatio: 162 / 193,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(color: Colors.grey.shade200),
              ),
            ),
          ),
        ),
        vGap(6.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CText(
            title,
            size: 14.sp,
            weight: FontWeight.w500,
            color: appColors.textPrimary,
          ),
        ),
        vGap(2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CText(
            'Lorem ipsum is a dummy or placeholder text.',
            size: 10.sp,
            color: appColors.mediumGrey,
            weight: FontWeight.w400,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        vGap(10.h),
      ],
    );
    // );
  }
}
