import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class CustomCommonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final Color? backgroundColor;
  const CustomCommonAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: backgroundColor ?? Colors.transparent,
      toolbarHeight: 80,
      foregroundColor: appTheme.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: IconButton(
          onPressed: onBackTap ?? () => AppNavigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: CText(
          title,
          size: 18.sp,
          weight: FontWeight.w600,
          color: appTheme.white,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.appBarImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
