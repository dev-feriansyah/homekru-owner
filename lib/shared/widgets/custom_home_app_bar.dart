import 'package:flutter/material.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final double? toolbarHeight;
  final String? appHeaderImage;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.toolbarHeight,
    this.appHeaderImage,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      // shadowColor: appTheme.white,
      backgroundColor: Colors.red,
      toolbarHeight: toolbarHeight ?? 80,
      foregroundColor: appTheme.white,

      elevation: 0,
      // leading: Padding(
      //   padding: const EdgeInsets.only(bottom: 15.0),
      //   child: IconButton(
      //     onPressed: onBackTap ?? () => AppNavigator.pop(context),
      //     icon: const Icon(Icons.arrow_back_ios_new_outlined),
      //   ),
      // ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: CText(
          title,
          size: 20,
          weight: FontWeight.bold,
          color: appTheme.white,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(appHeaderImage ?? ImageConstant.appBarImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
      bottom: bottom,
    );
  }
}
