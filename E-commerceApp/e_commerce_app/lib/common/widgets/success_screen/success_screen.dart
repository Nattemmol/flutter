import 'package:e_commerce_app/common/styles/spacing_styles.dart';
import 'package:e_commerce_app/features/authentication/screen/login/login.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: NSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(children: [
            Image(
              image: AssetImage(NImages.deliveredEmailIllustration),
              width: NHelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(height: NSizes.spaceBtwSections),
            Text(NTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: NSizes.spaceBtwItems),
            Text(NTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: NSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const LoginScreen()),
                child: const Text(NTexts.nContinue),
              ),
            ),
          ])),
    ));
  }
}
