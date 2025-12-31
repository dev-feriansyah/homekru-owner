import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/features/task/ui/widgets/action_item.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';

class ActitonCard extends StatelessWidget {
  final String resourceType;
  final String specificItems;
  final String urgency;

  const ActitonCard({
    super.key,
    required this.resourceType,
    required this.specificItems,
    required this.urgency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appTheme.white,
      elevation: 0.1,
      shadowColor: appTheme.offWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: appTheme.white,
        ),
        // padding: EdgeInsets.all(14.r),
        padding: EdgeInsets.only(left: 14.w, bottom: 14.h),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: CustomImageView(
                  imagePath: ImageConstant.taskDetailWave,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vGap(14),
                ActionItem(
                  label: "Requested resource type",
                  value: resourceType,
                ),
                SizedBox(height: 16),
                ActionItem(
                  label: "Specific Items Needed",
                  value: specificItems,
                ),
                SizedBox(height: 16),
                ActionItem(label: "Urgency", value: urgency),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
