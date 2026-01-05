import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/theme/app_color_extension.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class HelperProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final String score;
  final String statusText;
  final VoidCallback? onEdit;
  final VoidCallback? onStatusTap;

  const HelperProfileCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.score,
    required this.statusText,
    this.onEdit,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColorExtension;

    return Container(
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 50,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CustomImageView(
                imagePath: ImageConstant.maskGroup,
                width: 1.sw * 0.55,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(color: colorScheme.primary, width: 1),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CustomImageView(
                      imagePath: imageUrl,
                      width: 59.w,
                      height: 59.w,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                hGap(12),
                // Info section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        name,
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                        size: 16.sp,
                        weight: FontWeight.w600,
                      ),
                      vGap(5),
                      CText(
                        role,
                        color: appColors.grey,
                        size: 12.sp,
                        weight: FontWeight.w500,
                        height: 1.50,
                      ),
                      vGap(5),
                      CText(
                        "${AppStrings.score}: $score",
                        color: appColors.grey,
                        size: 12.sp,
                        weight: FontWeight.w500,
                        height: 1.50,
                      ),
                      vGap(15),
                      Row(
                        children: [
                          // Status chip
                          GestureDetector(
                            onTap: onStatusTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: ShapeDecoration(
                                color: colorScheme.primaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              child: CText(
                                statusText,
                                textAlign: TextAlign.center,
                                color: colorScheme.primary,
                                size: 14,
                                weight: FontWeight.w700,
                                height: 1.29,
                              ),
                            ),
                          ),
                          hGap(13),
                          // Edit button
                          GestureDetector(
                            onTap: onEdit,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 5,
                              ),
                              decoration: ShapeDecoration(
                                color: colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: CText(
                                AppStrings.edit,
                                textAlign: TextAlign.center,
                                color: colorScheme.surface,
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
