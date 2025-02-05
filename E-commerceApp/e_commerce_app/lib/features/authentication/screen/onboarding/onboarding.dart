import 'package:e_commerce_app/features/authentication/screen/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:e_commerce_app/features/authentication/screen/onboarding/widgets/onboarding_next_button.dart';
import 'package:e_commerce_app/features/authentication/screen/onboarding/widgets/onboarding_page.dart';
import 'package:e_commerce_app/features/authentication/screen/onboarding/widgets/onboarding_skip.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.PageController,
          onPageChanged: controller.updatePageIndicator,
          children: [
            OnBoardingPage(
              image: NImages.onBoardingImage1,
              title: NTexts.onBoardingTitle1,
              subTitle: NTexts.onBoardingSubTitle1,
            ),
            OnBoardingPage(
              image: NImages.onBoardingImage2,
              title: NTexts.onBoardingTitle2,
              subTitle: NTexts.onBoardingSubTitle2,
            ),
            OnBoardingPage(
              image: NImages.onBoardingImage3,
              title: NTexts.onBoardingTitle3,
              subTitle: NTexts.onBoardingSubTitle3,
            ),
          ],
        ),
        const OnBoardingSkip(),
        const OnBoardingDotNavigation(),
        const OnBoardingNextButton()
      ],
    ));
  }
}
