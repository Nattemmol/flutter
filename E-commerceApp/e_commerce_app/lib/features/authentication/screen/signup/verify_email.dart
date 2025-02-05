import 'package:e_commerce_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_commerce_app/features/authentication/screen/login/login.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(()=> const LoginScreen()), icon: const Icon(CupertinoIcons.clear)),
        ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(NSizes.defaultSpace),
          child: Column(
            children: [
              Image(image: AssetImage(NImages.deliveredEmailIllustration),
              width: NHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: NSizes.spaceBtwSections),

              Text(NTexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: NSizes.spaceBtwItems),
              Text('nattemmol@gmail.com', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: NSizes.spaceBtwItems),
              Text(NTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: NSizes.spaceBtwSections),

              SizedBox(width: double.infinity, child: ElevatedButton(
                onPressed: () =>Get.to(() => SuccessScreen(
                image: NImages.staticSuccessIllustration,
                title: NTexts.yourAccountCreatedTitle,
                subTitle: NTexts.yourAccountCreatedSubTitle,
                onPressed: () => Get.to(() => LoginScreen()),
                )),
              child: const Text(NTexts.nContinue),
              ),),
              const SizedBox(height: NSizes.spaceBtwItems),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () {  },
              child: const Text(NTexts.resendEmail),
              ),),
          ],
          ),
          ),
      ),
    );
  }
}