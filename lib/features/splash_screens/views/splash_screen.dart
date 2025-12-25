import 'package:flutter/material.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // NavigatorService.pushReplacement(AppRoutes.onBoarding);
      AppNavigator.goNamed(AppRoutes.onBoarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: CustomImageView(
            imagePath: ImageConstant.appLogo,
            width: SizeUtils.width * 0.5,
          ),
        ),
      ),
    );
  }
}
