import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);

    final pages = [
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

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          currentPage.value = index;
        },
        itemBuilder: (context, index) {
          return contentWidget(
            context,
            page: pages[index],
            pageController: pageController,
            currentPage: currentPage,
            totalPages: pages.length,
          );
        },
      ),
    );
  }

  Widget contentWidget(
    BuildContext context, {
    required OnboardingPage page,
    required PageController pageController,
    required ValueNotifier<int> currentPage,
    required int totalPages,
  }) {
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
          const SizedBox(height: 30),
          CText(
            page.title,
            size: 19,
            weight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          CText(
            page.subtitle,
            size: 14,
            color: appTheme.grey,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeUtils.height * 0.1),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pageIndicator(page.color, pageController, totalPages),
              GestureDetector(
                onTap: () {
                  if (currentPage.value < totalPages - 1) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  } else {
                    AppNavigator.goNamed(AppRoutes.login);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: page.color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pageIndicator(Color color, PageController controller, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SmoothPageIndicator(
        controller: controller,
        count: count,
        effect: CustomizableEffect(
          activeDotDecoration: DotDecoration(
            width: 14,
            height: 14,
            color: color,
            borderRadius: BorderRadius.circular(20),
            dotBorder: DotBorder(color: color, padding: 3),
          ),
          dotDecoration: DotDecoration(
            width: 6,
            height: 6,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            dotBorder: DotBorder(color: color),
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
