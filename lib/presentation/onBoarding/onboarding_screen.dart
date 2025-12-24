import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/presentation/onBoarding/provider/onBoarding_provider.dart';

import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      backgroundImage: ImageConstant.intro1,
      image: ImageConstant.into1Logo,
      title: "Easily manage your house\nstaff in one place.",
      subtitle: "Easily manage your house staff\nin one place.",
      color: appTheme.intro1,
    ),
    OnboardingPage(
      backgroundImage: ImageConstant.intro2,
      image: ImageConstant.into2Logo,
      title: "Never miss a task, shift, or\nsalary date.",
      subtitle:
          "Plan routines, assign duties, and set\nreminders with just a few taps.",
      color: appTheme.intro2,
    ),
    OnboardingPage(
      backgroundImage: ImageConstant.intro3,
      image: ImageConstant.into3Logo,
      title: "Track attendance and\nperformance with clarity.",
      subtitle:
          "Keep communication clear and build\nbetter working relationships.",
      color: appTheme.intro3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, cild) {
          return PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: provider.onPageChanged,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return contentWidget(page);
            },
          );
        },
      ),
    );
  }

  Widget contentWidget(OnboardingPage page) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(page.backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: page.image,
            height: SizeUtils.height * 0.3,
          ),
          SizedBox(height: 30),
          CText(
            page.title,
            size: 19,
            weight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          CText(
            page.subtitle,
            size: 14,
            color: appTheme.grey,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeUtils.height * 0.1),

          Consumer<OnboardingProvider>(
            builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  pageIndicator(page.color),
                  GestureDetector(
                    onTap: () {
                      if (provider.currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                        );
                        provider.nextPage(_pages.length);
                      } else {
                        AppNavigator.goNamed(AppRoutes.login);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: page.color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget pageIndicator(colorName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: _pages.length,
        effect: CustomizableEffect(
          activeDotDecoration: DotDecoration(
            width: 14, // Larger size when selected
            height: 14,
            color: colorName,
            borderRadius: BorderRadius.circular(20),
            dotBorder: DotBorder(color: colorName, padding: 3),
            // Simulated border using shadow if needed
          ),
          dotDecoration: DotDecoration(
            width: 6,
            height: 6,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            dotBorder: DotBorder(color: colorName),
            // Simulate border: use shadow if border param is missing
            // OR wrap this widget in your own builder if needed
          ),
          spacing: 8,
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String backgroundImage;
  final String image;
  final String title;
  final String subtitle;
  final Color color;

  const OnboardingPage({
    required this.backgroundImage,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
